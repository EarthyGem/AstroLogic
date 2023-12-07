//
//  HarmonyHouse.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/6/23.
//

import Foundation
import SwiftEphemeris
import UIKit
class HarmonyHousesViewController: UIViewController {
    var harmonyHousesData: [Int: (strengthPercentage: Double, harmony: Double)] = [:]
    var houseKeywords: [Int: String] = [:] // Presumed to be populated elsewhere
    var occupationsForHouse: [Int: [String]] = [:] // Presumed to be populated elsewhere
    var chartCake: ChartCake!
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        harmonyHousesData = chartCake.harmonyHouses()

print("harmony houses \(harmonyHousesData)")
        configureScrollView()
        configureMainStackView()
        addHarmonyHouseViews()
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

    private func addHarmonyHouseViews() {
        // Sort the houses by the product of their strength and harmony
        let sortedHarmonyHouses = harmonyHousesData.sorted {
            let product1 = $0.value.strengthPercentage * $0.value.harmony
            let product2 = $1.value.strengthPercentage * $1.value.harmony
            return product1 > product2
        }

        // Create views for each house based on the sorted data
        for (houseNumber, data) in sortedHarmonyHouses {
            let houseView = createHouseView(
                houseNumber: houseNumber,
                strengthPercentage: data.strengthPercentage,
                harmony: data.harmony,
                keywords: houseKeywords[houseNumber],
                occupations: occupationsForHouse[houseNumber] ?? []
            )
            mainStackView.addArrangedSubview(houseView)
        }
    }


    private func createHouseView(houseNumber: Int, strengthPercentage: Double, harmony: Double, keywords: String?, occupations: [String]) -> UIStackView {
        let houseStackView = UIStackView()
        houseStackView.axis = .vertical // Changed to vertical for better layout
        houseStackView.alignment = .fill
        houseStackView.distribution = .equalSpacing // or .fillProportionally
        houseStackView.spacing = 8

        // Label for the house number
        let houseNumberLabel = UILabel()
        houseNumberLabel.text = "House \(houseNumber)"
        houseNumberLabel.textColor = .white // Set text color to white
        houseStackView.addArrangedSubview(houseNumberLabel)

        // Label for the strength percentage
        let strengthLabel = UILabel()
        strengthLabel.text = "Strength: \(strengthPercentage)%"
        strengthLabel.textColor = .white // Set text color to white
        houseStackView.addArrangedSubview(strengthLabel)

        // Label for the harmony
        let harmonyLabel = UILabel()
        harmonyLabel.text = "Harmony: \(harmony)"
        harmonyLabel.textColor = .white // Set text color to white
        houseStackView.addArrangedSubview(harmonyLabel)

        // Label for the keywords, if any
        if let keywords = keywords {
            let keywordsLabel = UILabel()
            keywordsLabel.text = "Keywords: \(keywords)"
            keywordsLabel.textColor = .white // Set text color to white
            houseStackView.addArrangedSubview(keywordsLabel)
        }

        // Label for the occupations
        let occupationsLabel = UILabel()
        occupationsLabel.text = "Occupations: \(occupations.joined(separator: ", "))"
        occupationsLabel.textColor = .white // Set text color to white
        houseStackView.addArrangedSubview(occupationsLabel)

        // ... add other subviews or configuration as needed

        return houseStackView
    }


    // Additional methods for creating labels and occupation list views
}
