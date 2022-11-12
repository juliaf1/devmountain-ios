//
//  UIViewControllerExtension.swift
//  Pokedex
//
//  Created by Julia Frederico on 11/11/22.
//

import UIKit

extension UIViewController {

    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)

        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)

        present(alertController, animated: true)
    }

}
