//
//  MoonVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 10/31/23.
//

import Foundation
import UIKit
import SwiftEphemeris


class SunViewController: UIViewController {
    
    var chartCake: ChartCake!
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
        label.text = "The Sun sets the Season"
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
    
    let collectiveSeasonView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let collectiveSeasonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    let collectiveSeasonTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "The Current Astrological Season"
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let collectiveSeasonHeaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let collectiveSeasonSubheaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let collectiveSeasonContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        // Text will be set later based on `chartCake`
        label.lineBreakMode = .byWordWrapping
        // Configure other label properties
        return label
    }()
    
    let vitalityCheckInView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let vitalityCheckInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    let vitalityCheckInTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Energy Check-in"
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
    
    let vitalityCheckInContentLabel: UILabel = {
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
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)

        setupViews()
        setupLabels()
        setupLayout()
    }
    
    private func setupViews() {
        
        setupRoundedView(collectiveSeasonView, withBackgroundColor: .purple)
        setupRoundedView(vitalityCheckInView, withBackgroundColor: .green)
        
        // Setup for stack views
        setupStackView(collectiveSeasonStackView)
        setupStackView(vitalityCheckInStackView)
        
        // Add subviews to their respective views
        collectiveSeasonView.addSubview(collectiveSeasonStackView)
        vitalityCheckInView.addSubview(vitalityCheckInStackView)
        // Set up the stack views
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        contentStackView.alignment = .fill
        contentStackView.distribution = .equalSpacing
        
        collectiveSeasonStackView.axis = .vertical
        collectiveSeasonStackView.spacing = 5
        
        vitalityCheckInStackView.axis = .vertical
        vitalityCheckInStackView.spacing = 5
        
        // Set up colored views
        collectiveSeasonView.backgroundColor = .purple
        vitalityCheckInView.backgroundColor = .green
        
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
    
        currentDateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        
        // Configure the "Collective Season" labels
        collectiveSeasonTitleLabel.text = "The Current Astrological Season"
        collectiveSeasonHeaderLabel.text = "This \(chartCake!.transits.sun.sign.keyName) season, which lasts from October 23rd to November 22. Sol shines his life-giving rays, urging you enliven your attitudes about \(chartCake!.houseCusps.cusp(for: (chartCake!.transits.sun.longitude)).houseKeywords)"
        if let sunHeader = chartCake?.transits.sun.sign.sunHeaders.randomElement() {
            collectiveSeasonSubheaderLabel.text = sunHeader
        } else {
            collectiveSeasonSubheaderLabel.text = "Default Header" // or some appropriate default
        }

        if let sunContent = chartCake?.transits.sun.sign.sunContent.randomElement() {
            collectiveSeasonContentLabel.text = sunContent
        } else {
            collectiveSeasonContentLabel.text = "Default Content" // or some appropriate default
        }

        
        // Configure the "Self-Care Check-in" labels
        //   vitalityCheckInTitleLabel.text = "Self-Care Check-in"
        moonHousePlacementLabel.text = ""
 //       moonConjunctionLabel.text = "\(chartCake!.houseCusps.getMoonData(for: (chartCake?.houseCusps.house(of: (chartCake!.transits.moon)))!).headers[0])"
    //    vitalityCheckInContentLabel.text = "\(chartCake!.houseCusps.getMoonData(for: (chartCake?.houseCusps.house(of: (chartCake!.transits.moon)))!).message)"
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
        [collectiveSeasonTitleLabel, collectiveSeasonHeaderLabel, collectiveSeasonSubheaderLabel, collectiveSeasonContentLabel].forEach(collectiveSeasonStackView.addArrangedSubview)
        [vitalityCheckInTitleLabel, moonHousePlacementLabel, moonConjunctionLabel, vitalityCheckInContentLabel].forEach(vitalityCheckInStackView.addArrangedSubview)
        
        // Add stack views to the main content stack view
        contentStackView.addArrangedSubview(pageTitleLabel)
        contentStackView.addArrangedSubview(currentDateLabel)
        contentStackView.addArrangedSubview(collectiveSeasonStackView)
        contentStackView.addArrangedSubview(vitalityCheckInStackView)
        contentStackView.addArrangedSubview(tableView1)
        contentStackView.addArrangedSubview(tableView2)
    }
}
