//
//  wheelchart.swift
//  AstroLogic
//
//  Created by Errick Williams on 2/3/24.
//

import Foundation
import UIKit

class WheelChartContent {
    var chart: HoroscopeChart
    var signIntercepts: [SignIntercept]

    init(chart: HoroscopeChart, signIntercepts: [SignIntercept]) {
        self.chart = chart
        self.signIntercepts = signIntercepts
    }
}

class HoroscopeChart {
    var houses: [HouseModel]
    var planets: [PlanetModel]

    init(houses: [HouseModel], planets: [PlanetModel]) {
        self.houses = houses
        self.planets = planets
    }
}

struct SignIntercept {
    var sign: String
    var house: Int
}
