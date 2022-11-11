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
        
//        self.contentView.subviews.forEach { $0.removeFromSuperview() }
        
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

        attendingButton.setBackgroundImage(attendingImage(for: event), for: .normal)
    }
    
    func constraintEventStackView() {
        eventDetailStackView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: attendingButton.leadingAnchor, marginTop: Spacings.mediumSpacing, marginBottom: Spacings.mediumSpacing, marginLeft: Spacings.mediumSpacing, marginRight: Spacings.smallSpacing, height: Spacings.largeHeight + Spacings.smallHeight + Spacings.mediumSpacing)
    }
    
    func constraintAttendingButton() {
        attendingButton.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: nil, trailing: self.trailingAnchor, marginTop: Spacings.largeSpacing, marginBottom: Spacings.largeSpacing, marginLeft: 0, marginRight: Spacings.largeSpacing)
        
        attendingButton.aspectRatio(multiplier: 1/1)
        
        // QUESTION: Why using self.contentView.trailingAnchor generates a bug?
    }
    
    func configureAttendingButton() {
        attendingButton.addTarget(self, action: #selector(didPressAttendingButton(sender:)), for: .touchUpInside)
    }
    
    func attendingImage(for event: Event) -> UIImage? {
        let imageName = event.attending ? Strings.fireFillImageName : Strings.fireOutlineImageName
        return UIImage(named: imageName)
    }

    @objc func didPressAttendingButton(sender: UIButton) {
        guard let event = event else { return }
        delegate?.toggleAttendance(of: event)
    }
    
    // MARK: - Views
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 22)
        
        return label
    }()
    
    let eventDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
        
        return label
    }()
    
    let eventDetailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Spacings.smallSpacing
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return stackView
    }()

    let attendingButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: Strings.fireFillImageName)
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFill
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal) // the view with a higher horizontal content hugging priority will not grow beyond its content size
        
        return button
    }()
}
