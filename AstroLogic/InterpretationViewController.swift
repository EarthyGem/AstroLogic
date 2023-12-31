//
//  InterpretationViewController.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/31/23.
//

import Foundation
import UIKit
import SwiftEphemeris


class InterpretationViewController: UIViewController {
    var celestialBody: CelestialObject? // Replace CelestialObject with your actual type
    var houseNumber: Int?
    var userA: String?
    var userB: String?
    private let interpretationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Set the background color of the view
        setupUI()
        displayInterpretation()
    }

    private func setupUI() {
        interpretationLabel.translatesAutoresizingMaskIntoConstraints = false
        interpretationLabel.numberOfLines = 0 // Allow for multiple lines
        interpretationLabel.textAlignment = .center
        interpretationLabel.font = UIFont.systemFont(ofSize: 16) // Set the font size

        view.addSubview(interpretationLabel)

        // Set constraints for the label
        NSLayoutConstraint.activate([
            interpretationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            interpretationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            interpretationLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            interpretationLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func displayInterpretation() {
        if let body = celestialBody, let houseNum = houseNumber {
            let interpretation = generateAstrologicalInterpretation(planet: body.keyName, houseNumber: houseNum, templateNumber: 1, userA: userA!, userB: userB!) // Choose template number as needed
            interpretationLabel.text = interpretation
        }
    }
}
