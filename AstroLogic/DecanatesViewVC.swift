//
//  DecanatesViewVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/13/23.
//

import Foundation
import SwiftEphemeris
import UIKit

//  DecanatesViewVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/13/23.

import UIKit

class DecanateViewerVC: UIViewController {

    private let planet: String
    private let text: String
    private let keyword: String
    private let tarotCardImageName: String
    private let constellationImageName: String // Assuming you have this
    private let constellationDescriptionLabel: UILabel = {
           
        
        
        let constellationDescriptionLabel = UILabel()
        constellationDescriptionLabel.numberOfLines = 0
        constellationDescriptionLabel.lineBreakMode = .byWordWrapping
        constellationDescriptionLabel.textAlignment = .center
        constellationDescriptionLabel.textColor = .white
        constellationDescriptionLabel.font = UIFont.systemFont(ofSize: 13)
        constellationDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            return constellationDescriptionLabel
        }()

    private let tarotCardImageView = UIImageView()
    private let constellationImageView = UIImageView()

    init(planet: String, text: String, keyword: String, tarotCardImageName: String, constellationImageName: String) {
        self.planet = planet
        self.text = text
        self.keyword = keyword
        self.tarotCardImageName = tarotCardImageName
        self.constellationImageName = constellationImageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageViews()
        layoutViews()
    }

    private func setupImageViews() {
        tarotCardImageView.image = UIImage(named: tarotCardImageName)
        tarotCardImageView.contentMode = .scaleAspectFit
        view.addSubview(tarotCardImageView)

        constellationImageView.image = UIImage(named: constellationImageName)
        constellationImageView.contentMode = .scaleAspectFit
        view.addSubview(constellationImageView)
        constellationDescriptionLabel.text = text
        view.addSubview(constellationDescriptionLabel)
    }

    private func layoutViews() {
        // Constraints or frame setting for the image views
        // This is just a basic example. Adjust based on your needs.
        
        tarotCardImageView.translatesAutoresizingMaskIntoConstraints = false
        constellationImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

           
            constellationImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            constellationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            constellationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            constellationImageView.heightAnchor.constraint(equalToConstant: 200),
            
            constellationDescriptionLabel.topAnchor.constraint(equalTo: constellationImageView.bottomAnchor, constant: 35), // Adjust the constant for spacing
               constellationDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), // Left side padding
               constellationDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16), // Right side padding
               
            tarotCardImageView.topAnchor.constraint(equalTo: constellationDescriptionLabel.bottomAnchor, constant: 8),
            tarotCardImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tarotCardImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tarotCardImageView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
}
