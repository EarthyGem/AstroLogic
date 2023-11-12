//
//  SunVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 10/31/23.
//

import Foundation
import UIKit
import SwiftEphemeris

class SunViewController: UIViewController {
    var chartCake: ChartCake?
    var selectedDate: Date?
    
    let scrollView = UIScrollView()
    let contentStackView = UIStackView()
    
    let pageTitleLabel = UILabel()
    let currentDateLabel = UILabel()

    let astrologicalSeasonView = UIView()
    let astrologicalSeasonStackView = UIStackView()
    let astrologicalSeasonTitleLabel = UILabel()
    let astrologicalSeasonSignLabel = UILabel()
    let astrologicalSeasonContentLabel = UILabel()

    let personalSolarInsightsView = UIView()
    let personalSolarInsightsStackView = UIStackView()
    let personalSolarInsightsTitleLabel = UILabel()
    let solarHousePlacementLabel = UILabel()
    let majorAspectLabel = UILabel()
    let personalSolarInsightsContentLabel = UILabel()

    let tableView1 = UITableView()
    let tableView2 = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        setupViews()
        setupLabels()
        setupLayout()
    }
    
    private func setupViews() {
        
        setupRoundedView(astrologicalSeasonView, withBackgroundColor: .blue)
           setupRoundedView(personalSolarInsightsView, withBackgroundColor: .red)

           // Setup for stack views
           setupStackView(astrologicalSeasonStackView)
           setupStackView(personalSolarInsightsStackView)

        // Set up the stack views
        contentStackView.axis = .vertical
         contentStackView.spacing = 10
         contentStackView.alignment = .fill
         contentStackView.distribution = .equalSpacing
         contentStackView.translatesAutoresizingMaskIntoConstraints = false

         astrologicalSeasonStackView.axis = .vertical
         astrologicalSeasonStackView.spacing = 5
         
         personalSolarInsightsStackView.axis = .vertical
         personalSolarInsightsStackView.spacing = 5
         
         // Set up colored views
         astrologicalSeasonView.backgroundColor = .blue
         personalSolarInsightsView.backgroundColor = .red

         // Set up scroll view
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(scrollView)
         scrollView.addSubview(contentStackView)
         
         // Add the table views
         tableView1.translatesAutoresizingMaskIntoConstraints = false
         tableView2.translatesAutoresizingMaskIntoConstraints = false
     }

    private func setupLabels() {
        // Page title and date labels
        pageTitleLabel.text = "Harnessing the Sun's Energy: From Universal Seasons to Personal Illuminations"
        currentDateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        configureLabelForMultiLine(pageTitleLabel)
        configureLabelForMultiLine(currentDateLabel)
        // Configure the "Astrological Season" labels
        astrologicalSeasonTitleLabel.text = "Astrological Season"
        astrologicalSeasonSignLabel.text = " \(chartCake!.transits.sun.sign.sunHeaders[0])"
        astrologicalSeasonContentLabel.text = "\(chartCake!.transits.sun.sign.sunContent[0])"
        
        // Configure the "Personal Solar Insights" labels
        personalSolarInsightsTitleLabel.text = "Your Solar Season"
        solarHousePlacementLabel.text = "Sun Illuminating Your Attitudes about, \(chartCake!.houseCusps.cusp(for: chartCake!.transits.sun.longitude).houseKeywords)"
        majorAspectLabel.text = "\(chartCake!.houseCusps.getSunData(for: chartCake!.houseCusps.cusp(for: chartCake!.transits.sun.longitude)).header)"
        personalSolarInsightsContentLabel.text = "\(chartCake!.houseCusps.getSunData(for: chartCake!.houseCusps.cusp(for: chartCake!.transits.sun.longitude)).header1Text)"
        
        // Add labels to their respective stack views
        [astrologicalSeasonTitleLabel, astrologicalSeasonSignLabel, astrologicalSeasonContentLabel].forEach { label in
            astrologicalSeasonStackView.addArrangedSubview(label)
            astrologicalSeasonView.addSubview(astrologicalSeasonStackView)
        }
        
        [personalSolarInsightsTitleLabel, solarHousePlacementLabel, majorAspectLabel, personalSolarInsightsContentLabel].forEach { label in
            personalSolarInsightsStackView.addArrangedSubview(label)
            personalSolarInsightsView.addSubview(personalSolarInsightsStackView)
        }
        
        // Add stack views to the main content stack view
        contentStackView.addArrangedSubview(pageTitleLabel)
        contentStackView.addArrangedSubview(currentDateLabel)
        contentStackView.addArrangedSubview(astrologicalSeasonView)
        contentStackView.addArrangedSubview(personalSolarInsightsView)
        contentStackView.addArrangedSubview(tableView1)
        contentStackView.addArrangedSubview(tableView2)
    }
    
    private func setupLayout() {
        // Setup constraints for scrollView and contentStackView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Add labels to their respective stack views
        [astrologicalSeasonTitleLabel, astrologicalSeasonSignLabel, astrologicalSeasonContentLabel].forEach(astrologicalSeasonStackView.addArrangedSubview)
        [personalSolarInsightsTitleLabel, solarHousePlacementLabel, majorAspectLabel, personalSolarInsightsContentLabel].forEach(personalSolarInsightsStackView.addArrangedSubview)
        
        // Add stack views to the main content stack view
        contentStackView.addArrangedSubview(pageTitleLabel)
        contentStackView.addArrangedSubview(currentDateLabel)
        contentStackView.addArrangedSubview(astrologicalSeasonStackView)
        contentStackView.addArrangedSubview(personalSolarInsightsStackView)
        contentStackView.addArrangedSubview(tableView1)
        contentStackView.addArrangedSubview(tableView2)
    }
    
    private func setupRoundedView(_ view: UIView, withBackgroundColor color: UIColor) {
        view.backgroundColor = color
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }

    private func setupStackView(_ stackView: UIStackView) {
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
    }

    private func configureLabelForMultiLine(_ label: UILabel) {
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        // Adjust text alignment and other properties as needed
    }
}
