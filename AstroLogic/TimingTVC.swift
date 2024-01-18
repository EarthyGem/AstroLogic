//
//  TimingTVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/1/24.
//

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


class TimingViewController: UIViewController {

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
        RicksItems(chartType: "Progressed Aspects By House")

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
    //    print("StrongestPlanet: \(String(describing: strongestPlanet))")
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


extension TimingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = ricksData[indexPath.row]

        
        let collectiveMood = DailyTabBarController(chartCake: chartCake!)
//        collectiveMood.chart = self.chart
        collectiveMood.chartCake = self.chartCake
        collectiveMood.title = "Collective Mood"
        
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
        natalPlanetsVC.sortedPlanets = self.sortedPlanets
//

        let progressedPlanetsVC = ProgressedTabBarController2(chartCake: chartCake!, otherChart: otherChart!)
        progressedPlanetsVC.title = category.chartType
        progressedPlanetsVC.chartCake = self.chartCake
        progressedPlanetsVC.sortedPlanets = self.sortedPlanets

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
//print("chartCake (myItems): \(chartCake)")
        transitPlanetsVC.latitude = self.latitude
     transitPlanetsVC.longitude = self.longitude


        let timingVC = AstrologyTabBarController()
        timingVC.chartCake = self.chartCake
        timingVC.selectedDate = self.selectedDate
print("chartCake (myItems): \(chartCake)")
        timingVC.latitude = self.latitude
        timingVC.longitude = self.longitude




        let transitAspectsVC = TransitAspectsTimeChangeViewController()
        natalPlanetsVC.title = category.chartType
        transitAspectsVC.chartCake = self.chartCake
        transitAspectsVC.selectedDate = self.selectedDate
        
        
        let solarArcPlanetsVC = SolarArcPlanetsTimeChangeViewController()
        solarArcPlanetsVC.chartCake = self.chartCake
        solarArcPlanetsVC.selectedDate = self.selectedDate

        solarArcPlanetsVC.latitude = self.latitude
        solarArcPlanetsVC.longitude = self.longitude


        let planetaryHoursVC = PlanetaryHoursViewController()

        planetaryHoursVC.latitude = self.latitude
        planetaryHoursVC.longitude = self.longitude




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



        let vocationalTVC = VocationalTableViewController()
        vocationalTVC.chartCake = self.chartCake
        vocationalTVC.strongestPlanet = self.strongestPlanet
        vocationalTVC.title = "Vocational Astrology"

        let cycleChartsVC = CycleChartsViewController(MP_Planets: [""])
       cycleChartsVC.chartCake = self.chartCake
      //  cycleChartsVC.otherChart = self.otherChart
        cycleChartsVC.title = "Cycle Charts"

        let aspectChartsVC = AspectChartTableViewController()
            // aspectChartsVC.chartCake = self.chartCake
      //  cycleChartsVC.otherChart = self.otherChart
        aspectChartsVC.title = "Cycle Charts"

     

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

        let categories = [transitAspectsVC,transitAspectsByHouseVC,solarArcPlanetsVC,solaArcAspectsVC, minorProgressionsVC,mp_natalAspectsVC,mProgressedAspectsByHouseVC,MP_PlanetsVC,progressedMoonPhaseVC,MP_AspectsVC,progressedAspectsByHouseVC]

        navigationController?.pushViewController(categories[indexPath.row] , animated: true)


    }
}



    extension TimingViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ricksData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = ricksData[indexPath.row].chartType
            return cell
        }
    }
