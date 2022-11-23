//
//  PhotoPickerViewController.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

protocol PhotoPickerDelegate: AnyObject {
    func didSelectPhoto(image: UIImage)
}

class PhotoPickerViewController: UIViewController {
    
    // MARK: - Properties
    
    let imagePicker = UIImagePickerController()
    
    var delegate: PhotoPickerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Actions

    @IBAction func didPressAddPhotoButton(_ sender: UIButton) {
        presentPhotoPickerAlert()
    }
    
    // MARK: - Helpers
    
    func setupViews() {
        imagePicker.delegate = self
        photoImageView.contentMode = .scaleAspectFill
    }
    
    func presentPhotoPickerAlert() {
        let alert = UIAlertController(title: "Add a photo", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.imagePicker.dismiss(animated: true)
        }

        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        }
    
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.openGallery()
        }
        
        [cancelAction, cameraAction, photoLibraryAction].forEach { alert.addAction($0) }
        
        present(alert, animated: true)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true)
        } else {
            self.presentErrorAlert(title: "No Camera Access", message: "Please allow camera access in Settings")
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        } else {
            presentErrorAlert(title: "No Library Access", message: "Please allow photo library access in settings")
        }
    }

}

extension PhotoPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            delegate?.didSelectPhoto(image: image)
            photoImageView.image = image
        }

        picker.dismiss(animated: true)
    }

}
