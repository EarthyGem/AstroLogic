//
//  DailyMoonTabBar.swift
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



class DailyMoonTabBarController: UITabBarController {

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
          //  print("Inside viewDidLoad of PlanetsViewController: \(String(describing: chartCake))")
        
            // .
        // For Planets
            
            let moonPhase = CurrentMoonPhaseViewController()
            moonPhase.chartCake = chartCake
            moonPhase.phaseName = self.phaseName
            moonPhase.tabBarItem = UITabBarItem(title: "Aspects", image: UIImage(systemName: "globe"), tag: 0)
          
            let moonHoroscope = MoonViewController()
            moonHoroscope.chartCake = chartCake
       //     moonHoroscope.phaseName = self.phaseName
            moonHoroscope.tabBarItem = UITabBarItem(title: "Aspects", image: UIImage(systemName: "globe"), tag: 2)

            
            
            
            let moonInSigns = SunMoonSeasonVC()
               // Pass chartCake to PlanetsViewController
            moonInSigns.chartCake = self.chartCake
            moonInSigns.tabBarItem = UITabBarItem(title: "Moon in Signs", image: UIImage(systemName: "moon.max.fill"), tag: 2)

        // For Houses
        let moonInHouses = HouseTransitionVC()
            moonInHouses.chartCake = chartCake
            moonInHouses.tabBarItem = UITabBarItem(title: "Moon in Houses", image: UIImage(systemName: "sun.fill"), tag: 3)

        // For Aspects
      
            
          


        // Setting the view controllers for the tab bar
        self.viewControllers = [moonPhase, moonHoroscope, moonInSigns, moonInHouses]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // print("In viewWillAppear of NatalTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

}
