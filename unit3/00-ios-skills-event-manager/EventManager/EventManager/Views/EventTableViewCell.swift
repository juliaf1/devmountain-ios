//
//  EventTableViewCell.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpSubviews()
    }
    
    // MARK: - Helpers
    
    func setUpSubviews() {
        self.addSubview(eventNameLabel)
        self.addSubview(attendingButton)
        
        constraintEventNameLabel()
        constraintAttendingButton()
    }
    
    func updateViews() {
        guard let event = event else { return }
        
        eventNameLabel.text = event.name

        let imageName = event.attending ? "square" : "square.checkmark"
        attendingButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func constraintEventNameLabel() {
        eventNameLabel.anchor(top: self.contentView.topAnchor, bottom: self.contentView.bottomAnchor, leading: self.contentView.leadingAnchor, trailing: attendingButton.leadingAnchor, marginTop: 8, marginBottom: 8, marginLeft: 8, marginRight: 4)
    }
    
    func constraintAttendingButton() {
        attendingButton.anchor(top: self.contentView.topAnchor, bottom: self.contentView.bottomAnchor, leading: nil, trailing: self.contentView.trailingAnchor, marginTop: 8, marginBottom: 8, marginLeft: 0, marginRight: 8)
    }
    
    // MARK: - Views
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()

    let attendingButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square")
        button.setImage(image, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return button
    }()
}
