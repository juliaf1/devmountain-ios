//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var postPhoto: UIImage? {
        didSet {
            postImageView.image = postPhoto
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resetViews()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressUploadPhotoButton(_ sender: UIButton) {
        postImageView.image = UIImage(named: "spaceEmptyState")
        uploadPhotoButton.setImage(nil, for: .normal)
    }
    
    @IBAction func didPressAddPostButton(_ sender: UIButton) {
        createPost()
    }

    @IBAction func didPressCancelButton(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = NavigationBar.postList.rawValue
    }

    // MARK: - Helpers
    
    func createPost() {
        guard let photo = postPhoto,
              let caption = captionTextField.text,
              !caption.isEmpty else { return }
        
        PostController.shared.createPost(photo: photo, caption: caption) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.tabBarController?.selectedIndex = NavigationBar.postList.rawValue
                case .failure(let error):
                    print(error)
                    // todo: present error to user with alert
                }
            }
        }
    }
    
    func resetViews() {
        postPhoto = nil
        postImageView.image = nil
        uploadPhotoButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        captionTextField.text = ""
    }

}
