//
//  DailySunTBC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/1/24.
//

import Foundation
//
//  DailyTabBarController.swift
//  AstroLogic
//


import Foundation
import SwiftEphemeris
import UIKit



class DailySunTabBarController: UITabBarController {

    var selectedDate: Date?
    var chartCake: ChartCake!
    var sortedPlanets: [CelestialObject] = []
    var phaseName: String!

    // Custom initializer
     init(chartCake: ChartCake) {
         self.chartCake = chartCake
   
         super.init(nibName: nil, bundle: nil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
        override func viewDidLoad() {
            super.viewDidLoad()
            print("Inside viewDidLoad of PlanetsViewController: \(String(describing: chartCake))")
        
            // .
        // For Planets
            let sunVC = SunViewController()
               // Pass chartCake to PlanetsViewController
            sunVC.chartCake = self.chartCake
            sunVC.tabBarItem = UITabBarItem(title: "Sun Season", image: UIImage(systemName: "sun.max.fill"), tag: 0)

        // For Houses
        let sunHouses = SunViewController()
            sunHouses.chartCake = chartCake
            sunHouses.tabBarItem = UITabBarItem(title: "Sun in House", image: UIImage(systemName: "house.fill"), tag: 1)

        // For Aspects
        let sunAspects = CurrentMoonPhaseViewController()
            sunAspects.chartCake = chartCake
            sunAspects.phaseName = self.phaseName
            sunAspects.tabBarItem = UITabBarItem(title: "Sun Aspects", image: UIImage(systemName: "globe"), tag: 2)
       

        // Setting the view controllers for the tab bar
        self.viewControllers = [sunVC, sunHouses, sunAspects]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("In viewWillAppear of NatalTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

}
