//
//  AspectDetailVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/3/24.
//

import Foundation
import UIKit

class NatalAspectDetailViewController: UIViewController {
    var aspectContent: NatalAspectContent?

    private let generalDescriptionLabel = UILabel()
    private let strengthsLabel = UILabel()
    private let challengesLabel = UILabel()
    private let adviceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabels()
        setupConstraints()
        displayContent()
    }

    private func setupLabels() {
        [generalDescriptionLabel, strengthsLabel, challengesLabel, adviceLabel].forEach { label in
            label.numberOfLines = 0 // Allows multi-line text
            label.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
            view.addSubview(label)
        }
    }

    private func setupConstraints() {
        // Example constraints - adjust as needed
        NSLayoutConstraint.activate([
            generalDescriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            generalDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generalDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            strengthsLabel.topAnchor.constraint(equalTo: generalDescriptionLabel.bottomAnchor, constant: 20),
            strengthsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            strengthsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            challengesLabel.topAnchor.constraint(equalTo: strengthsLabel.bottomAnchor, constant: 20),
            challengesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            challengesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            adviceLabel.topAnchor.constraint(equalTo: challengesLabel.bottomAnchor, constant: 20),
            adviceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            adviceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func displayContent() {
        if let content = aspectContent {
            generalDescriptionLabel.text = "Description: \(content.generalDescription)"
            strengthsLabel.text = "Strengths: \(content.strengths)"
            challengesLabel.text = "Challenges: \(content.challenges)"
            adviceLabel.text = "Advice: \(content.advice)"
        }
    }
}
