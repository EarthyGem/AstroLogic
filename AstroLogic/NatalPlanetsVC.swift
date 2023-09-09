//
//  ListViewController.swift
//  TableviewPassData
//
//  Created by Afraz Siddiqui on 8/29/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//
import SwiftEphemeris
import UIKit

class PlanetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chartCake: ChartCake?
    var chart: Chart?
    var birthChartView: BirthChartView!
    var coverView: UIView!
    var natalChartLabel: UILabel!
    var sortedPlanets: [CelestialObject] = []
       let birthChartViewCollapsedHeight: CGFloat = 50.0
       let birthChartViewFullHeight = UIScreen.main.bounds.width + 60
       var isBirthChartViewCollapsed = false
    var natalSigns = [String]()

    // ... Rest of your code ...
    
    func setupNatalSigns() -> [String] {
        natalSigns = [
           chartCake!.natal.sun.sign.keyName,
           chartCake!.natal.moon.sign.keyName,
           chartCake!.natal.mercury.sign.keyName,
           chartCake!.natal.venus.sign.keyName,
           chartCake!.natal.mars.sign.keyName,
           chartCake!.natal.jupiter.sign.keyName,
           chartCake!.natal.saturn.sign.keyName,
           chartCake!.natal.uranus.sign.keyName,
           chartCake!.natal.neptune.sign.keyName,
           chartCake!.natal.pluto.sign.keyName,
           chartCake!.natal.southNode.sign.keyName,
           chartCake!.natal.ascendant.sign.keyName,
           chartCake!.natal.midheaven.sign.keyName

        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return natalSigns
    }
    
    func getNatalPositions() -> [String] {
        natalSigns = [
           chartCake!.natal.sun.formatted,
           chartCake!.natal.moon.formatted,
               chartCake!.natal.mercury.formatted,
           chartCake!.natal.venus.formatted,
           chartCake!.natal.mars.formatted,
           chartCake!.natal.jupiter.formatted,
           chartCake!.natal.saturn.formatted,
           chartCake!.natal.uranus.formatted,
           chartCake!.natal.neptune.formatted,
           chartCake!.natal.pluto.formatted,
           chartCake!.natal.southNode.formatted,
           chartCake!.natal.ascendant.formatted,
           chartCake!.natal.midheaven.formatted,
           chartCake!.natal.southNode.formatted
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return natalSigns
    }
    
var planetGlyphs = ["sun","moon","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto","southnode","ascendant","midheaven"]
    var segueIdentifiers = ["1","2","3","4","5","6","7","8","9","10","11","12"]

 private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return table
    }()

    private let planets: [String]

    // Init

    init(planets: [String]) {
        self.planets = planets
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        tableView.backgroundColor = .black

        // BirthChartView setup
        birthChartView = BirthChartView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: birthChartViewFullHeight), chartCake: chartCake!)
        let tapGestureForBirthChart = UITapGestureRecognizer(target: self, action: #selector(toggleBirthChartView))

        birthChartView.addGestureRecognizer(tapGestureForBirthChart)
        tableView.tableHeaderView = birthChartView

        // TableView setup
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        view.addSubview(tableView)
     print("sorted planets \(sortedPlanets)")

        // Set up coverView
        coverView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: birthChartViewCollapsedHeight))
        coverView.backgroundColor = .black  // or any desired color
        coverView.isHidden = false  // Initially hidden because the chart is fully shown on viewDidLoad
        tableView.addSubview(coverView)


        // Set up natalChartLabel
        natalChartLabel = UILabel()
        natalChartLabel.text = "Hide Chart"
        natalChartLabel.textColor = .white  // or any desired color
        natalChartLabel.textAlignment = .center
        natalChartLabel.frame = coverView.bounds
        coverView.addSubview(natalChartLabel)

        // Add tap gesture to coverView
        let tapGestureForCoverView = UITapGestureRecognizer(target: self, action: #selector(toggleBirthChartView))
        coverView.addGestureRecognizer(tapGestureForCoverView)
    }



        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

        
            let tableViewHeight = tableView.contentSize.height + 220  // Use the content size of the table view cells

            tableView.frame = CGRect(x: 10, y: 50, width: view.bounds.width - 20, height: tableViewHeight + 30)
        }

    @objc func toggleBirthChartView() {
        UIView.animate(withDuration: 0.3, animations: {
            if self.isBirthChartViewCollapsed {
                // Expand birthChartView
                self.birthChartView.frame.size.height = self.birthChartViewFullHeight

                // Adjusting the y-origin to prevent overlap
                self.birthChartView.frame.origin.y = self.coverView.frame.origin.y + self.birthChartViewCollapsedHeight - self.birthChartViewFullHeight

                // Adjust tableView frame accordingly
                self.tableView.frame.origin.y = self.birthChartView.frame.origin.y + self.birthChartViewFullHeight + 20
                self.tableView.frame.size.height = self.view.bounds.height - self.birthChartViewFullHeight - 20

                // Set the label to "Hide Chart" when the chart is expanded
                self.natalChartLabel.text = "Hide Chart"
            } else {
                // Collapse birthChartView behind the coverView
                self.birthChartView.frame.size.height = self.birthChartViewCollapsedHeight
                self.birthChartView.frame.origin.y = self.coverView.frame.origin.y - self.birthChartViewCollapsedHeight

                // Adjust tableView frame accordingly
                self.tableView.frame.origin.y = self.birthChartViewCollapsedHeight + 10
                self.tableView.frame.size.height = self.view.bounds.height - self.birthChartViewCollapsedHeight - 20

                // Set the label to "View Chart" when the chart is collapsed
                self.natalChartLabel.text = "View Chart"
            }

            self.tableView.tableHeaderView = self.birthChartView
        })

        isBirthChartViewCollapsed.toggle()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sortedPlanets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: (sortedPlanets[indexPath.row].keyName.lowercased()), planetImageImageName: (sortedPlanets[indexPath.row].keyName.lowercased()), signTextText: (sortedPlanets[indexPath.row].keyName), planetTextText: (sortedPlanets[indexPath.row].urgeTypes), headerTextText: "headerTextText")
        
//        cell.configure(signGlyphImageName: planetGlyphs[indexPath.row], planetImageImageName: "\(planetImages2[indexPath.row])", signTextText: getNatalPositions()[indexPath.row], planetTextText: "\(h_Planets[indexPath.row])", headerTextText: "\(h_planets[indexPath.row])")
        
        
         return cell
         
         
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print(planets[indexPath.row])
        

     
}

}

