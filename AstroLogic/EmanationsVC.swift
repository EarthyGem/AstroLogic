//
//  EmanationsVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/18/23.
//

import Foundation
import UIKit
import DGCharts
import SwiftEphemeris

class EmanationsViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var chartCake: ChartCake! // Replace with your actual calculation class
    var explanationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupEmanationPieChart()
        setupExplanationLabel()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000) // Adjust as needed
        view.addSubview(scrollView)
    }

    func setupEmanationPieChart() {
        guard let chartCake = chartCake else {
            print("chartCake is nil")
            return
        }
        let signScores = chartCake.calculateTotalSignScore()
        let emanationScores = calculateTotalEmanationScores(signScores: signScores)
        let emanationPieChartView = createPieChartView(dataEntries: generateEmanationPieChartData(scores: emanationScores))
        emanationPieChartView.frame = CGRect(x: 20, y: 0, width: 350, height: 350)
        scrollView.addSubview(emanationPieChartView)
    }
    func calculateTotalEmanationScores(signScores: [Zodiac: Double]) -> [Emanation: Double] {
        var emanationScores: [Emanation: Double] = [.liberty: 0, .modification: 0, .reserve: 0]

        for (emanation, signs) in emanationSigns {
            for sign in signs {
                if let score = signScores[sign] {
                    emanationScores[emanation, default: 0] += score
                }
            }
        }

        return emanationScores
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
    
    func generateEmanationPieChartData(scores: [Emanation: Double]) -> [PieChartDataEntry] {
        var dataEntries: [PieChartDataEntry] = []
        let totalScore = scores.values.reduce(0, +) // Calculate the total score
        for (element, score) in scores {
            let percentage = (score / totalScore) * 100 // Convert the score to a percentage of the total
            let entry = PieChartDataEntry(value: percentage, label: element.rawValue)
            dataEntries.append(entry)
        }
        return dataEntries
    }
    func setupExplanationLabel() {
          explanationLabel = UILabel()
          explanationLabel.numberOfLines = 0 // Allows multiple lines
          explanationLabel.text = "This tone quality is thus still further elaborated by considering the sign’s precedence in the zodiac, compared to other signs of the same triplicity. This designation is called its Degree of Emanation. The first sign of a triplicity in the zodiac belongs to the first degree of emanation, the second sign to the second degree of emanation, and the third sign to the third degree of emanation. The signs of the First Degree of Emanation are Aries, Taurus, Gemini, and Cancer. People born under these signs act from motives that chiefly spring from their own feelings, ideas, and inward yearnings. When expressing themselves they tend to externalize their own inner nature with LIBERTY. The signs of the second Degree of Emanation are Leo, Virgo, Libra, and Scorpio. People born under these signs act from their own feelings, ideas, and inward yearnings, tempered by a full consideration of what other people feel, think, and advise. When expressing themselves they tend to externalize their own inner nature with MODIFICATION. The signs of the Third Degree of Emanation are Sagittarius, Capricorn, Aquarius, and Pisces. People born under these signs act less from their own feelings, ideas, and inward yearnings, than from ideas and attitudes that have reached them from without. When expressing themselves they tend to externalize their own inner nature with RESERVE."
          explanationLabel.textColor = .white // Adjust the text color as needed
          explanationLabel.font = UIFont.systemFont(ofSize: 15) // Adjust the font size as needed
          explanationLabel.textAlignment = .center // Adjust text alignment as needed

          // Set the frame or use Auto Layout constraints
          explanationLabel.frame = CGRect(x: 20, y: 355, width: view.frame.width - 40, height: 1000) // Adjust the positioning and size as needed
          scrollView.addSubview(explanationLabel)
      }
}

