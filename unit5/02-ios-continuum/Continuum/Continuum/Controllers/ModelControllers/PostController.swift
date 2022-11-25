//
//  PostController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

let postsWereSetNotificationName = Notification.Name("postsWereSet")

class PostController {
    
    // MARK: - Properties
    
    static let shared = PostController()
    
    var posts: [Post] = [] {
        didSet {
            NotificationCenter.default.post(name: postsWereSetNotificationName, object: self)
        }
    }
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Methods
    
    func createPost(photo: UIImage, caption: String, completion: @escaping (Result<Post, PostError>) -> Void) {
        let post = Post(photo: photo, caption: caption)
        posts.append(post)
    }
    
    func addComment(to post: Post, text: String, completion: @escaping (Result<Comment, PostError>) -> Void) {
        let comment = Comment(text: text)
        post.comments.append(comment)
    }
    
}
