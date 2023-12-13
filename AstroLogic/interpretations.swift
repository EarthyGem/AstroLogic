//
//  interpretations.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/12/23.
//

import Foundation
import UIKit
 

class AspectDetailViewController: UIViewController {

    var interpretationText: String?
    private let interpretationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayInterpretation()
    }

    private func setupUI() {
        // Basic UI setup
        view.backgroundColor = .white

        // Setup interpretationLabel
        interpretationLabel.numberOfLines = 0 // Allow multiple lines
        interpretationLabel.textAlignment = .center
        interpretationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(interpretationLabel)

        // Constraints for interpretationLabel
        NSLayoutConstraint.activate([
            interpretationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            interpretationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            interpretationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func displayInterpretation() {
        // Set the text of the label to the interpretation text
        interpretationLabel.text = interpretationText
    }
}
