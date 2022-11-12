//
//  UIViewControllerExtension.swift
//  DeckOfOneCard
//
//  Created by Julia Frederico on 12/11/22.
//

import UIKit

extension UIViewController {

    func presentErrorToUser(error: CardError) {
        let alertController = UIAlertController(title: "Error", message: error.description, preferredStyle: .actionSheet)

        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)

        present(alertController, animated: true)
    }

}
