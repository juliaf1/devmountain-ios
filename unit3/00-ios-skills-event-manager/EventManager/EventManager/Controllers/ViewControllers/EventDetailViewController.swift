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
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
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
        
        self.view.addSubview(eventNameTextField)
        self.view.addSubview(eventDatePicker)
        
        constraintEventNameTextField()
        constraintEventDatePicker()
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .darkGray
    }
    
    func constraintEventNameTextField() {
        eventNameTextField.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, marginTop: Spacings.mediumSpacing, marginBottom: 0, marginLeft: Spacings.mediumSpacing, marginRight: Spacings.mediumSpacing)
    }
    
    func constraintEventDatePicker() {
        eventDatePicker.anchor(top: eventNameTextField.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, marginTop: Spacings.mediumSpacing, marginBottom: Spacings.mediumSpacing, marginLeft: Spacings.mediumSpacing, marginRight: Spacings.mediumSpacing)
    }
    
    // MARK: - Views
    
    let backButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        return button
    }()
    
    let eventNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Event name"
        
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray5
        textField.tintColor = .darkGray
        
        return textField
    }()
    
    let eventDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 10
        
        return datePicker
    }()

}
