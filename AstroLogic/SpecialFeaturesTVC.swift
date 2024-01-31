//
//  SpecialFeaturesTVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/1/24.
//


import UIKit
import SwiftEphemeris
import CoreLocation
import Firebase

class SpecialFeaturesViewController: UIViewController {

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
           
//        RicksItems(chartType: "Birthday Wish"),
        RicksItems(chartType: "What's in a Name?"),
        RicksItems(chartType: "Vocational Astrology"),
        RicksItems(chartType: "Medical Astrology"),
        RicksItems(chartType: "Horary Chart"),
        RicksItems(chartType: "Cycle Charts"),
        RicksItems(chartType: "Aspect Charts"),
        RicksItems(chartType: "Weather Charts"),
        RicksItems(chartType: "What's Up?"),
        RicksItems(chartType: "Research")

    //    RicksItems(chartType: "Planetary Hours")

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
        Analytics.logEvent("specialEvents_Loaded", parameters: nil
        )

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds


}
   


}


extension SpecialFeaturesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = ricksData[indexPath.row]

        


   

        let horaryVC = HoraryAstrologyViewController()
        horaryVC.title = "Horary Chart"

   
        
        let nameVC = NameViewController()
        nameVC.chartCake = self.chartCake
        nameVC.name = self.name
      //  cycleChartsVC.otherChart = self.otherChart
        nameVC.title = "Whats in a Name?"



        let vocationalTVC = VocationalTableViewController()
        vocationalTVC.chartCake = self.chartCake
        vocationalTVC.strongestPlanet = self.strongestPlanet
        vocationalTVC.title = "Vocational Astrology"
        
        
        let medicalAstrologyVC = MedicalAstrologyViewController(planets: [""])
        medicalAstrologyVC.chartCake = self.chartCake
      
        medicalAstrologyVC.title = "Medical Astrology"

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

        let questionVC = AstrologyViewController()
     let researchVC = EventInputViewController()
        researchVC.chartCake = chartCake
        researchVC.latitude = latitude
        researchVC.longitude = longitude
        researchVC.name = name
        researchVC.title = "\(name!)'s Events"
        print("special featuresVC: \(name)")
     //   MP_PlanetsVC.title = category.chartType

        let categories = [ nameVC,vocationalTVC,medicalAstrologyVC,horaryVC,cycleChartsVC,aspectChartsVC ,weatherVC,questionVC,researchVC]

        navigationController?.pushViewController(categories[indexPath.row] , animated: true)


    }
}



    extension SpecialFeaturesViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ricksData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = ricksData[indexPath.row].chartType
            return cell
        }
    }
