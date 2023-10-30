//
//  TabBarController.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import SwiftEphemeris
import UIKit



class NatalTabBarController: UITabBarController {

    var selectedDate: Date?
    var chartCake: ChartCake!
    var sortedPlanets: [CelestialObject] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            print("Inside viewDidLoad of PlanetsViewController: \(String(describing: chartCake))")
        
            // .
        // For Planets
        let natalPlanets = PlanetsViewController(planets: [""])
        natalPlanets.chartCake = chartCake
        natalPlanets.sortedPlanets = sortedPlanets
        natalPlanets.tabBarItem = UITabBarItem(title: "Planets", image: UIImage(systemName: "planet.max.fill"), tag: 0)

        // For Houses
        let natalHouses = MyNatalHousesVC()
        natalHouses.chartCake = chartCake
        natalHouses.tabBarItem = UITabBarItem(title: "Houses", image: UIImage(systemName: "house.fill"), tag: 1)

        // For Aspects
        let natalAspects = NatalAspectsViewController()
        natalAspects.chartCake = chartCake
        natalAspects.tabBarItem = UITabBarItem(title: "Aspects", image: UIImage(systemName: "globe"), tag: 2)

        // Setting the view controllers for the tab bar
        self.viewControllers = [natalPlanets, natalHouses, natalAspects]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("In viewWillAppear of NatalTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

}
