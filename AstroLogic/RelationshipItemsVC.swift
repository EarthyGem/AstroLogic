//
//  RelaationshipItemsViewController.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 6/5/23.
//

import UIKit
import SwiftEphemeris


struct RelationshipItems {
    let chartType: String
}


class RelationshipItemsViewController: UIViewController {
    
    var relationshipChart: ChartCake?
    var selectedChart: ChartCake?
    var natalChart: ChartCake?
    var strongestPlanet: String?
    var placeHolder = [String]()
    var selectedName: String!
    var name: String!
    weak var delegate: RelationshipSelectionDelegate?

    
    private var relationshipData: [RelationshipItems] = []

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My Items"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        relationshipData = [
            //RelationshipItems(chartType: "Composite with \(String(describing: selectedName))"),
            RelationshipItems(chartType: "\(String(describing: name!))'s Natal Chart"),
            RelationshipItems(chartType: "Synastry Chart with \(String(describing: name!))")
       //     RelationshipItems(chartType: "\(selectedName ?? "")'s Natal Houses"),
       //     RelationshipItems(chartType: "\(selectedName ?? "")'s Natal Aspects"),
       //     RelationshipItems(chartType: "\(selectedName ?? "")'s Transit Progressions"),
      //      RelationshipItems(chartType: "\(selectedName ?? "")'s Transit Aspects"),
      //      RelationshipItems(chartType: "\(selectedName ?? "")'s Minor Progressions"),
      //      RelationshipItems(chartType: "\(selectedName ?? "")'s Minor Progression Aspects"),
     //       RelationshipItems(chartType: "\(selectedName ?? "")'s Major Progressions")
           
        ]
        
        tableView.reloadData()
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
        

    }


    }
extension RelationshipItemsViewController: AddRelationshipDelegate {
    func addRelationship(_ relationship: Relationships, chart: ChartCake, natalChart: ChartCake) {
        let newRelationship = RelationshipItems(chartType: relationship.name)
        relationshipData.append(newRelationship)
        tableView.reloadData()
    }
    
    func didSelectRelationship(_ relationship: Relationships) {
        // Handle the selected relationship (chart) here
        // You can pass the relationship to the desired view controller or perform any necessary action
        // For example, you can push a new view controller with the selected relationship
        let relationshipsVC = RelationshipsViewController()
        relationshipsVC.selectedChart = selectedChart
        navigationController?.pushViewController(relationshipsVC, animated: true)
    }
}




        extension RelationshipItemsViewController: UITableViewDelegate {
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                
//                let selectedRelationship = relationshipData[indexPath.row]
//                let chartType = selectedRelationship.chartType
//
//                let selectedRelationship = // Get the selected relationship (chart) from your data source
//                   delegate?.didSelectRelationship(selectedRelationship)
//
                let OthersPlanetsVC = OthersPlanetsViewController(planets: placeHolder)
                OthersPlanetsVC.natalChart = self.natalChart
                OthersPlanetsVC.selectedChart = self.selectedChart
                OthersPlanetsVC.name = self.name
                OthersPlanetsVC.selectedName = self.selectedName
                
             //   print("Suns!!! \(String(describing: todaysVC.selectedChart?.sun.formatted)) and \(String(describing: todaysVC.natalChart?.sun.formatted))")
//
                
               let SynastryChartVC = SynastryViewController(MP_Planets: [""])
                SynastryChartVC.natalChart = self.natalChart
                SynastryChartVC.selectedChart = self.selectedChart
                SynastryChartVC.name = self.name
                SynastryChartVC.selectedName = self.selectedName
                
                
                let natalPlanetsVC = RelationshipsPlanetsViewController(planets: placeHolder)
                
//                natalPlanetsVC.title = category.chartType
                natalPlanetsVC.natalChart = self.natalChart
                natalPlanetsVC.selectedChart = self.selectedChart
//                let compositeVC = CompositePlanetsViewController(planets: [""])
//                compositeVC.natalChart = self.natalChart
//                compositeVC.selectedChart = self.selectedChart
                
                let myNatalHousesVC = MyNatalHousesVC()
//                myNatalHousesVC.title = category2.chartType
                
           //     let myNatalAspectsVC = AspectedPlanetsViewController()
//                myNatalHousesVC.title = category2.chartType
//
          //      let transitPlanetsVC = RelationshipTransitPlanets(transitPlanets: transitPlanets)
//                natalPlanetsVC.title = category.chartType
          //      transitPlanetsVC.selectedChart = self.selectedChart
            
//
          //      let transitAspectsVC = TransitAspectedPlanetsViewController()
//                natalPlanetsVC.title = category.chartType
                    
         //       let minorProgressionsVC = RelationshipMinorProgressionsViewController(MP_Planets: minorPlanets)
         //       minorProgressionsVC.getMinors = self.getMinors
//                minorProgressionsVC.title = category.chartType
          //      minorProgressionsVC.selectedChart = self.selectedChart
              //  print("get minors date:  \(String(describing: minorProgressionsVC.getMinors))")
              
                
         //       let mp_natalAspectsVC =  mpAspectViewController()
//                minorProgressionsVC.title = category.chartType
                
        //
       //         let MP_PlanetsVC = RelationshipMajorProgressionsViewController(MP_Planets: majorPlanets)
           //     MP_PlanetsVC.getMajorProgresseDate = self.getMajorProgresseDate
//                MP_PlanetsVC.chart = self.chart
           //     MP_PlanetsVC.selectedChart = self.selectedChart
              //  print("get majors date:  \(String(describing: MP_PlanetsVC.getMajorProgresseDate))")
              
            
                
        //        let MP_AspectsVC = MPAspectsViewController()
               
           //     let RelationshipVC = RelationshipsViewController()
               
                           
            
                
                let categories = [OthersPlanetsVC,SynastryChartVC]
                navigationController?.pushViewController(categories[indexPath.row] , animated: true)
                
                
//                let relationshipItemsVC = RelationshipItemsViewController()
//                relationshipItemsVC.chart = self.chart
////                relationshipItemsVC.myName = myName // Replace `myName` with the actual name
//
//                navigationController?.pushViewController(relationshipItemsVC, animated: true)
            }
        }


        extension RelationshipItemsViewController: UITableViewDataSource {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return relationshipData.count
            }

            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = relationshipData[indexPath.row].chartType
                return cell
            }
        }

        
        

