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
    // Use `getMinors` closure wherever you need to access the `getMinors` function
    var latitude: Double?
    var longitude: Double?

    private let ricksData: [RicksItems] = [
        RicksItems(chartType: "Charts and Graphs"),
        RicksItems(chartType: "Collective Mood"),
        RicksItems(chartType: "Daily Moon"),
        RicksItems(chartType: "Daily Sun"),
        RicksItems(chartType: "Current Moon Phase"),
        RicksItems(chartType: "Natal Moon Phase"),
        RicksItems(chartType: "Key Decanates"),
        RicksItems(chartType: "Natal Chart"),
        RicksItems(chartType: "Natal Houses"),
        RicksItems(chartType: "Natal Aspects"),
        RicksItems(chartType: "Natal Aspects By House"),
        RicksItems(chartType: "Transit Chart"),
        RicksItems(chartType: "Transit Aspects"),
        RicksItems(chartType: "Transit Aspects By House"),
        RicksItems(chartType: "Solar Arc Chart"),
        RicksItems(chartType: "Solar Arc Aspects"),
        RicksItems(chartType: "Minor Progressed Chart"),
        RicksItems(chartType: "Minor Progressed Aspects"),
        RicksItems(chartType: "Minor Progressed Aspects By House"),
        RicksItems(chartType: "Progressed Chart"),
        RicksItems(chartType: "Progressed Lunar Phase"),
        RicksItems(chartType: "Progressed Aspects"),
        RicksItems(chartType: "Progressed Aspects By House"),
        RicksItems(chartType: "Birthday Wish"),
        RicksItems(chartType: "What's in a Name?"),
        RicksItems(chartType: "Horary Chart"),
        RicksItems(chartType: "Cycle Charts"),
        RicksItems(chartType: "Weather Charts"),
        RicksItems(chartType: "Relationships")
     
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
        print("StrongestPlanet: \(String(describing: strongestPlanet))")
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

        
        let collectiveMood = SunMoonSeasonVC()
//        collectiveMood.chart = self.chart
        collectiveMood.chartCake = self.chartCake
        collectiveMood.title = "Collective Mood"
        
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
        chartVC.scores2 = getTotalPowerScoresForPlanets(chart: chart!)
        chartVC.scores = getTotalPowerScoresForPlanets2(chart: chart!)

        let natalPlanetsVC = PlanetsViewController(planets: [""])
        natalPlanetsVC.title = category.chartType
        natalPlanetsVC.chartCake = self.chartCake
        natalPlanetsVC.sortedPlanets = self.sortedPlanets
//


        let currentMoonPhaseVC = CurrentMoonPhaseViewController()
        currentMoonPhaseVC.title = "\(category.chartType)"
        currentMoonPhaseVC.chartCake = self.chartCake
        currentMoonPhaseVC.phaseName = self.phaseName

        
        let moonPhaseVC = MoonPhaseViewController()
        moonPhaseVC.title = "\(name!)'s \(category.chartType)"
        moonPhaseVC.chartCake = self.chartCake
        moonPhaseVC.phaseName = self.phaseName

       


        let progressedMoonPhaseVC = ProgressedMoonPhaseViewController()
        progressedMoonPhaseVC.title = "\(name!)'s \(category.chartType)"
        progressedMoonPhaseVC.chartCake = self.chartCake
        progressedMoonPhaseVC.phaseName = self.phaseName



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
        
        
        let solarArcPlanetsVC = SolarArcPlanetsTimeChangeViewController()
        solarArcPlanetsVC.chartCake = self.chartCake
        solarArcPlanetsVC.selectedDate = self.selectedDate

        solarArcPlanetsVC.latitude = self.latitude
        solarArcPlanetsVC.longitude = self.longitude





        let solaArcAspectsVC = SolarArcAspectsAspectsTimeChangeViewController()
        solaArcAspectsVC.title = category.chartType
        solaArcAspectsVC.chartCake = self.chartCake
        solaArcAspectsVC.selectedDate = self.selectedDate


        let minorProgressionsVC = MinorsPlanetsTimeChangeViewController()
        minorProgressionsVC.title = category.chartType
        minorProgressionsVC.chartCake = self.chartCake
        minorProgressionsVC.selectedDate = self.selectedDate
        minorProgressionsVC.latitude = self.latitude
        minorProgressionsVC.longitude = self.longitude



        let transitPlanetstimeChangeVC = TransitPlanetsByHouseTimeChangeViewController()
        transitPlanetstimeChangeVC.chartCake = self.chartCake
        transitPlanetstimeChangeVC.selectedDate = self.selectedDate



        let mp_natalAspectsVC =  MinorsAspectsTimeChangeViewController()
        minorProgressionsVC.title = "Minor Progressions"
        mp_natalAspectsVC.chartCake = self.chartCake
        mp_natalAspectsVC.selectedDate = self.selectedDate
//
        let MP_PlanetsVC = ProgressedPlanetsTimeChangeViewController()
        MP_PlanetsVC.chartCake = self.chartCake
        MP_PlanetsVC.selectedDate = self.selectedDate
        MP_PlanetsVC.name = self.name
        MP_PlanetsVC.latitude = self.latitude
        MP_PlanetsVC.longitude = self.longitude

        let progressedAspectsByHouseVC = ProgressionPlanetsByHouseTimeChangeViewController()
        progressedAspectsByHouseVC.chartCake = self.chartCake
        progressedAspectsByHouseVC.selectedDate = self.selectedDate
        let mProgressedAspectsByHouseVC = MinorPlanetsByHouseTimeChangeViewController()
        mProgressedAspectsByHouseVC.chartCake = self.chartCake
        mProgressedAspectsByHouseVC.selectedDate = self.selectedDate
        let transitAspectsByHouseVC = TransitPlanetsByHouseTimeChangeViewController()
        transitAspectsByHouseVC.chartCake = self.chartCake
        transitAspectsByHouseVC.selectedDate = self.selectedDate


     
        let horaryVC = HoraryAstrologyViewController()
        horaryVC.title = "Horary Chart"

        let MP_AspectsVC = ProgressedAspectsTimeChangeViewController()
        MP_AspectsVC.chartCake = self.chartCake
        MP_AspectsVC.selectedDate = self.selectedDate

        let birthdayWishVC = MainTabBarController()
        birthdayWishVC.chartCake = self.chartCake
        birthdayWishVC.otherChart = self.otherChart
        birthdayWishVC.title = "Other Person"

        
        let nameVC = NameViewController()
        nameVC.chartCake = self.chartCake
        nameVC.name = self.name
      //  cycleChartsVC.otherChart = self.otherChart
        nameVC.title = "Whats in a Name?"
        

        let cycleChartsVC = CycleChartsViewController(MP_Planets: [""])
       cycleChartsVC.chartCake = self.chartCake
      //  cycleChartsVC.otherChart = self.otherChart
        cycleChartsVC.title = "Cycle Charts"
        
        let weatherVC = WeatherForecastViewController()
        weatherVC.chartCake = self.chartCake
      //  cycleChartsVC.otherChart = self.otherChart
        weatherVC.title = "Weather Charts"

        let RelationshipVC = RelationshipsViewController()
        RelationshipVC.chartCake = self.chartCake
        RelationshipVC.birthDate = self.birthDate
        RelationshipVC.otherChart = self.otherChart
        RelationshipVC.name = self.name
    //    RelationshipVC.charts = charts.unsafelyUnwrapped
        RelationshipVC.title = "Other Person"



     //   MP_PlanetsVC.title = category.chartType

        let categories = [chartVC,collectiveMood,moonVC,sunVC,currentMoonPhaseVC,moonPhaseVC, decanatesVC,natalPlanetsVC, myNatalHousesVC, myNatalAspectsVC,natalAspectsByHouse,transitPlanetsVC,transitAspectsVC,transitAspectsByHouseVC,solarArcPlanetsVC,solaArcAspectsVC, minorProgressionsVC,mp_natalAspectsVC,mProgressedAspectsByHouseVC,MP_PlanetsVC,progressedMoonPhaseVC,MP_AspectsVC,progressedAspectsByHouseVC,birthdayWishVC,nameVC,horaryVC,cycleChartsVC,weatherVC,RelationshipVC]

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
