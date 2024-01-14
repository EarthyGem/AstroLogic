//
//  MyCompositeItemsVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/8/23.
//

import Foundation

import UIKit
import SwiftEphemeris
import CoreLocation


class MyCompositeItemsViewController: UIViewController {

// var progPlanets = [String]()
    var phaseName: String?
    var chart: Chart?
    var name: String!
    var selectedDate: Date?
    var chartCake: ChartCake?
    var otherChart: ChartCake?
    var strongestPlanet: String?
    var sortedPlanets: [CelestialObject] = []
    var birthDate: Date?
    // Use `getMinors` closure wherever you need to access the `getMinors` function
    var latitude: Double?
    var longitude: Double?
    
    var scores2: [(String, Double)] = []
    var signScore: [String : Double] = [:]
    var scores = [String : Double]()
    var houseScores: [Int : Double] = [:]
    var signScore2: [String : Double] = [:]
    var signScores: [String : Double] = [:]

    private let ricksData: [RicksItems] = [
        RicksItems(chartType: "Composite Charts and Graphs"),
        RicksItems(chartType: "Composite Chart")
//        RicksItems(chartType: "Composite Houses"),
//        RicksItems(chartType: "Composite Aspects"),
//        RicksItems(chartType: "Composite Aspects By House"),
//        RicksItems(chartType: "Transit Chart"),
//        RicksItems(chartType: "Transit Aspects"),
//        RicksItems(chartType: "Transit Aspects By House")
      
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
   //     print("StrongestPlanet: \(String(describing: strongestPlanet))")
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


extension MyCompositeItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = ricksData[indexPath.row]

        
        
        
        let moonVC = MoonViewController()
        moonVC.title = category.chartType
        moonVC.chartCake = self.chartCake
        moonVC.selectedDate = self.selectedDate
        
     let sunVC = SunViewController()
        sunVC.title = category.chartType
        sunVC.chartCake = self.chartCake
        sunVC.selectedDate = self.selectedDate
        
//
        let chartVC = CompositeChartsViewController()
        chartVC.chartCake = chartCake
        chartVC.otherChart = otherChart
        chartVC.houseScores = self.chart!.calculateHouseStrengths()
        //   chartVC.harmonyDiscordScores = getScoresAndDifferenceForPlanets(chart: self.chart!)
        chartVC.scores2 = getTotalPowerScoresForPlanets(chart: chart!)
        chartVC.scores = getTotalPowerScoresForPlanets2(chart: chart!)
        let natalPlanetsVC = ProgressedTabBarController2(chartCake: chartCake!, otherChart: otherChart!)
        natalPlanetsVC.title = category.chartType
        natalPlanetsVC.chartCake = chartCake
        natalPlanetsVC.otherChart = otherChart
        
        natalPlanetsVC.chart = Chart(alpha: chartCake!.natal, bravo: otherChart!.natal)
//

       


        let decanatesVC = DeacanatesViewController(planets: placeolder)
        decanatesVC.title = category.chartType
        decanatesVC.chart = self.chart
        decanatesVC.chartCake = self.chartCake
        decanatesVC.strongestPlanet = self.strongestPlanet
        decanatesVC.title = category.chartType
        let planetaryDegreesVC = PlanetDegreeViewController()

        planetaryDegreesVC.title = category.chartType
        planetaryDegreesVC.chart = self.chart

        let myNatalHousesVC = MyNatalHousesVC()
        myNatalHousesVC.chartCake = self.chartCake

        let myNatalAspectsVC = SimpleNatalAspectsViewController()

        myNatalAspectsVC.chartCake = self.chartCake
//        myNatalHousesVC.title = category2.chartType

        let natalAspectsByHouse = SimpleNatalAspectsByHousesVC()
        natalAspectsByHouse.chart = self.chart
        natalAspectsByHouse.chartCake = self.chartCake


        let transitPlanetsVC = TransitPlanetsTimeChangeViewController()
         transitPlanetsVC.chartCake = self.chartCake
         transitPlanetsVC.selectedDate = self.selectedDate

        transitPlanetsVC.latitude = self.latitude
     transitPlanetsVC.longitude = self.longitude





        let transitAspectsVC = TransitAspectsTimeChangeViewController()
        natalPlanetsVC.title = category.chartType
        transitAspectsVC.chartCake = self.chartCake
        transitAspectsVC.selectedDate = self.selectedDate
        
    


     //   MP_PlanetsVC.title = category.chartType
        
        
        let categories = [chartVC,natalPlanetsVC]

//        let categories = [chartVC,moonVC,sunVC,currentMoonPhaseVC,moonPhaseVC, decanatesVC,natalPlanetsVC, myNatalHousesVC, myNatalAspectsVC,natalAspectsByHouse,transitPlanetsVC,transitAspectsVC,transitAspectsByHouseVC,solarArcPlanetsVC,solaArcAspectsVC, minorProgressionsVC,mp_natalAspectsVC,mProgressedAspectsByHouseVC,MP_PlanetsVC,progressedMoonPhaseVC,MP_AspectsVC,progressedAspectsByHouseVC,birthdayWishVC,nameVC,horaryVC,cycleChartsVC,weatherVC,RelationshipVC]

        navigationController?.pushViewController(categories[indexPath.row] , animated: true)


    }
}



    extension MyCompositeItemsViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ricksData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = ricksData[indexPath.row].chartType
            return cell
        }
    }
