////
////  TimingTBC.swift
////  AstroLogic
////
////  Created by Errick Williams on 12/25/23.
////
//import Foundation
//import UIKit
//import SwiftEphemeris
//
//protocol TimeChangeDelegate: AnyObject {
//    func timeDidChange(selectedDate: Date)
//}
//
//
//class AstrologyTabBarController: UITabBarController {
//    var chartCake: ChartCake!
//    var latitude: Double?
//    var longitude: Double?
//    var selectedDate: Date?
//    
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    
//        let timeChangeVC = SimpleAllProgressionsAspectedPlanetsViewController()
//        timeChangeVC.chartCake = chartCake
//        
//        timeChangeVC.selectedDate = selectedDate
//        
//        timeChangeVC.tabBarItem = UITabBarItem(title: "Time Change", image: UIImage(named: "time_change_icon"), tag: 0)
//        
//        let majorVC = MajorProgressionsViewController(transitPlanets: [])
//        majorVC.chartCake = chartCake?.withUpdatedTransitDate(selectedDate!)
//        majorVC.latitude = latitude
//        majorVC.longitude = longitude
//        majorVC.selectedDate = selectedDate
//        majorVC.tabBarItem = UITabBarItem(title: "Major", image: UIImage(named: "major_icon"), tag: 1)
//
//        let minorVC = MinorProgressionsViewController(transitPlanets: [])
//        minorVC.chartCake = chartCake?.withUpdatedTransitDate(selectedDate!)
//        minorVC.latitude = latitude
//        minorVC.longitude = longitude
//        minorVC.selectedDate = selectedDate
//        minorVC.tabBarItem = UITabBarItem(title: "Minor", image: UIImage(named: "minor_icon"), tag: 2)
//
//        let solarArcVC = SolarArcProgressionsViewController(transitPlanets: [])
//        solarArcVC.chartCake = chartCake?.withUpdatedTransitDate(selectedDate!)
//        solarArcVC.latitude = latitude
//        solarArcVC.longitude = longitude
//        solarArcVC.selectedDate = selectedDate
//        solarArcVC.tabBarItem = UITabBarItem(title: "Solar Arc", image: UIImage(named: "solar_arc_icon"), tag: 3)
////
////        let transitsVC = TransitPlanets(transitPlanets: [])
////        transitsVC.chartCake = chartCake?.withUpdatedTransitDate(selectedDate!)
////        transitsVC.latitude = latitude
////        transitsVC.longitude = longitude
////        transitsVC.selectedDate = selectedDate
////        transitsVC.tabBarItem = UITabBarItem(title: "Transits", image: UIImage(named: "transits_icon"), tag: 4)
////
////     
//       
//        viewControllers = [timeChangeVC, majorVC, minorVC, solarArcVC]
//    }
//}
