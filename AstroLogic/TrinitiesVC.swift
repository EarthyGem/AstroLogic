//
//  TrinitiesVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/18/23.
//

import Foundation
import UIKit
import DGCharts
import SwiftEphemeris


class TrinityViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var chartCake: ChartCake! // Replace with your actual calculation class
    var explanationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupTrinityPieChart()
        setupExplanationLabel()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000) // Adjust as needed
        view.addSubview(scrollView)
    }

    func setupTrinityPieChart() {
        guard let chartCake = chartCake else {
            print("chartCake is nil")
            return
        }
        let houseScores = chartCake.calculateHouseStrengths() // Your house scores calculation
        let trinityScores = calculateTotalTrinityScores(houseScores: houseScores)
        let trinityPieChartView = createPieChartView(dataEntries: generateTrinityPieChartData(trinityScores: trinityScores))
        trinityPieChartView.frame = CGRect(x: 20, y: 0, width: 350, height: 350)
        scrollView.addSubview(trinityPieChartView)
    }
  

    func calculateTotalTrinityScores(houseScores: [Int: Double]) -> [Trinity: Double] {
        var trinityScores: [Trinity: Double] = [:]

        for (trinity, houses) in trinityHouses {
            for house in houses {
                if let score = houseScores[house] {
                    trinityScores[trinity, default: 0] += score
                }
            }
        }
        //   print("Trinity Scores from Function: \(trinityScores)")
        return trinityScores
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
    
    func generateTrinityPieChartData(trinityScores: [Trinity: Double]) -> [PieChartDataEntry] {
        var dataEntries: [PieChartDataEntry] = []
        let totalScore = trinityScores.values.reduce(0, +) // Calculate the total score
        for (trinity, score) in trinityScores {
            let percentage = (score / totalScore) * 100 // Convert the score to a percentage of the total
            let entry = PieChartDataEntry(value: percentage, label: trinity.rawValue)
            dataEntries.append(entry)
        }
        return dataEntries
    }
    func setupExplanationLabel() {
          explanationLabel = UILabel()
          explanationLabel.numberOfLines = 0 // Allows multiple lines
          explanationLabel.text = "The Houses in an astrological chart can be separated into four trinities. The Trinity of Action embraces the First, Fifth and Ninth Houses. The first house influences the constitution and vitality. The fifth house influences the life of the offspring. The ninth house influences the life in relation to religion and philosophy. This trinity corresponds to the fiery signs of the zodiac. The Trinity of Healing embraces the Fourth, Eighth, and Twelfth Houses. The fourth house influences the home and the end of life. The eighth house influences death and inheritance. The twelfth house influences sorrows and imprisonment. This trinity corresponds to the watery signs of the zodiac. The Trinity of Reality embraces the Second, Sixth, and Tenth Houses. The second house influences personal property. The sixth house influences labor and servants. The tenth house influences business and honor. This trinity corresponds to the earthy signs of the zodiac. The Trinity of Connecting embraces the Third, Seventh and Eleventh Houses. The third house influences the thoughts and the brethren. The seventh house influences partnership and marriage. The eleventh house influences hopes and friends. This trinity corresponds to the airy signs of the zodiac."
        
          explanationLabel.textColor = .white // Adjust the text color as needed
          explanationLabel.font = UIFont.systemFont(ofSize: 14) // Adjust the font size as needed
          explanationLabel.textAlignment = .center // Adjust text alignment as needed

          // Set the frame or use Auto Layout constraints
          explanationLabel.frame = CGRect(x: 20, y: 355, width: view.frame.width - 40, height: 1000) // Adjust the positioning and size as needed
          scrollView.addSubview(explanationLabel)
      }
}
