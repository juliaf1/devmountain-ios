//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var contact: Contact? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Outlets
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactDetailLabel: UILabel!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        setupViews()
    }
    
    // MARK: - Helpers
    
    func setupViews() {
        self.selectionStyle = .none
        
        contactImageView.image = UIImage(systemName: "person.fill")
        contactImageView.contentMode = .scaleAspectFill
        contactImageView.backgroundColor = .systemGray5
        contactImageView.tintColor = .systemGray4
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2.5
        contactImageView.clipsToBounds = true
    }
    
    func updateViews() {
        guard let contact = contact else {
            return
        }

        contactImageView.image = contact.photo ?? UIImage(systemName: "person.fill")
        contactNameLabel.text = contact.name
        
        if let phone = contact.phone {
            contactDetailLabel.text = phone
        } else if let email = contact.email {
            contactDetailLabel.text = email
        } else {
            contactDetailLabel.isHidden = true
        }
    }

}
