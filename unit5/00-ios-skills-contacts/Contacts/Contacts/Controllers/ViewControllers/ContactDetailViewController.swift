//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var contact: Contact?
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactPhoneTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    @IBOutlet weak var saveContactButton: UIButton!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressSaveContactButton(_ sender: UIButton) {
        guard let name = contactNameTextField.text,
              !name.isEmpty else {
            return presentErrorToUser(.missingRequiredParam("contact name"))
        }
        
        saveContactButton.isEnabled = false
        
        let phone = contactPhoneTextField.text
        let email = contactEmailTextField.text
        
        if let contact = contact {
            ContactController.shared.update(contact, name: name, phone: phone, email: email, photo: nil) { error in
                self.handleResponse(error: error)
            }
        } else {
            ContactController.shared.createContact(name: name, phone: phone, email: email, photo: nil) { error in
                self.handleResponse(error: error)
            }
        }
    }
    
    // MARK: - Helpers
    
    func setupViews() {
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 10
        imageContainerView.clipsToBounds = true
        saveContactButton.layer.cornerRadius = 4
        saveContactButton.clipsToBounds = true
    }
    
    func updateViews() {
        guard let contact = contact else {
            return
        }

        contactNameTextField.text = contact.name
        contactPhoneTextField.text = contact.phone
        contactEmailTextField.text = contact.email
    }
    
    func handleResponse(error: ContactError?) {
        DispatchQueue.main.async {
            self.saveContactButton.isEnabled = true

            if let error = error {
                self.presentErrorToUser(error)
            } else {
                self.dismiss(animated: true)
            }
        }
    }

}
