//
//  EventDetailViewController.swift
//  EventManager
//
//  Created by Julia Frederico on 10/11/22.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
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
        
        configureSaveButton()
        configureEventNameTextField()
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
        self.navigationItem.rightBarButtonItem = saveButtonItem
    }
    
    func constraintEventNameTextField() {
        eventNameTextField.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, marginTop: Spacings.mediumSpacing, marginBottom: 0, marginLeft: Spacings.mediumSpacing, marginRight: Spacings.mediumSpacing)
    }
    
    func constraintEventDatePicker() {
        eventDatePicker.anchor(top: eventNameTextField.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, marginTop: Spacings.mediumSpacing, marginBottom: Spacings.mediumSpacing, marginLeft: Spacings.mediumSpacing, marginRight: Spacings.mediumSpacing)
    }
    
    func updateViews() {
        guard let event = event else { return }
        
        eventNameTextField.text = event.name
        eventDatePicker.date = event.date ?? Date()
    }
    
    func configureEventNameTextField() {
        eventNameTextField.delegate = self
    }
    
    func configureSaveButton() {
        saveButtonItem.target = self
        saveButtonItem.action = #selector(didPressSaveButton)
    }
    
    @objc func didPressSaveButton() {
        guard let eventName = eventNameTextField.text,
              !eventName.isEmpty else { return }
        
        if let event = event {
            EventController.shared.update(event: event, name: eventName, date: eventDatePicker.date)
        } else {
            EventController.shared.create(eventWithName: eventName, date: eventDatePicker.date)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Views
    
    let backButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        return button
    }()
    
    let saveButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Save"
        
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

extension EventDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
