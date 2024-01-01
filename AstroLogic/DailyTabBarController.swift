//
//  DailyTabBarController.swift
//  AstroLogic
//


import Foundation
import SwiftEphemeris
import UIKit



class DailyTabBarController: UITabBarController {

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
            let planetsVC = CurrentMoonPhaseViewController()
               // Pass chartCake to PlanetsViewController
               planetsVC.chartCake = self.chartCake
            planetsVC.tabBarItem = UITabBarItem(title: "Moon", image: UIImage(systemName: "moon.max.fill"), tag: 0)

        // For Houses
        let natalHouses = SunViewController()
        natalHouses.chartCake = chartCake
        natalHouses.tabBarItem = UITabBarItem(title: "Sun", image: UIImage(systemName: "sun.fill"), tag: 1)

        // For Aspects
      

            
            let currentSky = TransitPlanets(transitPlanets: [""])
            currentSky.chartCake = chartCake
         //   natalAspects.phaseName = self.phaseName
            currentSky.tabBarItem = UITabBarItem(title: "Current Sky", image: UIImage(systemName: "sky"), tag: 2)


        // Setting the view controllers for the tab bar
        self.viewControllers = [planetsVC, natalHouses, currentSky]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("In viewWillAppear of NatalTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

}
