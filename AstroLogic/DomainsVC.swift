//
//  DomainsVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/18/23.
//

import Foundation
import UIKit
import DGCharts
import SwiftEphemeris

class DomainViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var chartCake: ChartCake! // Replace with your actual calculation class
    var explanationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupDomainPieChart()
        setupExplanationLabel()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000) // Adjust as needed
        view.addSubview(scrollView)
    }

    func setupDomainPieChart() {
        guard let chartCake = chartCake else {
            print("chartCake is nil")
            return
        }
        let houseScores = chartCake.calculateHouseStrengths() // Your house scores calculation
        let domainScores = calculateTotalDomainScores(houseScores: houseScores)
        let domainPieChartView = createPieChartView(dataEntries: generateDomainPieChartData(domainScores: domainScores))
        domainPieChartView.frame = CGRect(x: 20, y: 0, width: 350, height: 350)
        scrollView.addSubview(domainPieChartView)
    }
    func calculateTotalDomainScores(houseScores: [Int: Double]) -> [Domain: Double] {
        var domainScores: [Domain: Double] = [:]

        for (domain, houses) in domainHouses {
            for house in houses {
                if let score = houseScores[house] {
                    domainScores[domain, default: 0] += score
                }
            }
        }
        //  print("Domain Scores from Function: \(domainScores)")
        return domainScores
    }
    
    func createPieChartView(dataEntries: [PieChartDataEntry]) -> PieChartView {
        let pieChartView = PieChartView()
        let dataSet = PieChartDataSet(entries: dataEntries, label: "Power")
        dataSet.valueFormatter = PercentFormatter() // Set the valueFormatter to an instance of the PercentFormatter

        dataSet.colors = ChartColorTemplates.material()
        pieChartView.holeRadiusPercent = 0.2
        pieChartView.transparentCircleRadiusPercent = 0.3
        pieChartView.legend.enabled = false

        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        pieChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
        return pieChartView
    }
    

    func generateDomainPieChartData(domainScores: [Domain: Double]) -> [PieChartDataEntry] {
        var dataEntries: [PieChartDataEntry] = []
        let totalScore = domainScores.values.reduce(0, +) // Calculate the total score
        for (domain, score) in domainScores {
            let percentage = (score / totalScore) * 100 // Convert the score to a percentage of the total
            let entry = PieChartDataEntry(value: percentage, label: domain.rawValue)
            dataEntries.append(entry)
        }
        return dataEntries
    }
    
    func setupExplanationLabel() {
          explanationLabel = UILabel()
          explanationLabel.numberOfLines = 0 // Allows multiple lines
          explanationLabel.text = "The Houses, or departments of life, are naturally grouped into three categories or domains: Personal, Companionship and Public. This is a good indicator of where your interests, desires and energy naturally incline. This can be especially helpful in analyzing close personal relationships like marriage, where partners interests are largely focused in different domains, e. g., public or personal vs companionship. Cultural gender differences can also ameliorate or exacerbate diverging interests and desires...The Personal Houses embrace the Twelfth, First, Second, and Third. They influence personal sorrows, the personal body, the personal property, the brethren and personal thoughts. These houses have to do with the private life. The Companionship Houses embrace the Fourth, Fifth, Sixth, and Seventh. They influence the companionship in the home and at the end of life, the companionship in pleasure and with children, the companionship in work and with servants, and the companionship in partnership, in marriage, and in meeting the public. These houses have to do with closely contacting people. The Public Houses embrace the Eighth, Ninth, Tenth, and Eleventh. They influence the public life through deaths and legacies, through advertising and public utterances, through reputation and credit and through friends. These houses have to do with matters that become widely known.If many planets are found in Personal houses it signifies that much of life’s total energy is diverted to personal concerns. If many planets are found in Companionship houses it denotes that much of life’s total energy is absorbed in contact with others. If many planets are found in Public houses it indicates that much of life’s total energy is expended in activities that come before the notice of the public. "
          explanationLabel.textColor = .white // Adjust the text color as needed
          explanationLabel.font = UIFont.systemFont(ofSize: 14) // Adjust the font size as needed
          explanationLabel.textAlignment = .center // Adjust text alignment as needed

          // Set the frame or use Auto Layout constraints
          explanationLabel.frame = CGRect(x: 20, y: 300, width: view.frame.width - 40, height: 1000) // Adjust the positioning and size as needed
          scrollView.addSubview(explanationLabel)
      }
}

