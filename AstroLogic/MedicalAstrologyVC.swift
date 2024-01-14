//
//  MedicalAstrologyVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/7/24.
//

import Foundation
//
//  ListViewController.swift
//  TableviewPassData
//
//  Created by Afraz Siddiqui on 8/29/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//
import SwiftEphemeris
import UIKit

class MedicalAstrologyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chartCake: ChartCake!
    var chart: Chart?
    var birthChartView: BirthChartView!
    var coverView: UIView!
    var natalChartLabel: UILabel!
    var sortedPlanets: [CelestialObject] = []
       let birthChartViewCollapsedHeight: CGFloat = 50.0
       let birthChartViewFullHeight = UIScreen.main.bounds.width + 60
       var isBirthChartViewCollapsed = false
    var natalSigns = [String]()
    var sortedSignObjects: [(Zodiac, Double)] = []
    var totalStrength: Double {
        return sortedSignObjects.map { $0.1 }.reduce(0, +)
    }
    



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
        table.register(CustomNatalPlanetsTableViewCell.self, forCellReuseIdentifier: CustomNatalPlanetsTableViewCell.identifier)
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
    
    
    let medicalAstrologyImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        imageView.contentMode = .scaleAspectFit // Adjust content mode as needed
        imageView.image = UIImage(named: "MA")
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
      

        view.backgroundColor = .black
        tableView.backgroundColor = .black

        // BirthChartView setup
        birthChartView = BirthChartView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: birthChartViewFullHeight), chartCake: chartCake)
        let tapGestureForBirthChart = UITapGestureRecognizer(target: self, action: #selector(toggleBirthChartView))

        birthChartView.addGestureRecognizer(tapGestureForBirthChart)
        tableView.tableHeaderView = medicalAstrologyImageView

        // TableView setup
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomNatalPlanetsTableViewCell.self, forCellReuseIdentifier: CustomNatalPlanetsTableViewCell.identifier)
        view.addSubview(tableView)
     //print("sorted planets \(sortedPlanets)")

        // Set up coverView
        coverView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: birthChartViewCollapsedHeight))
        coverView.backgroundColor = .black  // or any desired color
        coverView.isHidden = false  // Initially hidden because the chart is fully shown on viewDidLoad
    //    tableView.addSubview(coverView)
        tableView.addSubview(medicalAstrologyImageView)
        sortedSignObjects = chartCake!.getSortedSignObjectsByStrength()         // Set up natalChartLabel
        natalChartLabel = UILabel()
        natalChartLabel.text = "Hide Chart"
        natalChartLabel.textColor = .white  // or any desired color
        natalChartLabel.textAlignment = .center
        natalChartLabel.frame = coverView.bounds
        coverView.addSubview(natalChartLabel)

        // Add tap gesture to coverView
        let tapGestureForCoverView = UITapGestureRecognizer(target: self, action: #selector(toggleBirthChartView))
        coverView.addGestureRecognizer(tapGestureForCoverView)

        if let tabBar = self.tabBarController?.tabBar {
            tabBar.isTranslucent = false
            tabBar.barTintColor = .black // Sets the background color to black
        }
        
      }



    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let birthChartViewHeight = isBirthChartViewCollapsed ? birthChartViewCollapsedHeight : birthChartViewFullHeight

        tableView.frame = CGRect(
            x: 10,
            y: 0, // Or wherever the Y origin should be, considering other views
            width: view.bounds.width - 20,
            height: view.bounds.height - 50 - 20 // Adapted for other UI elements, if any.
        )
    }

    func planetInfo(for planet: String) -> String? {
        switch planet {
        case "Sun":
            return chartCake!.natal.sun.formatted
        case "Moon":
            return chartCake!.natal.moon.formatted
        case "Mercury":
            return chartCake!.natal.mercury.formatted
        case "Venus":
            return chartCake!.natal.venus.formatted
        case "Mars":
            return chartCake!.natal.mars.formatted
        case "Jupiter":
            return chartCake!.natal.jupiter.formatted
        case "Saturn":
            return chartCake!.natal.saturn.formatted
        case "Uranus":
            return chartCake!.natal.uranus.formatted
        case "Neptune":
            return chartCake!.natal.neptune.formatted
        case "Pluto":
            return chartCake!.natal.pluto.formatted
        case "S.Node":
            return chartCake!.natal.southNode.formatted
        default:
            return nil
        }
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

        return sortedSignObjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomNatalPlanetsTableViewCell.identifier, for: indexPath) as? CustomNatalPlanetsTableViewCell else {
            return UITableViewCell()
        }

        let sign = sortedSignObjects[indexPath.row].0
        let strength = sortedSignObjects[indexPath.row].1
        let relativeStrengthPercentage = (strength / totalStrength) * 100.0
        let formattedStrength = String(format: "%.2f%%", relativeStrengthPercentage)

        // Assuming the CelestialObject has properties keyName, and urgeTypes for demonstration purposes.
        cell.configure(
            signGlyphImageName: sign.keyName,
            planetImageImageName: sign.keyName,
            signTextText: sign.keyName,
            planetTextText:  "\(formattedStrength) \(sign.nickName)",
            headerTextText: sign.bodyParts, capsuleText: ""
        )
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row after it's tapped, for better user experience.
        tableView.deselectRow(at: indexPath, animated: true)

        // Get the celestial object for the selected row.
        let signObject = sortedSignObjects[indexPath.row].0
//print("celestialObjectTest: \(celestialObject)")
        // Navigate to ArchetypeMatrixViewController with the selected celestial object.
     //   navigateToArchetypeMatrixViewController(with: signObject)
    }

    func navigateToArchetypeMatrixViewController(with celestialObject: CelestialObject) {
        let archetypeMatrixVC = NatalTabBarController(chartCake: chartCake, sortedPlanets: self.sortedPlanets, celstialObject: celestialObject)
   //     print("celestialObjectTest: \(celestialObject)")
        archetypeMatrixVC.chartCake = chartCake
     //   archetypeMatrixVC.celestialObject = celestialObject
        self.navigationController?.pushViewController(archetypeMatrixVC, animated: true)
    }


}

