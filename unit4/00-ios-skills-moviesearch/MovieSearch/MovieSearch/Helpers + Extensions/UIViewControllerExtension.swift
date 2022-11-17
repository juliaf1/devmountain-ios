//
//  UIViewControllerExtension.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import UIKit

extension UIViewController {

    func presentErrorToUser(error: MovieError) {
        let alertController = UIAlertController(title: "Error", message: error.description, preferredStyle: .actionSheet)

        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)

        present(alertController, animated: true)
    }

}
