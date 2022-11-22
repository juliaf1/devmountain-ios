//
//  UIViewControllerExtension.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import UIKit

extension UIViewController {

    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "Something went wrong", message: localizedError.errorDescription, preferredStyle: .actionSheet)

        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)

        present(alertController, animated: true)
    }

}
