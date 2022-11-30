//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Julia Frederico on 24/11/22.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func didPressShareButton(for post: Post)
    func didReceiveSubscriptionError(_ error: PostError)
}

class PostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var subscriptionButton: UIButton!

    // MARK: - Properties
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: PostTableViewCellDelegate?
    
    // MARK: - Actions
    
    @IBAction func didPressPhotoButtonMultipleTimes(_ sender: UIButton, forEvent event: UIEvent) {
        guard let touch = event.allTouches?.first else { return }
        
        if touch.tapCount >= 2 {
            likePhoto()
        }
    }
    
    @IBAction func didPressLikeButton(_ sender: UIButton) {
        likePhoto()
    }

    @IBAction func didPressShareButton(_ sender: UIButton) {
        guard let post = post else {
            return
        }

        delegate?.didPressShareButton(for: post)
    }
    
    @IBAction func didPressSubscriptionButton(_ sender: UIButton) {
        guard let post = post else {
            return
        }

        PostController.shared.toggleCommentsSubscription(for: post) { success, error in
            if let error = error {
                self.delegate?.didReceiveSubscriptionError(error)
            }
            
            if success {
                self.updateSubscriptionButton(for: post)
            }
        }
    }
    
    // MARK: - Helpers
    
    func updateViews() {
        guard let post = post else { return }
        
        postImageView.image = post.photo
        captionLabel.text = post.caption
        
        let commentCount = post.commentsCount
        updateCommentsLabel(with: commentCount)
        
        Task {
            updateSubscriptionButton(for: post)
        }
    }
    
    func updateSubscriptionButton(for post: Post) {
        PostController.shared.checkCommentsSubscription(for: post) { subscriptionExists in
            DispatchQueue.main.async {
                let title = subscriptionExists ? "Unfollow" : "Follow"
                self.subscriptionButton.setTitle(title, for: .normal)
            }
        }
    }
    
    func updateCommentsLabel(with totalCount: Int) {
        commentsLabel.text = totalCount == 0 ? "No comments yet" : "\(totalCount) comments"
    }
    
    func likePhoto() {
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
}
