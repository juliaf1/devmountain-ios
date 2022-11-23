//
//  Post.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

class Post {

    // MARK: - Stored Properties

    let timestamp: Date
    let caption: String
    var comments: [Comment]
    
    var photoData: Data?

    // MARK: - Computed Properties

    var photo: UIImage? {
        get {
            guard let photoData = photoData else {
                return nil
            }
            return UIImage(data: photoData)
        } set {
            self.photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    // MARK: - Initializer
    
    init(photo: UIImage, caption: String, comments: [Comment] = [], timestamp: Date = Date()) {
        self.caption = caption
        self.comments = comments
        self.timestamp = timestamp
        self.photo = photo
    }
    
}
