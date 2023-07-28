//
//  PlanetDegreeVC.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 6/30/23.
//
import UIKit
import Foundation
import SwiftEphemeris

struct PlanetDegree {
    let planet: String
    let degree: Int
}

class PlanetDegreeViewController: UIViewController, UITableViewDataSource {

    var tableView: UITableView!
    var planetDegrees: [PlanetDegree] = [] // Array of planets and their degrees
    var chart: Chart?
    
    func generatePlanetDegreeList(from chart: Chart) -> [PlanetDegree] {
        var planetDegreeList: [PlanetDegree] = []
        
        for planet in chart.allBodies {
           
            let degree = Int(planet.degree)
            let planetDegree = PlanetDegree(planet: planet.body.formatted, degree: degree)
            planetDegreeList.append(planetDegree)
        }
        
        return planetDegreeList
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        // Register the cell
        tableView.register(PlanetDegreeCell.self, forCellReuseIdentifier: "PlanetDegreeCell")
        
        // Set this view controller as the table view's data source
        tableView.dataSource = self
        tableView.separatorStyle = .none

        // Add the table view to the view
        view.addSubview(tableView)
        
        // Generate the planetDegrees array
        let birthChart = chart
        planetDegrees = generatePlanetDegreeList(from: birthChart!)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30 // for degrees 0 to 29
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetDegreeCell", for: indexPath) as! PlanetDegreeCell
        let degree = indexPath.row
        let planetsAtThisDegree = planetDegrees.filter { $0.degree == degree }
        cell.configureWith(degree: degree, planets: planetsAtThisDegree)
        return cell
    }
}
