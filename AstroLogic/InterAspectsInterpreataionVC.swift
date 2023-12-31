//
//  InterAspectsInterpreataionVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/31/23.
//

import Foundation
import UIKit
import SwiftEphemeris
class InteraspectInterpretationViewController: UIViewController {
    var userAName: String?
    var userBName: String?
    var planetA: String?
    var planetB: String?
    var aspect: String?
    var aspectCap: String?
    var kind: Kind?
    private let interpretationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        displayInterpretation()
    }

    private func setupUI() {
        interpretationLabel.translatesAutoresizingMaskIntoConstraints = false
        interpretationLabel.numberOfLines = 0 // Allow for multiple lines
        interpretationLabel.textAlignment = .center
        view.addSubview(interpretationLabel)

        NSLayoutConstraint.activate([
            interpretationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            interpretationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            interpretationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }


    private func displayInterpretation() {
        if let userA = userAName, let userB = userBName, let planetA = planetA, let planetB = planetB, let aspect = aspect, let aspectCap = aspectCap, let kind = kind {
            let interpretation = generateInteraspectInterpretation(userA: userA, userB: userB, planetA: planetA, planetB: planetB, aspect: aspect, aspectCap: aspectCap, kind: kind)
            interpretationLabel.text = interpretation
        }
    }
}
