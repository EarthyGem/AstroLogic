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
    var selectedDate: Date?
    var getMinors: (() -> Date)?
    
    var getMajorProgresseDate: (() -> Date)?
    var strongestPlanet: String?

    // Use `getMinors` closure wherever you need to access the `getMinors` function

    
    private let ricksData: [RicksItems] = [
        RicksItems(chartType: "Charts and Graphs"),
      //  RicksItems(chartType: "My Planetary Degrees"),
        RicksItems(chartType: "Key Decanates"),
        RicksItems(chartType: "Natal Chart"),
        RicksItems(chartType: "Natal Houses"),
        RicksItems(chartType: "Natal Aspects"),
        RicksItems(chartType: "Natal Aspects By House"),
        RicksItems(chartType: "Transit Chart"),
        RicksItems(chartType: "Transit Aspects"),
        RicksItems(chartType: "Transit Aspects By House"),
        RicksItems(chartType: "Minor Progressed Chart"),
        RicksItems(chartType: "Minor Progressed Aspects"),
        RicksItems(chartType: "Minor Progressed Aspects By House"),
        RicksItems(chartType: "Progressed Chart"),
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
       
        chartVC.houseScores = self.chartCake!.calculateHouseStrengths()
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
        myNatalHousesVC.chart = self.chartCake

      
        let myNatalAspectsVC = NatalAspectsViewController()
    
        myNatalAspectsVC.chartCake = self.chartCake
//        myNatalHousesVC.title = category2.chartType

        let natalHouseAspects = AspectsByNatalHousesVC()
        natalHouseAspects.chart = self.chart
        natalHouseAspects.chartCake = self.chartCake
        
        
        let transitPlanetsVC = TransitPlanetsTimeChangeViewController()
         transitPlanetsVC.chartCake = self.chartCake
         transitPlanetsVC.selectedDate = self.selectedDate
        
        
        
        
        

        let transitAspectsVC = TransitAspectsTimeChangeViewController()
        natalPlanetsVC.title = category.chartType
        transitAspectsVC.chartCake = self.chartCake
        transitAspectsVC.selectedDate = self.selectedDate
       
        let minorProgressionsVC = MinorsPlanetsTimeChangeViewController()
        minorProgressionsVC.title = category.chartType
        minorProgressionsVC.chartCake = self.chartCake
        minorProgressionsVC.selectedDate = self.selectedDate
        
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
        
        let progressedAspectsByHouseVC = ProgressionPlanetsByHouseTimeChangeViewController()
        progressedAspectsByHouseVC.chartCake = self.chartCake
        progressedAspectsByHouseVC.selectedDate = self.selectedDate
        let mProgressedAspectsByHouseVC = MinorPlanetsByHouseTimeChangeViewController()
        mProgressedAspectsByHouseVC.chartCake = self.chartCake
        mProgressedAspectsByHouseVC.selectedDate = self.selectedDate
        let transitAspectsByHouseVC = TransitPlanetsByHouseTimeChangeViewController()
        transitAspectsByHouseVC.chartCake = self.chartCake
        transitAspectsByHouseVC.selectedDate = self.selectedDate
        
        
        

//        let SA_PlanetsVC = SolarArcViewController(MP_Planets: placeolder)
//        SA_PlanetsVC.getMajorProgresseDate = self.getMajorProgresseDate
//        SA_PlanetsVC.chart = self.chart
        let MP_AspectsVC = ProgressedAspectsTimeChangeViewController()
        MP_AspectsVC.chartCake = self.chartCake
        MP_AspectsVC.selectedDate = self.selectedDate
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

    
    


