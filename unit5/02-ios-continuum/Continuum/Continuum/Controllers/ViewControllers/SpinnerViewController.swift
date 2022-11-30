//
//  SpinnerViewController.swift
//  Continuum
//
//  Created by Julia Frederico on 29/11/22.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    // MARK: - Properties

    let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle

    override func loadView() {
        addSubviews()
        setUpViews()
        constraintViews()
    }
    
    // MARK: - Helpers
    
    func setUpViews() {
        spinner.color = #colorLiteral(red: 0.8781796098, green: 0.4604950547, blue: 0.5509846807, alpha: 1)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
    }
    
    func addSubviews() {
        view = UIView()
        view.addSubview(spinner)
    }
    
    func constraintViews() {
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
