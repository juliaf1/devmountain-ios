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
    }
    
    // MARK: - Actions
    
    @IBAction func didPressSaveContactButton(_ sender: UIButton) {
        if let contact = contact {
            // update contact
        } else {
            // create contact
        }
    }
    
    // MARK: - Helpers
    
    func setupViews() {
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 10
        imageContainerView.clipsToBounds = true
        saveContactButton.layer.cornerRadius = 4
        saveContactButton.clipsToBounds = true
    }

}
