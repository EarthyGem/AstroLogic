//
//  TabBarController.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import SwiftEphemeris
import UIKit


class MainTabBarController: UITabBarController {

    var chartCake: ChartCake!
    var otherChart: ChartCake!
    var selectedDate: Date?
    var latitude: Double?
    var longitude: Double?
    
    init(chartCake: ChartCake, selectedDate: Date, longitude: Double, latitude: Double) {
        self.chartCake = ChartCake(birthDate: chartCake.natal.birthDate, latitude: latitude, longitude: longitude, transitDate: selectedDate)
        self.selectedDate = selectedDate
        self.latitude = latitude
        self.longitude = longitude
        super.init(nibName: nil, bundle: nil)
    }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
  

    override func viewDidLoad() {
        super.viewDidLoad()


        let countdownVC = CountdownViewController()
        countdownVC.chartCake = chartCake
        countdownVC.tabBarItem = UITabBarItem(title: "Birthday", image: UIImage(named: "countDownIcon"), tag: 0)


        let rechargeVC = RechargeViewController()
        rechargeVC.tabBarItem = UITabBarItem(title: "Monthly Recharge", image: UIImage(named: "rechargeIcon"), tag: 1)

        let actionStepVC = ActionStepViewController()
        actionStepVC.tabBarItem = UITabBarItem(title: "Monthly Action Step", image: UIImage(named: "actionIcon"), tag: 2)

        let yearlyPlanVC = MonthActionPlanViewController()
        yearlyPlanVC.tabBarItem = UITabBarItem(title: "Month of Action", image: UIImage(named: "yearlyIcon"), tag: 3)



        self.viewControllers = [countdownVC, rechargeVC, actionStepVC, yearlyPlanVC]
    }
}
