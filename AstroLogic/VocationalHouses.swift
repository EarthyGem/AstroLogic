//
//  VocationalHouses.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/6/23.
//

import Foundation
import UIKit
import SwiftEphemeris


class VocationalHousesViewController: UIViewController {
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()
    var chartCake: ChartCake!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Set a background color

        configureScrollView()
        configureMainStackView()
        auditHouses()
    }

    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }


    private func auditHouses() {
        // Define the house numbers for vocational houses
        let vocationalHouseNumbers = [10, 6, 2]
        for houseNumber in vocationalHouseNumbers {
            let auditResults = chartCake.audit(for: houseNumber)
            let houseStackView = createHouseStackView(for: houseNumber, with: auditResults)
            mainStackView.addArrangedSubview(houseStackView)
        }
    }

    private func createHouseStackView(for houseNumber: Int, with auditResults: [AspectType: (harmony: Double, discord: Double, net: Double)]) -> UIStackView {
        let houseStackView = UIStackView()
        houseStackView.axis = .vertical
        houseStackView.alignment = .fill
        houseStackView.distribution = .fill
        houseStackView.spacing = 5

        // Create a label for the house number
        let houseNumberLabel = UILabel()
        houseNumberLabel.text = "House \(houseNumber)"
        houseStackView.addArrangedSubview(houseNumberLabel)

        // Iterate over the audit results and create labels for each aspect
        for (aspectType, scores) in auditResults {
            let aspectLabel = UILabel()
            aspectLabel.text = "\(aspectType): Harmony - \(scores.harmony), Discord - \(scores.discord), Net - \(scores.net)"
            houseStackView.addArrangedSubview(aspectLabel)
        }

        return houseStackView
    }

    // Add other helper methods if necessary
    // ...
}
