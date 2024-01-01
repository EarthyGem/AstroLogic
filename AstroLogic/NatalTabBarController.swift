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
    var celestialObject: CelestialObject!
    // Custom initializer
    init(chartCake: ChartCake, sortedPlanets: [CelestialObject], celstialObject: CelestialObject) {
         self.chartCake = chartCake
         self.sortedPlanets = sortedPlanets
         self.celestialObject = celstialObject
         super.init(nibName: nil, bundle: nil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
        override func viewDidLoad() {
            super.viewDidLoad()
          //  print("Inside viewDidLoad of PlanetsViewController: \(String(describing: chartCake))")
        
            // .
        // For Planets
            let archetypeMatrixVC = ArchetypeMatrixViewController() // Or instantiate from storyboard
            archetypeMatrixVC.chartCake = chartCake
            archetypeMatrixVC.selectedCelestialObject = celestialObject
            archetypeMatrixVC.tabBarItem = UITabBarItem(title: "Planets", image: UIImage(systemName: "orbit.fill"), tag: 0)

        // For Houses
        let natalHouses = MyNatalHousesVC()
        natalHouses.chartCake = chartCake
        natalHouses.tabBarItem = UITabBarItem(title: "Houses", image: UIImage(systemName: "house.fill"), tag: 1)

        // For Aspects
        let natalAspects = SimpleNatalAspectsViewController()
        natalAspects.chartCake = chartCake
        natalAspects.tabBarItem = UITabBarItem(title: "Aspects", image: UIImage(systemName: "globe"), tag: 2)

        // Setting the view controllers for the tab bar
        self.viewControllers = [archetypeMatrixVC, natalHouses, natalAspects]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // print("In viewWillAppear of NatalTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

}
