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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let pageTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "The ever changing Moon lights up new pathways and casts shade on others, Let the Moon light your path"
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties like font, text alignment, etc.
        return label
    }()
    
    let currentDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let collectiveMoodView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let collectiveMoodStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    let collectiveMoodTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let collectiveMoodHeaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let collectiveMoodSubheaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let collectiveMoodContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let selfCareCheckInView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let selfCareCheckInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    let selfCareCheckInTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Current Moon Phase"
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let moonHousePlacementLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let moonConjunctionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let selfCareCheckInContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    
    let tableView1: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // Configure tableView properties like dataSource, delegate, etc.
        return tableView
    }()
    
    let tableView2: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // Configure tableView properties
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 0.7, alpha: 1.0)

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
        collectiveMoodStackView.spacing = 10
        
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
        collectiveMoodTitleLabel.text = "Daily Lunar Horoscope"
        collectiveMoodHeaderLabel.text = "\(chartCake!.transits.moon.decanates.moonHeader)\n\(chartCake!.transits.moon.decanates.moonMessage)"
        
        collectiveMoodSubheaderLabel.text = "For the next day or so, Luna sheds her tender caring \(chartCake!.transits.moon.sign.keyName) rays on your  \(chartCake!.houseCusps.cusp(for: (chartCake!.transits.moon.longitude)).name) house, inviting you to tend to your \(chartCake!.houseCusps.cusp(for: (chartCake!.transits.moon.longitude)).houseKeywords)"
        collectiveMoodContentLabel.text = "\(chartCake!.houseCusps.cusp(for: (chartCake!.transits.moon.longitude)).moonHeaders[0])\n\(chartCake!.houseCusps.cusp(for: (chartCake!.transits.moon.longitude)).moonMessages[0])"
        
        // Configure the "Self-Care Check-in" labels
          selfCareCheckInTitleLabel.text =  ""
        moonHousePlacementLabel.text = "Current Moon Phase\n\n\(chartCake!.lunarPhase(for: chartCake!.transits).rawValue )  \(chartCake!.lunarPhase(for: chartCake!.transits).emoji)\n\(chartCake!.lunarPhase(for: chartCake!.transits).messages[0])"
        moonConjunctionLabel.text = ""
        
        selfCareCheckInContentLabel.text = ""
    }
    
    private func setupRoundedView(_ view: UIView, withBackgroundColor color: UIColor) {
        view.backgroundColor = color
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    private func setupStackView(_ stackView: UIStackView) {
        stackView.axis = .vertical
        stackView.spacing = 10
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
    
    
    func getMoonPhaseText() -> String {
        guard let lunarPhase = chartCake?.lunarPhase(for: chartCake!.transits) else {
            return "Moon phase information is currently unavailable."
        }
        
        // Get the current month as an integer
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        // Retrieve the message for the current lunar phase and month
        return lunarPhase.messageFor(month: currentMonth)
    }

}
