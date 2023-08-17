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
    
    var chart: Chart?
    var chartCake: ChartCake?
    
    var getMinors: (() -> Date)?
    
    var getMajorProgresseDate: (() -> Date)?
    var strongestPlanet: String?

    // Use `getMinors` closure wherever you need to access the `getMinors` function

    
    private let ricksData: [RicksItems] = [
        RicksItems(chartType: "Charts and Graphs"),
      //  RicksItems(chartType: "My Planetary Degrees"),
        RicksItems(chartType: "Key Decanates"),
        RicksItems(chartType: "Natal Planets"),
        RicksItems(chartType: "Natal Houses"),
        RicksItems(chartType: "Natal Aspects"),
        RicksItems(chartType: "Natal Aspects By House"),
        RicksItems(chartType: "Transit Planets"),
        RicksItems(chartType: "Transit Aspects"),
        RicksItems(chartType: "Transit Aspects By House"),
        RicksItems(chartType: "Minor Progressed Planets"),
        RicksItems(chartType: "Minor Progressed Aspects"),
        RicksItems(chartType: "Minor Progressed Aspects By House"),
        RicksItems(chartType: "Progressed Planeta"),
              RicksItems(chartType: "Progressed Aspects"),
        RicksItems(chartType: "Progressed Aspects By House"),
   //     RicksItems(chartType: "My Solar Arc Progressions"),
   //     RicksItems(chartType: "Relationships")
                   
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
       
//
        let chartVC = ChartViewController()
        chartVC.chart = chart
        chartVC.houseScores = chart!.calculateHouseStrengths()
        chartVC.chartCake = chartCake
        //   chartVC.harmonyDiscordScores = getScoresAndDifferenceForPlanets(chart: self.chart!)
        chartVC.scores2 = getTotalPowerScoresForPlanets(chart: chart!)
        chartVC.scores = getTotalPowerScoresForPlanets2(chart: chart!)
       
        let natalPlanetsVC = PlanetsViewController(planets: placeolder)
        natalPlanetsVC.title = category.chartType
        natalPlanetsVC.chart = self.chart
        natalPlanetsVC.chartCake = self.chartCake
//

        let decanatesVC = DeacanatesViewController(planets: placeolder)
        decanatesVC.title = category.chartType
        decanatesVC.chart = self.chart
        decanatesVC.strongestPlanet = self.strongestPlanet
        decanatesVC.title = category.chartType
        let planetaryDegreesVC = PlanetDegreeViewController()

        planetaryDegreesVC.title = category.chartType
        planetaryDegreesVC.chart = self.chart

        let myNatalHousesVC = MyNatalHousesVC()
        myNatalHousesVC.chart = self.chart

      
        let myNatalAspectsVC = AspectedPlanetsViewController()
        myNatalAspectsVC.chart = self.chart
        myNatalAspectsVC.chartCake = self.chartCake
//        myNatalHousesVC.title = category2.chartType

        let natalHouseAspects = AspectsByNatalHousesVC()
        natalHouseAspects.chart = self.chart
        natalHouseAspects.chartCake = self.chartCake
        
        
        let transitPlanetsVC = TransitPlanets(transitPlanets: [""])
      
        transitPlanetsVC.chartCake = self.chartCake

        let transitAspectsVC = TransitAspectedPlanetsViewController()
        natalPlanetsVC.title = category.chartType
        transitAspectsVC.chartCake = self.chartCake
        transitAspectsVC.chart = self.chart
        let minorProgressionsVC = MinorProgressionsViewController(MP_Planets: placeolder)
   
        minorProgressionsVC.title = category.chartType
        minorProgressionsVC.chartCake = self.chartCake


        let mp_natalAspectsVC =  mpAspectViewController()
        minorProgressionsVC.title = category.chartType
        mp_natalAspectsVC.chartCake = self.chartCake
        mp_natalAspectsVC.chart = self.chart
//
        let MP_PlanetsVC = MajorProgressionsViewController(MP_Planets: placeolder)
  
        MP_PlanetsVC.chartCake = self.chartCake
        
        let progressedAspectsByHouseVC = ProgressedAspectsByHousesVC()
        progressedAspectsByHouseVC.chartCake = self.chartCake
        progressedAspectsByHouseVC.chart = self.chart
        let mProgressedAspectsByHouseVC = MinorProgressedAspectsByHousesVC()
        mProgressedAspectsByHouseVC.chartCake = self.chartCake
        mProgressedAspectsByHouseVC.chart = self.chart
        let transitAspectsByHouseVC = TransitAspectsByHousesVC()
        transitAspectsByHouseVC.chartCake = self.chartCake
        transitAspectsByHouseVC.chart = self.chart
        
        
        

//        let SA_PlanetsVC = SolarArcViewController(MP_Planets: placeolder)
//        SA_PlanetsVC.getMajorProgresseDate = self.getMajorProgresseDate
//        SA_PlanetsVC.chart = self.chart
        let MP_AspectsVC = MPAspectsViewController()
        MP_AspectsVC.chartCake = self.chartCake
        MP_AspectsVC.chart = self.chart
//        let RelationshipVC = RelationshipsViewController()
//        RelationshipVC.natalChart = self.chart
//

        
        
        
        MP_PlanetsVC.title = category.chartType
        
        let categories = [chartVC, decanatesVC,natalPlanetsVC, myNatalHousesVC, myNatalAspectsVC,natalHouseAspects,transitPlanetsVC,transitAspectsVC,transitAspectsByHouseVC,minorProgressionsVC,mp_natalAspectsVC,mProgressedAspectsByHouseVC,MP_PlanetsVC,MP_AspectsVC,progressedAspectsByHouseVC]
        
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

    
    


