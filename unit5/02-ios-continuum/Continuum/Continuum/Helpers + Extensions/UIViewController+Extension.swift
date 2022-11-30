//
//  UIViewController+Extension.swift
//  Continuum
//
//  Created by Julia Frederico on 29/11/22.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(dismissAction)
        
        present(alert, animated: true)
    }
    
}
