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
    var latitude: Double?
    var longitude: Double?
    init(chartCake: ChartCake, selectedDate: Date) {
        self.chartCake = chartCake
        self.selectedDate = selectedDate
  
        super.init(nibName: nil, bundle: nil)
    }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
  
    override func viewDidLoad() {
        super.viewDidLoad()

    //    print("Debug in ProgressionsAspectsTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))") // Debugging line 1
       //   print("Memory address in ProgressionsAspectsTabBarController: \(Unmanaged.passUnretained(self).toOpaque())") // Debugging line 2

        // For Majors (sun symbol is just an example; you may need to find a suitable SF Symbol)
        let progressedAspects = SimpleAllProgressionsAspectedPlanetsViewController()
        progressedAspects.selectedDate = selectedDate
        progressedAspects.chartCake = chartCake
        progressedAspects.tabBarItem = UITabBarItem(title: "Progressed Aspects", image: UIImage(systemName: "point.3.connected.trianglepath.dotted"), tag: 0)

        // For Minors (moon symbol is just an example; you may need to find a suitable SF Symbol)
        let majorProgressedAspects = MajorProgressionsViewController(transitPlanets: [""])
        majorProgressedAspects.selectedDate = selectedDate
        majorProgressedAspects.chartCake = chartCake
        majorProgressedAspects.latitude = latitude
        majorProgressedAspects.longitude = longitude
        majorProgressedAspects.tabBarItem = UITabBarItem(title: "Majors", image: UIImage(systemName: "globe"), tag: 1)

        // For Transits (earth symbol is just an example; you may need to find a suitable SF Symbol)
        
        
        let sAAspects = SolarArcProgressionsViewController(transitPlanets: [""])
        sAAspects.selectedDate = selectedDate
        sAAspects.chartCake = chartCake
        sAAspects.latitude = latitude
        sAAspects.longitude = longitude
        sAAspects.tabBarItem = UITabBarItem(title: "Solar Arcs", image: UIImage(systemName: "globe"), tag: 2)
        
        
        
        let minors = MinorProgressionsViewController(transitPlanets: [""])
        minors.selectedDate = selectedDate
        minors.chartCake = chartCake
        minors.latitude = latitude
        minors.longitude = longitude
        minors.tabBarItem = UITabBarItem(title: "Minors", image: UIImage(systemName: "globe"), tag: 3)
        
        let transits = TransitPlanets(transitPlanets: [""])
        transits.selectedDate = selectedDate
        transits.latitude = latitude
        transits.longitude = longitude
        transits.chartCake = chartCake
        transits.tabBarItem = UITabBarItem(title: "Transits", image: UIImage(systemName: "globe"), tag: 4)

        self.viewControllers = [progressedAspects, majorProgressedAspects, sAAspects, minors,transits]

       // print("Debug After Set: \(String(describing: progressedAspects.selectedDate)), \(String(describing: progressedAspects.chartCake))")
        _ = progressedAspects.view
        _ = majorProgressedAspects.view
        _ = sAAspects.view
        _ = minors.view
        _ = transits.view

       }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     //   print("In viewWillAppear of TabBarController - ProgressionsAspectsTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

    }

