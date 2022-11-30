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
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - Initializer
    
    private init() {
        subscribeToNewPosts(completion: nil)
    }
    
    // MARK: - Methods
    
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
    
    private func subscribeToNewPosts(completion: ((Bool, Error?) -> Void)?) {
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: PostKeys.recordType, predicate: predicate, options: .firesOnRecordCreation)
        
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.title = "UEPA"
        notificationInfo.alertBody = "Don't miss out on your friends latest posts."
        
        subscription.notificationInfo = notificationInfo
        
        publicDB.save(subscription) { subscription, error in
            if let error = error {
                return print("Error in \(#function): \(error.localizedDescription)")
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
                post.commentsCount -= 1
                print("Error in \(#function): \(error.localizedDescription)")
            }
        }
        
        publicDB.add(operation)
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
