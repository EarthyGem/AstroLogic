//
//  TabBarController.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import SwiftEphemeris
import UIKit


class ProgressionPlanetsTabBarController: UITabBarController {
    var selectedDate: Date!
    var chartCake: ChartCake!
    var otherChart: ChartCake!

    override func viewDidLoad() {
        super.viewDidLoad()




        let progressedChart = MajorProgressionsViewController(transitPlanets: [""])
        progressedChart.chartCake = chartCake
        progressedChart.selectedDate = selectedDate
        progressedChart.tabBarItem = UITabBarItem(title: "Birthday", image: UIImage(named: "countDownIcon"), tag: 0)


        let minorProgressedChart = MinorProgressionsViewController(transitPlanets: [""])
        progressedChart.chartCake = chartCake
        progressedChart.selectedDate = selectedDate
        minorProgressedChart.tabBarItem = UITabBarItem(title: "Monthly Recharge", image: UIImage(named: "rechargeIcon"), tag: 1)

        let transitChart = TransitPlanets(transitPlanets: [""])
        progressedChart.chartCake = chartCake
        progressedChart.selectedDate = selectedDate
        transitChart.tabBarItem = UITabBarItem(title: "Monthly Action Step", image: UIImage(named: "actionIcon"), tag: 2)



        self.viewControllers = [progressedChart, minorProgressedChart, transitChart]
    }
}
