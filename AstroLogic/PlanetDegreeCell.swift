//
//  PlanetDegree.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 6/30/23.
//

import Foundation
import UIKit
import SwiftEphemeris



class PlanetDegreeCell: UITableViewCell {
    var degreeLabel: UILabel!
    var planetsStackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Initialize the UI components
        degreeLabel = UILabel()
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(degreeLabel)

        planetsStackView = UIStackView()
        planetsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(planetsStackView)

        // Set up constraints for degreeLabel and planetsStackView
        NSLayoutConstraint.activate([
            degreeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            degreeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            planetsStackView.leadingAnchor.constraint(equalTo: degreeLabel.trailingAnchor, constant: 16),
            planetsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            planetsStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureWith(degree: Int, planets: [PlanetDegree]) {
        degreeLabel.text = "\(degree)°"
        
        // Clear out any old planet views
        for subview in planetsStackView.arrangedSubviews {
            planetsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        // Add a new image view for each planet
        for planetDegree in planets {
            let imageView = UIImageView(image: UIImage(named: planetDegree.planet.lowercased()))
            planetsStackView.addArrangedSubview(imageView)
        }
    }

}
