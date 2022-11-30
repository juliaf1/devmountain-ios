//
//  PostController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit
import CloudKit

let postsWereSetNotificationName = Notification.Name("postsWereSet")

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
    
    private init() {}
    
    // MARK: - Methods
    
    func fetchComments(for post: Post, completion: @escaping (Result<[Comment], PostError>) -> Void) {
        
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
            NotificationCenter.default.post(name: postsWereSetNotificationName, object: self)

            return completion(.success(comment))
        }
    }
    
}
