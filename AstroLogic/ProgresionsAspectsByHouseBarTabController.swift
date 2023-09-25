//
//  TabBarController.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import SwiftEphemeris
import UIKit


class ProgressionsAspectsByHouseTabBarController: UITabBarController {

    var chartCake: ChartCake!
    var otherChart: ChartCake!
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()


        let progressedAspects = SimpleProgressedAspectsByHousesVC()
        progressedAspects.selectedDate = Date()
        progressedAspects.chartCake = chartCake
        progressedAspects.tabBarItem = UITabBarItem(title: "Majors", image: UIImage(systemName: "sun.max.fill"), tag: 0)

        // For Minors (moon symbol is just an example; you may need to find a suitable SF Symbol)
        let minorProgressedAspects = SimpleMinorProgressedAspectsByHousesVC()
        minorProgressedAspects.selectedDate = Date()
        minorProgressedAspects.chartCake = chartCake
        minorProgressedAspects.tabBarItem = UITabBarItem(title: "Minors", image: UIImage(systemName: "moon.fill"), tag: 1)

        // For Transits (earth symbol is just an example; you may need to find a suitable SF Symbol)
        let transitAspects = SimpleTransitAspectsByHousesVC()
        transitAspects.selectedDate = Date()
        transitAspects.chartCake = chartCake
        transitAspects.tabBarItem = UITabBarItem(title: "Transits", image: UIImage(systemName: "globe"), tag: 2)

        self.viewControllers = [progressedAspects, minorProgressedAspects, transitAspects]
    }
}
