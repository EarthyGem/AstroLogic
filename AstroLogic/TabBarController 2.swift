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

    override func viewDidLoad() {
        super.viewDidLoad()


        let countdownVC = CountdownViewController()
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
