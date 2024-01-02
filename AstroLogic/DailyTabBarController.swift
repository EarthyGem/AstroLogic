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
          //  print("Inside viewDidLoad of PlanetsViewController: \(String(describing: chartCake))")
        
            // .
        // For Planets
            let lunarPhase = chartCake.lunarPhase(for: chartCake.transits)
                  let tabBarItemImageName = tabImageName(for: lunarPhase)
            let lightGreenColor = UIColor.systemGreen.withAlphaComponent(0.6) // Adjust the green color as needed
            let lightOrangeColor = UIColor.systemOrange.withAlphaComponent(0.6) // Light orange color

            let lightSkyBlueColor = UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 0.6) // Light sky blue color

            
                  let planetsVC = CurrentMoonPhaseViewController()
                  planetsVC.chartCake = self.chartCake
            planetsVC.tabBarItem = UITabBarItem(title: "Moon", image: UIImage(systemName: tabImageName(for: chartCake.lunarPhase(for: chartCake.transits))), tag: 0)
            planetsVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: lightGreenColor], for: .normal)
            planetsVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: lightGreenColor], for: .selected)
        // For Houses
        let natalHouses = SunViewController()
        natalHouses.chartCake = chartCake
        natalHouses.tabBarItem = UITabBarItem(title: "Sun", image: UIImage(systemName: "sun.max"), tag: 1)
            natalHouses.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: lightOrangeColor], for: .normal)
            natalHouses.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: lightOrangeColor], for: .selected)
        // For Aspects
      

            
            let currentSky = TransitPlanets(transitPlanets: [""])
            currentSky.chartCake = chartCake
         //   natalAspects.phaseName = self.phaseName
            currentSky.tabBarItem = UITabBarItem(title: "Current Sky", image: UIImage(systemName: "sun.dust.circle"), tag: 2)
            currentSky.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: lightSkyBlueColor], for: .normal)
            currentSky.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: lightSkyBlueColor], for: .selected)

        // Setting the view controllers for the tab bar
        self.viewControllers = [planetsVC, natalHouses, currentSky]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // print("In viewWillAppear of NatalTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }
    private func tabImageName(for lunarPhase: LunarPhase) -> String {
        switch lunarPhase {
        case .NewMoon:
            return "moon.fill" // New Moon
        case .WaxingCrescent:
            return "moonphase.waxing.crescent" // Waxing Crescent
        case .FirstQuarter:
            return "moonphase.first.quarter" // First Quarter
        case .WaxingGibbous:
            return "moonphase.waxing.gibbous" // Waxing Gibbous
        case .FullMoon:
            return "moon.full.fill" // Full Moon
        case .WaningGibbous:
            return "moonphase.waning.gibbous" // Waning Gibbous
        case .LastQuarter:
            return "moonphase.last.quarter" // Last Quarter
        case .WaningCrescent:
            return "moonphase.waning.crescent" // Waning Crescent
        }
    }


}
