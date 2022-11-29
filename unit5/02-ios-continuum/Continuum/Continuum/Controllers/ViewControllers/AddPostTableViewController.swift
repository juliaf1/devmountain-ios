//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // MARK: - Outlets

    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var addPostButton: UIButton!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        updateViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resetViews()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressAddPostButton(_ sender: UIButton) {
        createPost()
    }
    
    @IBAction func didPressCancelButton(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = NavigationBar.postList.rawValue
    }

    // MARK: - Helpers
    
    func createPost() {
        /*
         TODO: Refactor using protocol and delegate pattern
        guard let photo = postImageView.image,
              let caption = captionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
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
         */
    }
    
    func configureViews() {
        captionTextField.delegate = self
    }
    
    func updateViews() {
        addPostButton.layer.cornerRadius = 4
        addPostButton.clipsToBounds = true
    }
    
    func resetViews() {
        captionTextField.text = ""
    }

}

extension AddPostTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
