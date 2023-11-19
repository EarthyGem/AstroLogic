//
//  PieChartsTBC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/18/23.
//

import Foundation
import SwiftEphemeris
import UIKit
class PieChartTabBarController: UITabBarController {
    var chartCake: ChartCake?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
        let elementsVC = ElementsViewController()
        elementsVC.chartCake = chartCake
        elementsVC.title = "Elements"
        let elementsNavVC = UINavigationController(rootViewController: elementsVC)
        elementsNavVC.tabBarItem = UITabBarItem(title: "Elements", image: UIImage(named: "elementsIcon"), tag: 0)

        // Repeat for the other view controllers

        
        let modesVC = ModesViewController()
        modesVC.chartCake = chartCake
        modesVC.title = "Modes" // Set title here
        let modesNavVC = UINavigationController(rootViewController: modesVC)
        modesVC.tabBarItem = UITabBarItem(title: "Modes", image: UIImage(named: "modesIcon"), tag: 1)
        
        let emanationsVC = EmanationsViewController()
        emanationsVC.chartCake = chartCake
        emanationsVC.title = "Emanations" // Set title here
        emanationsVC.tabBarItem = UITabBarItem(title: "Emanations", image: UIImage(named: "emanationsIcon"), tag: 2)
        
        let trinityVC = TrinityViewController()
        trinityVC.chartCake = chartCake
        trinityVC.title = "Trinities" // Set title here
        trinityVC.tabBarItem = UITabBarItem(title: "Trinity", image: UIImage(named: "trinityIcon"), tag: 3)
        
        let domainVC = DomainViewController()
        domainVC.chartCake = chartCake
        domainVC.title = "Domains" // Set title here
        domainVC.tabBarItem = UITabBarItem(title: "Domain", image: UIImage(named: "domainIcon"), tag: 4)
        
        viewControllers = [elementsVC, modesVC, emanationsVC, trinityVC, domainVC]
    }
}
