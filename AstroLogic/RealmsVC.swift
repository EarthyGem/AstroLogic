//
//  RealmsVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/18/23.
//

import Foundation
import UIKit
import Charts
import DGCharts
import SwiftEphemeris

class RealmsViewController: UIViewController, ChartViewDelegate {

    var pieChartView: PieChartView!
    var chartCake: ChartCake!

    enum Realm: String {
        case order = "Order"
        case relationship = "Relationship"
        case creativity = "Creativity"
        case change = "Change"
        case action = "Action"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPieChartView()

        let scores = getTotalPowerScoresForRealms()
        setupPieChartData(with: scores)
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }

    func setupPieChartView() {
        pieChartView = PieChartView(frame: self.view.bounds)
        pieChartView.delegate = self
        pieChartView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pieChartView)
    }

    func getTotalPowerScoresForRealms() -> [Realm: Double] {
        let planetScores = chartCake.getTotalPowerScoresForPlanets()

        var realmScores: [Realm: Double] = [
            .order: 0.0,
            .relationship: 0.0,
            .creativity: 0.0,
            .change: 0.0,
            .action: 0.0
        ]

        for (planet, score) in planetScores {
            switch planet {
            case Planet.sun.celestialObject, Planet.saturn.celestialObject:
                realmScores[.order]! += score
            case Planet.moon.celestialObject, Planet.venus.celestialObject:
                realmScores[.relationship]! += score
            case Planet.mercury.celestialObject, Planet.neptune.celestialObject:
                realmScores[.creativity]! += score
            case Planet.uranus.celestialObject, Planet.pluto.celestialObject:
                realmScores[.change]! += score
            case Planet.mars.celestialObject, Planet.jupiter.celestialObject:
                realmScores[.action]! += score
            default:
                continue
            }
        }

        return realmScores
    }

    func setupPieChartData(with rawScores: [Realm: Double]) {
        var dataEntries: [PieChartDataEntry] = []
        let scores = normalizeScores(rawScores)

        for (realm, score) in scores {
            let entry = PieChartDataEntry(value: score, label: realm.rawValue)
            dataEntries.append(entry)
        }

        let dataSet = PieChartDataSet(entries: dataEntries, label: "Realms")
        dataSet.colors = ChartColorTemplates.colorful()  // Customize with your own colors

        // Use the PercentFormatter
        dataSet.valueFormatter = DefaultValueFormatter(formatter: PercentFormatter2())

        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        pieChartView.notifyDataSetChanged()
    }

    func normalizeScores(_ scores: [Realm: Double]) -> [Realm: Double] {
        let totalScore = scores.values.reduce(0, +)
        var normalizedScores: [Realm: Double] = [:]
        for (key, value) in scores {
            normalizedScores[key] = value / totalScore * 100
        }
        return normalizedScores
    }

    // ... Your getTotalPowerScoresForPlanets() function and other necessary functions will also be part of this ViewController ...

}

class PercentFormatter2: NumberFormatter {
    override init() {
        super.init()
        self.numberStyle = .percent
        self.maximumFractionDigits = 1
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func string(from number: NSNumber) -> String? {
        return super.string(from: number)
    }
}
