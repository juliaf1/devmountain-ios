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
        
        // constraint views
    }
    
    func updateViews() {
        guard let event = event else { return }
        
        eventNameLabel.text = event.name
        let imageName = event.attending ? "square" : "square.checkmark"
        attendingButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // MARK: - Views
    
    let eventNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()

    let attendingButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square")
        button.setImage(image, for: .normal)
        
        return button
    }()
}
