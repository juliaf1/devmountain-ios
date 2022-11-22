//
//  EntryDetailViewController.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var entry: Entry? {
        didSet {
            updateViewData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        setupViews()
        constraintViews()
        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helpers Methods
    
    func setupViews() {
        self.view.backgroundColor = .systemGray6
        self.navigationItem.rightBarButtonItem = saveEntryButton
        self.navigationController?.navigationBar.tintColor = .darkGray
        
        self.view.addSubview(titleTextField)
        self.view.addSubview(detailTextView)
    }
    
    func constraintViews() {
        titleTextField.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, marginTop: 16, marginBottom: 0, marginLeft: 16, marginRight: 16, height: 40)
        detailTextView.anchor(top: titleTextField.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, marginTop: 8, marginBottom: 16, marginLeft: 16, marginRight: 16)
    }
    
    func configureViews() {
        saveEntryButton.target = self
        saveEntryButton.action = #selector(didPressSaveEntryButton)
    }
    
    @objc func didPressSaveEntryButton() {
        guard let title = titleTextField.text,
              !title.isEmpty else { return }

        EntryController.shared.createEntry(title: title, detail: detailTextView.text ?? "") { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.presentErrorToUser(error)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func updateViewData() {
        if let entry = entry {
            titleTextField.text = entry.title
            detailTextView.text = entry.detail
        }
    }
    
    // MARK: - Views

    let titleTextField: UITextField = {
        let textfield = PaddingTextField()
        
        textfield.font = UIFont(name: "Helvetica Bold", size: 16)
        textfield.placeholder = "Entry title"
        
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = Colors.brandPrimaryTransparent.cgColor
        textfield.layer.cornerRadius = 4.0
        
        return textfield
    }()
    
    let detailTextView: UITextView = {
        let textview = UITextView()

        textview.font = UIFont(name: "Helvetica", size: 16)
        textview.textColor = .darkGray
        
        textview.layer.borderWidth = 1.0
        textview.layer.borderColor = Colors.brandPrimaryTransparent.cgColor
        textview.layer.cornerRadius = 4.0
        
        textview.backgroundColor = .systemGray6
        
        return textview
    }()
    
    let saveEntryButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.tintColor = Colors.brandPrimary
        button.title = "Save"

        return button
    }()
    
}
