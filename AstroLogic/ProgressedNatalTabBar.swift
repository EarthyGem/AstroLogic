//
//  TabBarController.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import SwiftEphemeris
import UIKit



class ProgressedTabBarController2: UITabBarController {
    var chart: Chart!
    var selectedDate: Date?
    var chartCake: ChartCake!
    var otherChart: ChartCake!
    var sortedPlanets: [CelestialObject] = []
    var strongestPlanet: String?
    // Custom initializer
     init(chartCake: ChartCake, otherChart: ChartCake) {
         self.chartCake = chartCake
         self.otherChart = otherChart
         super.init(nibName: nil, bundle: nil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
        override func viewDidLoad() {
            super.viewDidLoad()
         //   print("Inside viewDidLoad of PlanetsViewController: \(String(describing: chartCake))")
        
            // .
        // For Planets
            let planetsVC = CompositePlanetsViewController(planets: [""])
            planetsVC.title = "Composite Planets"
            planetsVC.chartCake = chartCake
            planetsVC.otherChart = otherChart
            
            planetsVC.chart = Chart(alpha: chartCake!.natal, bravo: otherChart!.natal)
    //

            planetsVC.tabBarItem = UITabBarItem(title: "Planets", image: UIImage(systemName: "globe"), tag: 0)

        // For Houses
//        let natalHouses = MyNatalHousesVC()
//        natalHouses.chartCake = chartCake
//        natalHouses.tabBarItem = UITabBarItem(title: "Houses", image: UIImage(systemName: "house.fill"), tag: 1)
//
//        // For Aspects
//        let natalAspects = SimpleNatalAspectsViewController()
//        natalAspects.chartCake = chartCake
//        natalAspects.tabBarItem = UITabBarItem(title: "Aspects", image: UIImage(systemName: "point.3.filled.connected.trianglepath.dotted"), tag: 2)

        // Setting the view controllers for the tab bar
        self.viewControllers = [planetsVC]
        //    setupRealmButton()
            
          }

//      //    func setupRealmButton() {
//              let realmButtonItem = UIBarButtonItem(title: "Key Decanates", style: .plain, target: self, action: #selector(didTapRealmButton))
//              navigationItem.rightBarButtonItem = realmButtonItem
//          }

//          @objc func didTapRealmButton() {
//              let realmsVC = DeacanatesViewController(planets: [""])
//              realmsVC.chartCake = self.chartCake
//              realmsVC.title = "Key Decanates"
//              realmsVC.strongestPlanet = self.strongestPlanet
//              self.navigationController?.pushViewController(realmsVC, animated: true)
//          }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     //   print("In viewWillAppear of NatalTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

}
