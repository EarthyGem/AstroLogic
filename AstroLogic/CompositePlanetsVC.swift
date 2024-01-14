//
//  ListViewController.swift
//  TableviewPassData
//
//  Created by Afraz Siddiqui on 8/29/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//
import SwiftEphemeris
import UIKit

class CompositePlanetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chartCake: ChartCake!
    var otherChart: ChartCake!
    var chart: Chart?
    var birthChartView: CompositeBirthChartView!
    var coverView: UIView!
    var natalChartLabel: UILabel!

       let birthChartViewCollapsedHeight: CGFloat = 50.0
       let birthChartViewFullHeight = UIScreen.main.bounds.width + 60
       var isBirthChartViewCollapsed = false
    var natalSigns = [String]()

    // ... Rest of your code ...
    
       func setupNatalSigns() -> [String] {
           
           let compSun = Coordinate(alpha: chartCake.natal.sun, bravo: otherChart.natal.sun)
           let compMoon = Coordinate(alpha: chartCake.natal.moon, bravo: otherChart.natal.moon)
           let compMercury = Coordinate(alpha: chartCake.natal.mercury, bravo: otherChart.natal.mercury)
           let compVenus = Coordinate(alpha: chartCake.natal.venus, bravo: otherChart.natal.venus)
           let compMars = Coordinate(alpha: chartCake.natal.mars, bravo: otherChart.natal.mars)
           let compJupiter = Coordinate(alpha: chartCake.natal.jupiter, bravo: otherChart.natal.jupiter)
           let compSaturn = Coordinate(alpha: chartCake.natal.saturn, bravo: otherChart.natal.saturn)
           let compUranus = Coordinate(alpha: chartCake.natal.uranus, bravo: otherChart.natal.uranus)
           let compNeptune = Coordinate(alpha: chartCake.natal.neptune, bravo: otherChart.natal.neptune)
           let compPluto = Coordinate(alpha: chartCake.natal.pluto, bravo: otherChart.natal.pluto)
           let compSouthNode = Coordinate(alpha: chartCake.natal.southNode, bravo: otherChart.natal.southNode)
           let compAsc = Cusp(alpha: chartCake.natal.ascendant , bravo: otherChart.natal.ascendant)
           _ = Cusp(alpha: chartCake.natal.ascendant , bravo: otherChart.natal.ascendant)
           
           natalSigns = [
              compSun.sign.keyName,
              compMoon.sign.keyName,
              compMercury.sign.keyName,
              compVenus.sign.keyName,
              compMars.sign.keyName,
              compJupiter.sign.keyName,
              compSaturn.sign.keyName,
              compUranus.sign.keyName,
              compNeptune.sign.keyName,
              compPluto.sign.keyName,
              compSouthNode.sign.keyName,
              compAsc.sign.keyName,
              compMoon.sign.keyName

           ].compactMap { $0 } // This will remove any nil values from the array
       

           
           // This will remove any nil values from the array
           
           return natalSigns
       }
       
       func getNatalPositions() -> [String] {
           let compSun = chart!.sun
           let compMoon = chart!.moon
           let compMercury = chart!.mercury
           let compVenus = chart!.venus
           let compMars = chart!.mars
           let compJupiter = chart!.jupiter
           let compSaturn = chart!.saturn
           let compUranus = chart!.uranus
           let compNeptune = chart!.neptune
           let compPluto = chart!.pluto
           let compSouthNode = chart!.southNode
           let compAsc = Cusp(alpha: chartCake.natal.ascendant , bravo: otherChart.natal.ascendant)
           let compMC = Cusp(alpha: chartCake.natal.ascendant , bravo: otherChart.natal.ascendant)
           
           natalSigns = [
            compSun.formatted,
              compMoon.formatted,
              compMercury.formatted,
              compVenus.formatted,
              compMars.formatted,
              compJupiter.formatted,
              compSaturn.formatted,
              compUranus.formatted,
              compNeptune.formatted,
              compPluto.formatted,
              compSouthNode.formatted,
               compAsc.sign.formatted,
               compMC.sign.formatted

           ].compactMap { $0 } // This will remove any nil values from the array
       

           
           // This will remove any nil values from the array
           
           return natalSigns
       }
    
    
    func getCompositeName() -> [String] {
        let compSun = Planet.sun
        let compMoon = Planet.moon
        let compMercury = Planet.mercury
        let compVenus = Planet.venus
        let compMars = Planet.mars
        let compJupiter = Planet.jupiter
        let compSaturn = Planet.saturn
        let compUranus = Planet.uranus
        let compNeptune = Planet.neptune
        let compPluto = Planet.pluto
        let compSouthNode = Planet.southNode
        let compAsc = Cusp(alpha: chartCake.natal.ascendant , bravo: otherChart.natal.ascendant)
        let compMC = Cusp(alpha: chartCake.natal.ascendant , bravo: otherChart.natal.ascendant)
        
        natalSigns = [
            compSun.compositePlanets,
           compMoon.compositePlanets,
           compMercury.compositePlanets,
           compVenus.compositePlanets,
           compMars.compositePlanets,
           compJupiter.compositePlanets,
           compSaturn.compositePlanets,
           compUranus.compositePlanets,
           compNeptune.compositePlanets,
           compPluto.compositePlanets,
           compSouthNode.compositePlanets,
         //   compAsc.sign.compositePlanets,
           // compMC.sign.compositePlanets

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
        birthChartView = CompositeBirthChartView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: birthChartViewFullHeight), chart: chart!)
        let tapGestureForBirthChart = UITapGestureRecognizer(target: self, action: #selector(toggleBirthChartView))

        birthChartView.addGestureRecognizer(tapGestureForBirthChart)
        tableView.tableHeaderView = birthChartView

        // TableView setup
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        view.addSubview(tableView)


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

        return 11
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: planetGlyphs[indexPath.row], planetImageImageName: planetGlyphs[indexPath.row], signTextText: getNatalPositions()[indexPath.row], planetTextText: "Our \(getCompositeName()[indexPath.row])", headerTextText: "", capsuleText: "")
        
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
