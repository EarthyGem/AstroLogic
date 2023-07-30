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
        RicksItems(chartType: "Today for \(myName)"),
        RicksItems(chartType: "\(myName)'s Planetary Degrees"),
        RicksItems(chartType: "\(myName)'s Key Decanates"),
        RicksItems(chartType: "\(myName)'s Natal Chart"),
        RicksItems(chartType: "\(myName)'s Natal Houses"),
        RicksItems(chartType: "\(myName)'s Natal Aspects"),
        RicksItems(chartType: "\(myName)'s Transit Progressions"),
        RicksItems(chartType: "\(myName)'s Transit Aspects"),
        RicksItems(chartType: "\(myName)'s Minor Progressions"),
        RicksItems(chartType: "\(myName)'s Minor Progression Aspects"),
        RicksItems(chartType: "\(myName)'s Major Progressions"),
              RicksItems(chartType: "\(myName)'s Major Progression Aspects"),
        RicksItems(chartType: "\(myName)'s Solar Arc Progressions"),
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
        print("StrongestPlanet: \(strongestPlanet)")
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
        let category2 = ricksData[indexPath.row]

//
        let todaysVC = TodayViewController()
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
//        myNatalHousesVC.title = category2.chartType

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

//
        let MP_PlanetsVC = MajorProgressionsViewController(MP_Planets: placeolder)
  
        MP_PlanetsVC.chartCake = self.chartCake

//        let SA_PlanetsVC = SolarArcViewController(MP_Planets: placeolder)
//        SA_PlanetsVC.getMajorProgresseDate = self.getMajorProgresseDate
//        SA_PlanetsVC.chart = self.chart
        let MP_AspectsVC = MPAspectsViewController()

//        let RelationshipVC = RelationshipsViewController()
//        RelationshipVC.natalChart = self.chart
//

        MP_PlanetsVC.title = category.chartType
        
        let categories = [todaysVC, planetaryDegreesVC, decanatesVC,natalPlanetsVC, myNatalHousesVC, myNatalAspectsVC,transitPlanetsVC,transitAspectsVC,minorProgressionsVC,mp_natalAspectsVC,MP_PlanetsVC,MP_AspectsVC]
        
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

    
    


