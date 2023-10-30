//
//  TabBarController.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import SwiftEphemeris
import UIKit


class ProgressionsAspectsTabBarController: UITabBarController {
    var selectedDate: Date?
    var chartCake: ChartCake!
    var otherChart: ChartCake!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Debug in ProgressionsAspectsTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))") // Debugging line 1
          print("Memory address in ProgressionsAspectsTabBarController: \(Unmanaged.passUnretained(self).toOpaque())") // Debugging line 2

        // For Majors (sun symbol is just an example; you may need to find a suitable SF Symbol)
        let progressedAspects = SimpleMajorAspectsViewController()
        progressedAspects.selectedDate = self.selectedDate
        progressedAspects.chartCake = chartCake
        progressedAspects.tabBarItem = UITabBarItem(title: "Majors", image: UIImage(systemName: "sun.max.fill"), tag: 0)

        // For Minors (moon symbol is just an example; you may need to find a suitable SF Symbol)
        let minorProgressedAspects = SimpleMinorAspectViewController()
        minorProgressedAspects.selectedDate = selectedDate
        minorProgressedAspects.chartCake = chartCake
        minorProgressedAspects.tabBarItem = UITabBarItem(title: "Minors", image: UIImage(systemName: "moon.fill"), tag: 1)

        // For Transits (earth symbol is just an example; you may need to find a suitable SF Symbol)
        let transitAspects = SimpleTransitAspectedPlanetsViewController()
        transitAspects.selectedDate = selectedDate
        transitAspects.chartCake = chartCake
        transitAspects.tabBarItem = UITabBarItem(title: "Transits", image: UIImage(systemName: "globe"), tag: 2)

        self.viewControllers = [progressedAspects, minorProgressedAspects, transitAspects]

        print("Debug After Set: \(String(describing: progressedAspects.selectedDate)), \(String(describing: progressedAspects.chartCake))")
        _ = progressedAspects.view
        _ = minorProgressedAspects.view
        _ = transitAspects.view

       }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("In viewWillAppear of TabBarController - ProgressionsAspectsTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

    }

