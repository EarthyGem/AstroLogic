//
//  Cells.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/6/23.
//

import Foundation
import UIKit

class PlanetIntroCell: UITableViewCell {

    // UI Elements
    let planetLabel = UILabel()
    let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Setting up the UI elements
        setupPlanetLabel()
        setupNameLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPlanetLabel() {
        planetLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(planetLabel)

        // Constraints (customize as needed)
        NSLayoutConstraint.activate([
            planetLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            planetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            planetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }

    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        // Constraints (customize as needed)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with planet: String, name: String) {
        planetLabel.text = planet
        nameLabel.text = name
    }
}

class ContentCell: UITableViewCell {

    // UI Elements
    let contentLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Setting up the UI elements
        setupContentLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.numberOfLines = 0 // Allows for multiple lines
        contentView.addSubview(contentLabel)

        // Constraints (customize as needed)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with text: String) {
        contentLabel.text = text
    }
}

class CardImageCell: UITableViewCell {

    // UI Elements
    let tarotImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Setting up the UI elements
        setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        tarotImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tarotImageView)

        // Constraints (customize as needed)
        NSLayoutConstraint.activate([
            tarotImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            tarotImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            tarotImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            tarotImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            tarotImageView.heightAnchor.constraint(equalToConstant: 200) // Fixed height, adjust as needed
        ])

        tarotImageView.contentMode = .scaleAspectFit
    }

    func configure(with tarot: String) {
        // Assuming the tarot string is the name of an image in your assets
        tarotImageView.image = UIImage(named: tarot)
    }
}
