//
//  UIViewControllerExtension.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

extension UIViewController {

    func presentErrorToUser(_ error: ContactError) {
        let alertController = UIAlertController(title: "Something went wrong", message: error.description, preferredStyle: .actionSheet)

        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)

        present(alertController, animated: true)
    }
    
    func presentErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Back", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

}
