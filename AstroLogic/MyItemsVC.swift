//
//  ListViewController.swift
//  TableviewPassData
//
//  Created by Afraz Siddiqui on 8/29/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import UIKit
import SwiftEphemeris
import CoreLocation

struct RicksItems {
    let chartType: String
}


var myName = ""


class MyItemsViewController: UIViewController {

// var progPlanets = [String]()
    var charts: [ChartEntity]?
    var phaseName: String?
    var chart: Chart?
    var name: String!
    var otherName: String!
    var selectedDate: Date?
    var chartCake: ChartCake?
    var otherChart: ChartCake?
    var strongestPlanet: String?
    var sortedPlanets: [CelestialObject] = []
    var birthDate: Date?
    var scores: [CelestialObject: Double] = [:]
    var houseScores: [Int : Double] = [:]
    var signScores: [Zodiac : Double] = [:]
    // Use `getMinors` closure wherever you need to access the `getMinors` function
    var latitude: Double?
    var longitude: Double?
    var harmonyDiscordtuple: [CelestialObject: (harmony: Double, discord: Double, net: Double)] = [:]
    
    var signHarmonyDisharmony: [Zodiac: Double] = [:]
    var houseHarmonyDisharmony: [Int: Double] = [:]
    
    private let ricksData: [RicksItems] = [
        RicksItems(chartType: "Charts and Graphs"),
        RicksItems(chartType: "Current Sky"),
//        RicksItems(chartType: "Moon Through Houses"),
//        RicksItems(chartType: "Daily Moon"),
//        RicksItems(chartType: "Daily Sun"),
//        RicksItems(chartType: "Current Moon Phase"),
//        RicksItems(chartType: "Natal Moon Phase"),
//        RicksItems(chartType: "Key Decanates"),
        RicksItems(chartType: "Natal Chart"),
        RicksItems(chartType: "Relationships"),
        RicksItems(chartType: "Timing"),
        RicksItems(chartType: "Special Features"),
//        RicksItems(chartType: "Transit Aspects"),
//        RicksItems(chartType: "Transit Aspects By House"),
//        RicksItems(chartType: "Solar Arc Chart"),
//        RicksItems(chartType: "Solar Arc Aspects"),
//        RicksItems(chartType: "Minor Progressed Chart"),
//        RicksItems(chartType: "Minor Progressed Aspects"),
//        RicksItems(chartType: "Minor Progressed Aspects By House"),
//        RicksItems(chartType: "Progressed Chart"),
//        RicksItems(chartType: "Progressed Lunar Phase"),
//        RicksItems(chartType: "Progressed Aspects"),
//        RicksItems(chartType: "Progressed Aspects By House"),
//        RicksItems(chartType: "Relationships"),
//        RicksItems(chartType: "Vocational Astrology"),        RicksItems(chartType: "Birthday Wish"),
//        RicksItems(chartType: "What's in a Name?"),
//        RicksItems(chartType: "Horary Chart"),
//        RicksItems(chartType: "Cycle Charts"),
//        RicksItems(chartType: "Aspect Charts"),
//        RicksItems(chartType: "Weather Charts"),
//        RicksItems(chartType: "Timing"),
//        RicksItems(chartType: "Planetary Hours")

    ]

 var placeolder = [String]()

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()


    override func viewDidLoad() {


        super.viewDidLoad()
       // print("StrongestPlanet: \(String(describing: strongestPlanet))")
        view.backgroundColor = .white
              title = "My Items"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds


}
   


}


extension MyItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = ricksData[indexPath.row]

        
        let collectiveMood = DailyTabBarController(chartCake: chartCake!)
//        collectiveMood.chart = self.chart
        collectiveMood.chartCake = self.chartCake
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"// You can adjust the date format as needed
        let currentDate = dateFormatter.string(from: Date())

        collectiveMood.title = currentDate
        
        let sunMoonHouses = HouseTransitionVC()
//        collectiveMood.chart = self.chart
        sunMoonHouses.chartCake = self.chartCake
        sunMoonHouses.title = "Moon in the Houses"
        
        let moonVC = MoonViewController()
        moonVC.title = category.chartType
        moonVC.chartCake = self.chartCake
        moonVC.selectedDate = self.selectedDate
        
     let sunVC = SunViewController()
        sunVC.title = category.chartType
        sunVC.chartCake = self.chartCake
        sunVC.selectedDate = self.selectedDate
        
//
        let chartVC = ChartViewController()

        chartVC.houseScores = self.chartCake!.calculateHouseStrengths()
        chartVC.chartCake = chartCake
        //   chartVC.harmonyDiscordScores = getScoresAndDifferenceForPlanets(chart: self.chart!)
     //   chartVC.scores2 = scores
        chartVC.scores = scores
        chartVC.harmonyDiscordtuple = harmonyDiscordtuple
        chartVC.signHarmonyDisharmony = signHarmonyDisharmony
        chartVC.houseHarmonyDisharmony = houseHarmonyDisharmony
        chartVC.signScores = signScores
        chartVC.houseScores = houseScores
        
        let natalPlanetsVC = NatalTabBarController2(chartCake: chartCake!, sortedPlanets: self.sortedPlanets)
        natalPlanetsVC.title = category.chartType
        natalPlanetsVC.chartCake = self.chartCake
        natalPlanetsVC.strongestPlanet = self.strongestPlanet
        natalPlanetsVC.sortedPlanets = self.sortedPlanets


        let transitPlanetsVC = TransitPlanetsTimeChangeViewController()
         transitPlanetsVC.chartCake = self.chartCake
         transitPlanetsVC.selectedDate = self.selectedDate
//print("chartCake (myItems): \(chartCake)")
        transitPlanetsVC.latitude = self.latitude
     transitPlanetsVC.longitude = self.longitude


        let timingVC = AstrologyTabBarController()
        timingVC.chartCake = self.chartCake
        timingVC.selectedDate = self.selectedDate
//print("chartCake (myItems): \(chartCake)")
        timingVC.latitude = self.latitude
        timingVC.longitude = self.longitude




     
        let RelationshipVC = RelationshipsViewController()
        RelationshipVC.chartCake = self.chartCake
        RelationshipVC.birthDate = self.birthDate
        RelationshipVC.otherChart = self.otherChart
        RelationshipVC.name = self.name
    //    RelationshipVC.charts = charts.unsafelyUnwrapped
        RelationshipVC.title = "Other Person"

        let specialTVC = SpecialFeaturesViewController()
        specialTVC.chartCake = self.chartCake
        specialTVC.name = self.name
      //  cycleChartsVC.otherChart = self.otherChart
        specialTVC.title = "Special Features"

     //   MP_PlanetsVC.title = category.chartType

        let categories = [chartVC,collectiveMood,natalPlanetsVC,RelationshipVC,timingVC,specialTVC]

        navigationController?.pushViewController(categories[indexPath.row] , animated: true)


    }
}



    extension MyItemsViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ricksData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = ricksData[indexPath.row].chartType
            return cell
        }
    }
