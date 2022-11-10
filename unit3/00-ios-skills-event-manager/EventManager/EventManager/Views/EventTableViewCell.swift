//
//  EventTableViewCell.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import UIKit

protocol EventTableViewCellDelegate {
    func toggleAttendance(of event: Event)
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
        configureAttendingButton()
    }

    // MARK: - Helpers

    func setUpSubviews() {
        self.backgroundColor = .systemGray6
        self.selectionStyle = .none

        setUpEventStackView()

        self.addSubview(eventDetailStackView)
        self.addSubview(attendingButton)
        
        constraintEventStackView()
        constraintAttendingButton()
    }
    
    func setUpEventStackView() {
        eventDetailStackView.addArrangedSubview(eventNameLabel)
        eventDetailStackView.addArrangedSubview(eventDateLabel)
    }
    
    func updateViews() {
        guard let event = event else { return }
        
        eventNameLabel.text = event.name
        eventDateLabel.text = event.date?.toString()

        let imageName = event.attending ? Strings.fireFillImageName : Strings.fireOutlineImageName
        let image = UIImage(named: imageName)
        attendingButton.setImage(image, for: .normal)
    }
    
    func constraintEventStackView() {
        eventDetailStackView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: nil, marginTop: Spacings.mediumSpacing, marginBottom: Spacings.mediumSpacing, marginLeft: Spacings.mediumSpacing, marginRight: 0)
    }
    
    func constraintAttendingButton() {
        attendingButton.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: nil, trailing: self.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeft: 0, marginRight: Spacings.mediumSpacing, width: Spacings.largeHeight + Spacings.smallSpacing)
        
        // QUESTION: Why using self.contentView.trailingAnchor generates a bug?
    }
    
    func configureAttendingButton() {
        attendingButton.addTarget(self, action: #selector(didPressAttendingButton(sender:)), for: .touchUpInside)
    }
    
    @objc func didPressAttendingButton(sender: UIButton) {
        guard let event = event else { return }
        delegate?.toggleAttendance(of: event)
    }
    
    // MARK: - Views
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: Spacings.largeHeight)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    let eventDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Spacings.smallHeight, weight: .light)
        label.textColor = .darkGray
        
        return label
    }()
    
    let eventDetailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Spacings.smallSpacing
        
        return stackView
    }()

    let attendingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Strings.fireOutlineImageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal) // the view with a higher horizontal content hugging priority will not grow beyond its content size
        
        return button
    }()
}
