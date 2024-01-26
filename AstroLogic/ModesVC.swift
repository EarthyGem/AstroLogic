//
//  ModesVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/18/23.
//

import Foundation
import UIKit
import DGCharts
import SwiftEphemeris


class ModesViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var chartCake: ChartCake! // Replace with your actual calculation class
    var explanationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupModalityPieChart()
        setupExplanationLabel()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000) // Adjust as needed
        view.addSubview(scrollView)
    }

    func setupModalityPieChart() {
        guard let chartCake = chartCake else {
            print("chartCake is nil")
            return
        }
        let signScores = chartCake.calculateTotalSignScore()
  
        let modalityScores = calculateTotalModalityScores(signScores: signScores)
        let modalityPieChartView = createPieChartView(dataEntries: generateModalityPieChartData(scores: modalityScores))
        modalityPieChartView.frame = CGRect(x: 20, y: 0, width: 350, height: 350)
        scrollView.addSubview(modalityPieChartView)
    }

    func calculateTotalModalityScores(signScores: [Zodiac: Double]) -> [Modality: Double] {
        var modalityScores: [Modality: Double] = [.pioneer: 0, .perfector: 0, .developer: 0]

        for (modality, signs) in modalitySigns {
            for sign in signs {
                if let score = signScores[sign] {
                    modalityScores[modality, default: 0] += score
                }
            }
        }

        return modalityScores
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
    
    func generateModalityPieChartData(scores: [Modality: Double]) -> [PieChartDataEntry] {
        var dataEntries: [PieChartDataEntry] = []
        let totalScore = scores.values.reduce(0, +) // Calculate the total score
        for (modality, score) in scores {
            let percentage = (score / totalScore) * 100 // Convert the score to a percentage of the total
            let entry = PieChartDataEntry(value: percentage, label: modality.rawValue)
            dataEntries.append(entry)
        }
        return dataEntries
    }
  
   
    func setupExplanationLabel() {
          explanationLabel = UILabel()
          explanationLabel.numberOfLines = 0 // Allows multiple lines
          explanationLabel.text = "The signs of the Movable Quality are Aries, Cancer, Libra, and Capricorn. They express the nature of each of the four elements in the highest state of activity. Matter in the gaseous state, though chemically the same, is far more active and possesses different qualities than when in the liquid or solid state. People, also, born under the movable signs, are active, energetic, and given to change; even as gas generates power and finds it easy to move in various directions little hindered by gravitation. They break the trails that others follow, and start the enterprises that others finish. The natives of Aries pioneer in daring enterprises and adventure. Cancer people pioneer in home building and in foods. Those born under Libra pioneer in literature, art, and social affairs; while those belonging to the sign Capricorn are pioneers in business and industry. The signs of the movable quality produce people who are PIONEERS. The signs of the Mutable Quality are Gemini, Virgo, Sagittarius, and Pisces. They express the nature of each of the four elements in a medium state of activity. Matter in the liquid state, though possessing the same chemical elements as when gaseous or solid, is more subject to gravitation and less aggressive in its chemical action than when gaseous; but more active and yielding, and less given to permanence than when in the solid state. The mutable signs are a happy medium between the excessive activity of the movable signs and the stubborn resistance of the fixed signs. Liquid cannot force its way through an aperture as easily as can gas, but once a channel has been established it quickly follows the line of least resistance. People born under the mutable signs seldom break trails, but follow on the heels of the pioneers. As liquid conforms to the object with which it is in contact, so mutable people are the most adaptable of all. The signs of the mutable quality produce people who seldom originate an enterprise. They are the DEVELOPERS. The signs of the Fixed Quality are Taurus, Leo, Scorpio, and Aquarius. They express the nature of each of the four elements in the lowest state of activity. Matter in the solid state is rigid, durable, and unyielding. People born under the fixed signs are quite as unbending, firm, and resistant. Solids find difficulty in altering their form and location; and people belonging to the fixed signs are strongly attached to their customary environment, their customary manner of doing things, and their customary methods of thought. They have great resistance to pressure of all kinds, strong endurance, plodding perseverance and the ability to give close attention to detail. They are not originators, and not enthusiastic developers; but when development has reached a high degree, they work out details that constitute improvements. The signs of the fixed quality produce people who are PERFECTERS."
          explanationLabel.textColor = .white // Adjust the text color as needed
          explanationLabel.font = UIFont.systemFont(ofSize: 14) // Adjust the font size as needed
          explanationLabel.textAlignment = .center // Adjust text alignment as needed
          explanationLabel.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
          
          scrollView.addSubview(explanationLabel)

          // Constraints
          let margins = scrollView.layoutMarginsGuide
          NSLayoutConstraint.activate([
              explanationLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 300), // Adjust the top constraint as needed
              explanationLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20), // Left padding
              explanationLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20), // Right padding
              explanationLabel.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor) // If you want to constrain the bottom
          ])
      }

}
