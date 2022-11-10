//
//  EventDetailViewController.swift
//  EventManager
//
//  Created by Julia Frederico on 10/11/22.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var event: Event?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        setUpSubviews()
        setUpNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helpers
    
    func setUpSubviews() {
        self.view.backgroundColor = .systemGray6
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .darkGray
    }
    
    // MARK: - Views
    
    let backButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        return button
    }()
    
    let eventNameTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()

}
