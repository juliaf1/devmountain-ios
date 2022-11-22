//
//  EntryTableViewCell.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet {
            updateViewData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
        constraintViews()
    }
    
    // MARK: - Helpers
    
    func setupViews() {
        self.selectionStyle = .none
        self.backgroundColor = .systemGray6

        self.addSubview(entryTitleLabel)
        self.addSubview(entryTimestampLabel)
    }
    
    func constraintViews() {
        entryTitleLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: nil, marginTop: 16, marginBottom: 16, marginLeft: 16, marginRight: 0)
        
        entryTimestampLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: entryTitleLabel.trailingAnchor, trailing: self.trailingAnchor, marginTop: 16, marginBottom: 16, marginLeft: 4, marginRight: 16)
    }
    
    func updateViewData() {
        guard let entry = entry else {
            return
        }

        entryTitleLabel.text = entry.title
        entryTimestampLabel.text = entry.timestamp.toString()
    }
    
    // MARK: - Views
    
    let entryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 16)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    let entryTimestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 12)
        label.textColor = .darkGray
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()
    
}
