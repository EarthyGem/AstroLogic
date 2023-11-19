//
//  ElementsVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/18/23.
//

import Foundation
import UIKit
import DGCharts
import SwiftEphemeris

class ElementsViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var chartCake: ChartCake! // Assuming ChartCake is your custom class for calculations
    var explanationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupElementPieChart()
        setupExplanationLabel()
        
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000) // Adjust the height as needed
        view.addSubview(scrollView)
    }

    func setupElementPieChart() {
       guard let chartCake = chartCake else {
           print("chartCake is nil")
           return
       }
       let signScores = chartCake.calculateTotalSignScore()
       if signScores.isEmpty {
           print("signScores is empty")
           return
       }
       let elementScores = calculateTotalElementScores(signScores: signScores)
       if elementScores.isEmpty {
           print("elementScores is empty")
           return
       }
       let elementPieChartView = createPieChartView(dataEntries: generateElementPieChartData(scores: elementScores))
       elementPieChartView.frame = CGRect(x: 20, y: 0, width: 350, height: 350)
       scrollView.addSubview(elementPieChartView)
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



    func generatePieChartData(scores: [Zodiac: Double]) -> [PieChartDataEntry] {
        var dataEntries: [PieChartDataEntry] = []
        let totalScore = scores.values.reduce(0, +) // Calculate the total score
        for (sign, score) in scores {
            let percentage = (score / totalScore) * 100 // Convert the score to a percentage of the total
            let entry = PieChartDataEntry(value: percentage, label: sign.keyName)
            dataEntries.append(entry)
        }
        return dataEntries
    }

    func generateElementPieChartData(scores: [Element: Double]) -> [PieChartDataEntry] {
        var dataEntries: [PieChartDataEntry] = []
        let totalScore = scores.values.reduce(0, +) // Calculate the total score
        for (element, score) in scores {
            let percentage = (score / totalScore) * 100 // Convert the score to a percentage of the total
            let entry = PieChartDataEntry(value: percentage, label: element.rawValue)
            dataEntries.append(entry)
        }
        return dataEntries
    }


    func calculateTotalElementScores(signScores: [Zodiac: Double]) -> [Element: Double] {
        var elementScores: [Element: Double] = [.inspiration: 0, .practicality: 0, .intellect: 0, .emotion: 0]

        for (element, signs) in elementSigns {
            for sign in signs {
                if let score = signScores[sign] {
                    elementScores[element, default: 0] += score
                }
            }
        }

        return elementScores
    }

    func setupExplanationLabel() {
          explanationLabel = UILabel()
          explanationLabel.numberOfLines = 0 // Allows multiple lines
          explanationLabel.text = "Each triplicity is named after one of the four ancient elements to which it corresponds. These were not considered elements in the sense that chemistry considers sulphur, mercury, carbon, and radium, elements. After all, these latter are no more elements than the ancient fire, water, earth, and air; for all are composed of electrons and protons. Fire, to the ancients, was an abstraction by which the qualities of energy, zeal, and enthusiasm, whether expressed in a mineral such as sulphur, or in a vegetable such as mustard, or in a beast, such as a wildcat, might be designated. Water was used to express fluidity, receptivity, and germination. Earth was used to express coldness, concreteness, and solidity. Air was used to express vacillation, intangibleness, alertness, and fleetness. The terms, fiery, watery, earthy, and airy, were applied alike to objects, persons, and zodiacal signs. The fiery element represents the positive, masculine, even as the heat rays of the sun fall upon the world. The watery triplicity is the negative, feminine, such as the moisture that quenches the thirst of the parched desert. The earthy triplicity is the point of union of masculine and feminine forces, as water and heat meet in the earth to germinate whatever seeds lie in the ground. The airy triplicity is the product springing from the union, the harvest brought forth in due season. As applied to man we may say that the union of enthusiasm and affection gestates as effort which results in intelligence. Or, stating it in terms of the fourfold sphinx, we may say that the energy of the Lion expresses through the sex of the Eagle, bringing about material incarnation and the plodding toil of the Bull, to the end of evolving the immortal Man. In our study of the triplicities, and in our study of the signs as separate influences, we shall find it convenient to designate their relation to human types and human life. Not that their influence is confined to humanity, but because we are familiar with human qualities. When we learn their correspondences in terms of human character, it will then be no difficult task to determine their correspondences in other departments of nature. The Fiery Triplicity embraces the signs, Aries, Leo, and Sagittarius. People with Fire as their dominant element possess self-reliance, enthusiasm, zeal, courage, daring, the ability to command others, and a love of activity. In the sense of being able to arouse in themselves and communicate to others initiative and enthusiasm, their characteristic quality is INSPIRATION. The Watery Triplicity embraces the signs Cancer, Scorpio, and Pisces. Watery people's lives are largely centered in the home and affections. They are sympathetic, timid, dreamy, submissive, given to domestic life, receptive, yielding, mediumistic, and greatly influenced by their surroundings. In the sense that they are chiefly actuated by their feelings, rather than by carefully reasoned lines of conduct, their characteristic quality is EMOTION. The Earthy Triplicity embraces the signs Taurus, Virgo, and Capricorn. People born with a predominance of Earth are not given to bursts of enthusiasm, but express their ideas concretely, having the ability to apply themselves patiently to the affairs of this life and to turn all they contact to some material use. On the farm, associated with some industry, or managing some great corporation, they are toilers. In the sense of relying upon reason and the reports of the senses, and in interesting themselves in the affairs of earth that have value here and now, their characteristic quality is PRACTICALITY. The Airy Triplicity embraces the signs Gemini, Libra, and Aquarius. People with air dominant are mentally alert, volatile, changeable, and socially inclined, desiring to live largely upon the mental plane. They are interested in education, literature, and art, are fond of conversation, and find pleasure in the exchange of ideas. In the sense of desiring refinement and intellectual culture, their characteristic quality is ASPIRATION."
          explanationLabel.textColor = .white // Adjust the text color as needed
          explanationLabel.font = UIFont.systemFont(ofSize: 14) // Adjust the font size as needed
          explanationLabel.textAlignment = .center // Adjust text alignment as needed

          // Set the frame or use Auto Layout constraints
          explanationLabel.frame = CGRect(x: 20, y: 350, width: view.frame.width - 40, height: 1400) // Adjust the positioning and size as needed
          scrollView.addSubview(explanationLabel)
      }

}
