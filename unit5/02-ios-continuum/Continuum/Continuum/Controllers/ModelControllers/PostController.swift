//
//  PostController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import Foundation

class PostController {
    
    // MARK: - Properties
    
    let shared = PostController()
    
    var posts: [Post] = []
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Methods
    
    func addComment(text: String, post: Post, completion: @escaping (Result<Comment, PostError>) -> Void) {
        let comment = Comment(text: text)
        post.comments.append(comment)
    }
    
}
