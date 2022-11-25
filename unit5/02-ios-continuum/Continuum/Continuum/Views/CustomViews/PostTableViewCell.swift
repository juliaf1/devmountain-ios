//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Julia Frederico on 24/11/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!

    // MARK: - Properties
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Actions

    @IBAction func didDoubleTapPhoto(_ sender: UIButton, forEvent event: UIEvent) {
        guard event.allTouches?.count ?? 0 >= 2 else { return }
        
        // todo: like photo
    }

    @IBAction func didPressLikeButton(_ sender: UIButton) {
    }
    
    @IBAction func didPressShareButton(_ sender: UIButton) {
    }

    // MARK: - Helpers
    
    func updateViews() {
        guard let post = post else { return }
        let commentCount = post.comments.count
        
        postImageView.image = post.photo
        captionLabel.text = post.caption
        commentsLabel.text = commentCount == 0 ? "No comments yet" : "\(commentCount) comments"
    }
    
}
