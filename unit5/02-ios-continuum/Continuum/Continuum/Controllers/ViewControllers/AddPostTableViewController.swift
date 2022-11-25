//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var postPhoto: UIImage?
    
    // MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressUploadPhotoButton(_ sender: UIButton) {
        uploadPhotoButton.setImage(nil, for: .normal)
    }
    
    @IBAction func didPressAddPostButton(_ sender: UIButton) {
        guard let photo = postPhoto,
              let caption = captionTextField.text,
              !caption.isEmpty else { return }
        
        PostController.shared.createPost(photo: photo, caption: caption) { result in
            // todo
        }
    }

    // MARK: - Helpers

}
