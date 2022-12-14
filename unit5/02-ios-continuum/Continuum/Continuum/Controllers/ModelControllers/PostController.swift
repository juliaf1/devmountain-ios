//
//  PostController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit
import CloudKit

let postsWereSetNotificationName = Notification.Name("postsWereSet")
let commentsWereSetNotificationName = Notification.Name("commentsWereSet")

class PostController {
    
    // MARK: - Properties
    
    static let shared = PostController()
    
    var posts: [Post] = [] {
        didSet {
            NotificationCenter.default.post(name: postsWereSetNotificationName, object: self)
        }
    }
    
    var currentUserReference: CKRecord.Reference?
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - Initializer
    
    private init() {
        subscribeToNewPosts { success, _ in
            if success { print("Successfully subscribed to new posts.") }
        }
        
        UserController.fetchAppleUserReference { reference in
            if let reference = reference {
                self.currentUserReference = reference
            }
        }
    }
    
    // MARK: - Methods
    
    func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: PostKeys.recordType, predicate: predicate)
        
        var fetchPosts: [Post] = []
        
        publicDB.fetch(withQuery: query) { result in
            switch result {
            case .success(let successResult):
                successResult.matchResults.forEach { matchTuple in
                    if case .success(let record) = matchTuple.1 {
                        guard let post = Post(ckRecord: record) else { return }
                        fetchPosts.append(post)
                        
                        Task {
                            self.fetchLikes(for: post) { _ in }
                        }
                    }
                }

                self.posts = fetchPosts

                return completion(.success(fetchPosts))
            case .failure(let error):
                return completion(.failure(.thrownError(error)))
            }
        }
    }
    
    func createPost(photo: UIImage, caption: String, completion: @escaping (Result<Post, PostError>) -> Void) {
        let post = Post(photo: photo, caption: caption)
        let record = CKRecord(post: post)
        
        publicDB.save(record) { record, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let record = record,
                  let post = Post(ckRecord: record) else {
                return completion(.failure(.recordError))
            }
            
            self.posts.append(post)
            return completion(.success(post))
        }
    }
    
    private func fetchPostRecord(with recordID: CKRecord.ID) async -> CKRecord? {
        let predicate = NSPredicate(format: "%K == %@", argumentArray: [PostKeys.recordID, recordID])
        let query = CKQuery(recordType: PostKeys.recordType, predicate: predicate)
        
        return await withCheckedContinuation { continuation in
            publicDB.fetch(withQuery: query) { result in
                switch result {
                case .success(let successResult):
                    let recordResult = successResult.matchResults.filter { $0.0 == recordID }
                    
                    if case .success(let record) = recordResult.first?.1 {
                        return continuation.resume(returning: record)
                    }
                case .failure:
                    return continuation.resume(returning: nil)
                }
            }
        }
    }
    
}

extension PostController {
    
    // MARK: - Comments
    
    func addComment(to post: Post, text: String, completion: @escaping (Result<Comment, PostError>) -> Void) {
        let comment = Comment(text: text, postReference: CKRecord.Reference(recordID: post.recordID, action: .deleteSelf))
        let record = CKRecord(comment: comment)
        
        publicDB.save(record) { record, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let record = record,
                  let comment = Comment(ckRecord: record) else {
                return completion(.failure(.recordError))
            }
            
            post.comments.append(comment)
            
            Task {
                // Increment commentsCount by 1
                await self.updateCommentsCount(with: post.commentsCount + 1, post: post)
            }

            return completion(.success(comment))
        }
    }
    
    func fetchComments(for post: Post, completion: @escaping (Result<[Comment], PostError>) -> Void) {
        let postRefence = post.recordID
        let postReferencePredicate = NSPredicate(format: "%K == %@", CommentKeys.postReference, postRefence)
    
        let commentIDs = post.comments.compactMap({$0.recordID})
        let alreadyFetchedCommentsPredicate = NSPredicate(format: "NOT(recordID IN %@)", commentIDs)
    
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [postReferencePredicate, alreadyFetchedCommentsPredicate])
    
        let query = CKQuery(recordType: CommentKeys.recordType, predicate: predicate)
        
        publicDB.fetch(withQuery: query) { result in
            switch result {
            case .success(let successResult):
                successResult.matchResults.forEach { matchTuple in
                    if case .success(let record) = matchTuple.1 {
                        guard let comment = Comment(ckRecord: record) else { return }
                        post.comments.append(comment)
                        NotificationCenter.default.post(name: commentsWereSetNotificationName, object: self)
                    }
                }
                
                Task {
                    if post.commentsCount != post.comments.count {
                        // Fixes commentsCount if value saved on post record is different than the total amount of comments
                        await self.updateCommentsCount(with: post.comments.count, post: post)
                    }
                }
                
                return completion(.success(post.comments))
            case .failure(let error):
                return completion(.failure(.thrownError(error)))
            }
        }
    }
    
    private func updateCommentsCount(with newCount: Int, post: Post) async {
        let postRecord = await fetchPostRecord(with: post.recordID)

        guard let postRecord = postRecord else {
            return print("Error in \(#function): couldn't find CKRecord for \(post)")
        }

        post.commentsCount = newCount
        postRecord.update(post: post)
        
        let operation = CKModifyRecordsOperation(recordsToSave: [postRecord], recordIDsToDelete: nil)
        operation.qualityOfService = .userInteractive
        operation.savePolicy = .changedKeys
        
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success:
                NotificationCenter.default.post(name: postsWereSetNotificationName, object: self)
            case .failure(let error):
                print("Error in \(#function): \(error.localizedDescription)")
            }
        }
        
        publicDB.add(operation)
    }
    
}

extension PostController {
    
    // MARK: - Likes
    
    func fetchLikes(for post: Post, completion: @escaping (Result<[Like], PostError>) -> Void) {
        let predicate = NSPredicate(format: "%K == %@", LikeKeys.postReference, post.recordID)
        let query = CKQuery(recordType: LikeKeys.recordType, predicate: predicate)

        publicDB.fetch(withQuery: query) { result in
            switch result {
            case .success(let successResult):
                successResult.matchResults.forEach { matchTuple in
                    if case .success(let record) = matchTuple.1 {
                        guard let like = Like(ckRecord: record) else { return }
                        post.likes.append(like)
                    }
                }
                
                Task {
                    if post.likesCount != post.likes.count {
                        // Fixes likesCount if value saved on post record is different than the total amount of likes
                        await self.updateLikesCount(with: post.likes.count, post: post)
                    }
                }
                
                NotificationCenter.default.post(name: postsWereSetNotificationName, object: self)
                
                return completion(.success(post.likes))
            case .failure(let error):
                return completion(.failure(.thrownError(error)))
            }
        }
    }

    func toggleLike(for post: Post, completion: @escaping (Result<Like?, PostError>) -> Void) {
        checkIfUserLiked(post: post) { likeExists, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if likeExists {
                self.unlike(post: post) { error in
                    if let error = error {
                        return completion(.failure(error))
                    }
                    
                    return completion(.success(nil))
                }
            } else {
                self.like(post: post) { like, error in
                    if let error = error {
                        return completion(.failure(error))
                    }

                    return completion(.success(like))
                }
            }
        }
    }
    
    private func like(post: Post, completion: @escaping (Like?, PostError?) -> Void) {
        guard let currentUserReference = currentUserReference else {
            return
        }
        
        let postReference = CKRecord.Reference(recordID: post.recordID, action: .deleteSelf)
        let like = Like(postReference: postReference, userReference: currentUserReference)
        
        let record = CKRecord(like: like)
        
        publicDB.save(record) { record, error in
            if let error = error {
                return completion(nil, .thrownError(error))
            }
            
            guard let record = record,
                  let like = Like(ckRecord: record) else {
                return completion(nil, .recordError)
            }
            
            post.likes.append(like)
            
            Task {
                // Increment likesCount by 1
                await self.updateLikesCount(with: post.likesCount + 1, post: post)
            }

            return completion(like, nil)
        }
    }
    
    private func unlike(post: Post, completion: @escaping (PostError?) -> Void) {
        guard let currentUserReference = currentUserReference else { return }
        
        let likes = post.likes.filter { $0.userReference == currentUserReference }
        
        guard let like = likes.first,
              let index = post.likes.firstIndex(of: like) else { return }
        
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [like.recordID])
        
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success:
                post.likes.remove(at: index)
                
                Task {
                    // Deincrement likeCount by 1
                    await self.updateLikesCount(with: post.likesCount - 1, post: post)
                }
                
                return completion(nil)
            case .failure(let error):
                return completion(.thrownError(error))
            }
        }
        
        publicDB.add(operation)
    }
    
    func checkIfUserLiked(post: Post, completion: @escaping (Bool, PostError?) -> Void) {
        guard let currentUserReference = currentUserReference else {
            return completion(false, .userNotFound)
        }
        
        let userLike = post.likes.filter { $0.userReference == currentUserReference }
        
        if userLike.isEmpty {
            return completion(false, nil)
        } else {
            return completion(true, nil)
        }
    }
    
    private func updateLikesCount(with newCount: Int, post: Post) async {
        let postRecord = await fetchPostRecord(with: post.recordID)

        guard let postRecord = postRecord else {
            return print("Error in \(#function): couldn't find CKRecord for \(post)")
        }

        post.likesCount = newCount
        postRecord.update(post: post)
        
        let operation = CKModifyRecordsOperation(recordsToSave: [postRecord], recordIDsToDelete: nil)
        operation.qualityOfService = .userInteractive
        operation.savePolicy = .changedKeys
        
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success:
                NotificationCenter.default.post(name: postsWereSetNotificationName, object: self)
            case .failure(let error):
                print("Error in \(#function): \(error.localizedDescription)")
            }
        }
        
        publicDB.add(operation)
    }

}

extension PostController {
    
    // MARK: - Subscriptions
    
    func toggleCommentsSubscription(for post: Post, completion: @escaping (Bool, PostError?) -> Void) {
        checkCommentsSubscription(for: post) { subscriptionExists in
            if subscriptionExists {
                self.removeCommentsSubcription(from: post) { success, error in
                    if let error = error {
                        return completion(false, .thrownError(error))
                    }
                    
                    return completion(true, nil)
                }
            } else {
                self.subscribeToComments(from: post) { success, error in
                    if let error = error {
                        return completion(false, .thrownError(error))
                    }
                    
                    NotificationCenter.default.post(name: postsWereSetNotificationName, object: self)
                    return completion(true, nil)
                }
            }
        }
    }
    
    func checkCommentsSubscription(for post: Post, completion: @escaping (Bool) -> Void) {
        publicDB.fetch(withSubscriptionID: post.recordID.recordName) { subscription, _ in
            if let _ = subscription {
                return completion(true)
            } else {
                return completion(false)
            }
        }
    }
    
    private func subscribeToComments(from post: Post, completion: @escaping (Bool, PostError?) -> Void) {
        let predicate = NSPredicate(format: "%K == %@", CommentKeys.postReference, post.recordID)
        let subscription = CKQuerySubscription(recordType: CommentKeys.recordType, predicate: predicate, subscriptionID: post.recordID.recordName, options: .firesOnRecordCreation)
        
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.title = "New comment ????"
        notificationInfo.alertBody = "Someone just commented on a post you're following: \(post.caption)"
        notificationInfo.desiredKeys = [CommentKeys.text]
        notificationInfo.shouldSendContentAvailable = true
        
        subscription.notificationInfo = notificationInfo
        
        publicDB.save(subscription) { subscription, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription)")
                return completion(false, .thrownError(error))
            }
            
            return completion(true, nil)
        }
        
    }
    
    private func removeCommentsSubcription(from post: Post, completion: @escaping (Bool, PostError?) -> Void) {
        publicDB.delete(withSubscriptionID: post.recordID.recordName) { _, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription)")
                return completion(false, .thrownError(error))
            }
            
            return completion(true, nil)
        }
    }
    
    private func subscribeToNewPosts(completion: @escaping (Bool, PostError?) -> Void) {
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: PostKeys.recordType, predicate: predicate, subscriptionID: "allPosts", options: .firesOnRecordCreation)
        
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.title = "New post ????"
        notificationInfo.alertBody = "Don't miss out on your friends latest posts."
        
        subscription.notificationInfo = notificationInfo
        
        publicDB.save(subscription) { subscription, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription)")
                return completion(false, .thrownError(error))
            }
            
            return completion(true, nil)
        }
    }
    
}
