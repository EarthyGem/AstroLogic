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
    var otherChart: ChartCake?
    var chartCake: ChartCake?
    var chart: Chart!
    var strongestPlanet: String?
    var placeHolder = [String]()
    var selectedName: String!
    var synastry: SynastryChartCake?
    var name: String!
    var otherName: String!
    weak var delegate: RelationshipSelectionDelegate?
    var compositeCake: Chart!

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
            RelationshipItems(chartType: "\(String(describing: otherName!))'s Natal Chart"),
            RelationshipItems(chartType: "\(String(describing: name!))'s Synastry Chart with \(String(describing: otherName!))"), RelationshipItems(chartType: "Interaspects between \(String(describing: name!)) and \(String(describing: otherName!))"),
            RelationshipItems(chartType: "\(String(describing: name!)) and \(String(describing: otherName!))'s Transposed Houses"),
            RelationshipItems(chartType: "\(String(describing: name!)) and \(String(describing: otherName!))'s Relationship Chart"),
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
    func addRelationship(_ relationship: Relationships, chart: ChartCake, chartCake: ChartCake) {
        let newRelationship = RelationshipItems(chartType: relationship.name)
        relationshipData.append(newRelationship)
        tableView.reloadData()
    }

    func didSelectRelationship(_ relationship: Relationships) {
        // Handle the selected relationship (chart) here
        // You can pass the relationship to the desired view controller or perform any necessary action
        // For example, you can push a new view controller with the selected relationship
        let relationshipsVC = CompositeChartsViewController()
//        relationshipsVC.otherChart = otherChart
//        relationshipsVC.chartCake = chartCake
        relationshipsVC.chart = Chart(alpha: chartCake!.natal, bravo: otherChart!.natal)

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
                let OthersPlanetsVC = OthersPlanetsViewController(planets: [""])
                OthersPlanetsVC.chartCake = self.chartCake
                OthersPlanetsVC.otherChart = self.otherChart
                OthersPlanetsVC.name = self.name
                OthersPlanetsVC.selectedName = self.selectedName

             //   print("Suns!!! \(String(describing: todaysVC.otherChart?.sun.formatted)) and \(String(describing: todaysVC.chartCake?.sun.formatted))")
//

               let SynastryChartVC = SynastryViewController(MP_Planets: [""])
                SynastryChartVC.chartCake = self.chartCake
                SynastryChartVC.otherChart = self.otherChart
                SynastryChartVC.name = self.name
                SynastryChartVC.selectedName = self.selectedName


                let transposedHousesVC = TransposedHousesVC()
                transposedHousesVC.chartCake = self.chartCake
                transposedHousesVC.otherChart = self.otherChart
                transposedHousesVC.title = "\(String(describing: name!))'s Planets"
                transposedHousesVC.name = self.name
                let natalPlanetsVC = PlanetsViewController(planets: placeHolder)

                let interAspectsVC = SimpleInteraspectsViewController()
                interAspectsVC.chartCake = self.chartCake
                interAspectsVC.otherChart = self.otherChart
               interAspectsVC.synastry = self.synastry
                print("Synastry: \(synastry?.natal.sun.longitude)")
                interAspectsVC.title = "Interaspects"
                interAspectsVC.name = self.name
                interAspectsVC.otherName = self.otherName

                // Later on, when you have the second person's birth date, you call the method like this:

          

//                natalPlanetsVC.title = category.chartType
                natalPlanetsVC.chartCake = self.chartCake
            //    natalPlanetsVC.otherChart = self.otherChart
                
             
                
                let compositeVC = MyCompositeItemsViewController()
                var chart = Chart(alpha: chartCake!.natal, bravo: otherChart!.natal)
                compositeVC.chartCake = chartCake
                compositeVC.otherChart = otherChart
                compositeVC.houseScores = self.chartCake!.calculateHouseStrengths()
                compositeVC.chart = Chart(alpha: chartCake!.natal, bravo: otherChart!.natal)
              //  compositeVC.harmonyDiscordScores = getScoresAndDifferenceForPlanets(chart: Chart(alpha: chartCake!.natal, bravo: otherChart!.natal))
                compositeVC.scores2 = getTotalPowerScoresForPlanets(chart: chart)
                compositeVC.scores = getTotalPowerScoresForPlanets2(chart: chart)
                compositeVC.chart = Chart(alpha: chartCake!.natal, bravo: otherChart!.natal)


                let categories = [OthersPlanetsVC,SynastryChartVC,interAspectsVC,transposedHousesVC,compositeVC]
                navigationController?.pushViewController(categories[indexPath.row] , animated: true)


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


        
