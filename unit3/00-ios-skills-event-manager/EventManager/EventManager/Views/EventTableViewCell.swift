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
        self.backgroundColor = .systemGray6
        self.selectionStyle = .none
        
        self.addSubview(eventNameLabel)
        self.addSubview(attendingButton)
        
        constraintEventNameLabel()
        constraintAttendingButton()
    }
    
    func updateViews() {
        guard let event = event else { return }
        
        eventNameLabel.text = event.name

        let imageName = event.attending ? Strings.fireFillImageName : Strings.fireOutlineImageName
        let image = UIImage(named: imageName)
        attendingButton.setImage(image, for: .normal)
    }
    
    func constraintEventNameLabel() {
        eventNameLabel.anchor(top: self.contentView.topAnchor, bottom: self.contentView.bottomAnchor, leading: self.contentView.leadingAnchor, trailing: nil, marginTop: Spacings.mediumSpacing, marginBottom: Spacings.mediumSpacing, marginLeft: Spacings.mediumSpacing, marginRight: 0, height: Spacings.largeHeight)
    }
    
    func constraintAttendingButton() {
        attendingButton.anchor(top: self.contentView.topAnchor, bottom: self.contentView.bottomAnchor, leading: nil, trailing: self.contentView.trailingAnchor, marginTop: Spacings.mediumSpacing, marginBottom: Spacings.mediumSpacing, marginLeft: 0, marginRight: Spacings.mediumSpacing, width: Spacings.largeHeight, height: Spacings.largeHeight)
    }
    
    // MARK: - Views
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
//        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()

    let attendingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Strings.fireOutlineImageName), for: .normal)
//        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.contentMode = .scaleToFill
        
        return button
    }()
}
