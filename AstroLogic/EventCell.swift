//
//  EventCell.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/25/24.
//

import Foundation
// CustomEventCell.swift
import UIKit

class CustomEventCell: UITableViewCell {
    
    // Add any UI elements you need for displaying event information
    let eventTypeLabel = UILabel()
    let eventDateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Customize the cell's appearance and layout
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        // Configure eventTypeLabel
        eventTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventTypeLabel)
        
        // Configure eventDateLabel
        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventDateLabel)
        
        // Define constraints for UI elements
        NSLayoutConstraint.activate([
            eventTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            eventTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            eventTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            eventDateLabel.topAnchor.constraint(equalTo: eventTypeLabel.bottomAnchor, constant: 5),
            eventDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            eventDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            eventDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with eventType: String, eventDate: String) {
        // Update cell UI with event data
        eventTypeLabel.text = eventType
        eventDateLabel.text = eventDate
    }
}
