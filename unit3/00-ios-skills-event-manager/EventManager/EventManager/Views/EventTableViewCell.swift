//
//  EventTableViewCell.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import UIKit

protocol EventTableViewCellDelegate {
    func toggleAttendance(for event: Event)
}

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: EventTableViewCellDelegate?
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpSubviews()
    }
    
    // MARK: - Helpers
    
    func setUpSubviews() {
        self.backgroundColor = .systemGray6
        self.selectionStyle = .none
        
        self.addSubview(eventNameLabel)
        self.addSubview(attendingButton)
        
        constraintEventNameLabel()
        constraintAttendingButton()
        
        activateAttendingButton()
    }
    
    func updateViews() {
        guard let event = event else { return }
        
        eventNameLabel.text = event.name

        let imageName = event.attending ? Strings.fireFillImageName : Strings.fireOutlineImageName
        let image = UIImage(named: imageName)
        attendingButton.setImage(image, for: .normal)
    }
    
    func constraintEventNameLabel() {
        eventNameLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: nil, marginTop: Spacings.mediumSpacing, marginBottom: Spacings.mediumSpacing, marginLeft: Spacings.mediumSpacing, marginRight: 0, height: Spacings.largeHeight)
    }
    
    func constraintAttendingButton() {
        attendingButton.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: nil, trailing: self.trailingAnchor, marginTop: Spacings.mediumSpacing, marginBottom: Spacings.mediumSpacing, marginLeft: 0, marginRight: Spacings.mediumSpacing, width: Spacings.largeHeight, height: Spacings.largeHeight)
        
        // QUESTION: Why using self.contentView.trailingAnchor generates a bug?
    }
    
    func activateAttendingButton() {
        attendingButton.addTarget(self, action: #selector(didPressAttendingButton(sender:)), for: .touchUpInside)
    }
    
    @objc func didPressAttendingButton(sender: UIButton) {
        guard let event = event else { return }
        delegate?.toggleAttendance(for: event)
    }
    
    // MARK: - Views
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()

    let attendingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Strings.fireOutlineImageName), for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal) // the view with a higher horizontal content hugging priority will not grow beyond its content size
        
        return button
    }()
}
