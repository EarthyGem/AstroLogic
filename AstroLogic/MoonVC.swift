//
//  MoonVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 10/31/23.
//

import Foundation
import UIKit
import SwiftEphemeris


class MoonViewController: UIViewController {
    
    var chartCake: ChartCake?
    var selectedDate: Date?
    
    let scrollView = UIScrollView()
    let contentStackView = UIStackView()
    
    let pageTitleLabel = UILabel()
    let currentDateLabel = UILabel()
    
    let collectiveMoodView = UIView()
    let collectiveMoodStackView = UIStackView()
    let collectiveMoodTitleLabel = UILabel()
    let collectiveMoodHeaderLabel = UILabel()
    let collectiveMoodSubheaderLabel = UILabel()
    let collectiveMoodContentLabel = UILabel()
    
    let selfCareCheckInView = UIView()
    let selfCareCheckInStackView = UIStackView()
    let selfCareCheckInTitleLabel = UILabel()
    let moonHousePlacementLabel = UILabel()
    let moonConjunctionLabel = UILabel()
    let selfCareCheckInContentLabel = UILabel()
    
    let tableView1 = UITableView()
    let tableView2 = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        setupViews()
        setupLabels()
        setupLayout()
    }
    
    private func setupViews() {
        
        setupRoundedView(collectiveMoodView, withBackgroundColor: .purple)
          setupRoundedView(selfCareCheckInView, withBackgroundColor: .green)

          // Setup for stack views
          setupStackView(collectiveMoodStackView)
          setupStackView(selfCareCheckInStackView)

          // Add subviews to their respective views
          collectiveMoodView.addSubview(collectiveMoodStackView)
          selfCareCheckInView.addSubview(selfCareCheckInStackView)
         // Set up the stack views
         contentStackView.axis = .vertical
         contentStackView.spacing = 10
         contentStackView.alignment = .fill
         contentStackView.distribution = .equalSpacing

         collectiveMoodStackView.axis = .vertical
         collectiveMoodStackView.spacing = 5
         
         selfCareCheckInStackView.axis = .vertical
         selfCareCheckInStackView.spacing = 5
         
         // Set up colored views
         collectiveMoodView.backgroundColor = .purple
         selfCareCheckInView.backgroundColor = .green

         // Set up scroll view
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         contentStackView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(scrollView)
         scrollView.addSubview(contentStackView)
         
         // Add the table views
         tableView1.translatesAutoresizingMaskIntoConstraints = false
         tableView2.translatesAutoresizingMaskIntoConstraints = false
     }
    private func setupLabels() {
        configureLabelForMultiLine(pageTitleLabel)
        configureLabelForMultiLine(currentDateLabel)
        // Page title and date labels
        pageTitleLabel.text = "The ever changing Moon lights up new pathways and casts shade on others, Let the Moon light your path"
        currentDateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        
        // Configure the "Collective Mood" labels
        collectiveMoodTitleLabel.text = "Self-Care Check-in"
        collectiveMoodHeaderLabel.text = "From  now until then, Luna sheds her healing and nurturing \(chartCake!.transits.moon.sign.keyName) rays, urging you tend to your feelings about \(chartCake!.houseCusps.cusp(for: (chartCake!.transits.moon.longitude)).houseKeywords)"
        
        collectiveMoodSubheaderLabel.text = "\(chartCake!.transits.moon.sign.moonHeaders[0])"
        collectiveMoodContentLabel.text = "\(chartCake!.transits.moon.sign.moonMessages[0])"
        
        // Configure the "Self-Care Check-in" labels
     //   selfCareCheckInTitleLabel.text = "Self-Care Check-in"
        moonHousePlacementLabel.text = ""
        moonConjunctionLabel.text = "\(chartCake!.houseCusps.getMoonData(for: (chartCake?.houseCusps.house(of: (chartCake!.transits.moon)))!).headers[0])"
        selfCareCheckInContentLabel.text = "\(chartCake!.houseCusps.getMoonData(for: (chartCake?.houseCusps.house(of: (chartCake!.transits.moon)))!).message)"
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
        [collectiveMoodTitleLabel, collectiveMoodHeaderLabel, collectiveMoodSubheaderLabel, collectiveMoodContentLabel].forEach(collectiveMoodStackView.addArrangedSubview)
        [selfCareCheckInTitleLabel, moonHousePlacementLabel, moonConjunctionLabel, selfCareCheckInContentLabel].forEach(selfCareCheckInStackView.addArrangedSubview)
        
        // Add stack views to the main content stack view
        contentStackView.addArrangedSubview(pageTitleLabel)
        contentStackView.addArrangedSubview(currentDateLabel)
        contentStackView.addArrangedSubview(collectiveMoodStackView)
        contentStackView.addArrangedSubview(selfCareCheckInStackView)
        contentStackView.addArrangedSubview(tableView1)
        contentStackView.addArrangedSubview(tableView2)
    }
}
