//
//  PhotoPickerViewController.swift
//  Continuum
//
//  Created by Julia Frederico on 29/11/22.
//

import UIKit

protocol PhotoPickerViewControllerDelegate: AnyObject {
    func didSelectPhoto(image: UIImage)
}

class PhotoPickerViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    
    // MARK: - Properties
    
    let imagePicker = UIImagePickerController()
    
    weak var delegate: PhotoPickerViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resetViews()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressUploadPhotoButton(_ sender: UIButton) {
        presentImagePickerActionSheet()
    }
    
    // MARK: - Helpers
    
    func presentImagePickerActionSheet() {
        let alert = UIAlertController(title: "Select a photo", message: nil, preferredStyle: .actionSheet)
        
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
            // self.presentErrorAlert(title: "No Camera Access", message: "Please allow camera access in Settings")
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        } else {
            // presentErrorAlert(title: "No Library Access", message: "Please allow photo library access in settings")
        }
    }
    
    func resetViews() {
        photoImageView.image = nil
        uploadPhotoButton.isHidden = false
    }

}

extension PhotoPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            photoImageView.image = image
            uploadPhotoButton.isHidden = true
            delegate?.didSelectPhoto(image: image)
        }
        
        picker.dismiss(animated: true)
        
    }
    
}
