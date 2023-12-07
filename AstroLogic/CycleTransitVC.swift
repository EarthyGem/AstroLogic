//
//  ListViewController.swift
//  TableviewPassData
//
//  Created by Afraz Siddiqui on 8/29/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//
import SwiftEphemeris
import UIKit
import CoreLocation

class CycleTransitPlanets: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    // Location manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var eventDate: Date?
    var transitSigns: [String] = []
    var transitsChartView: TransitBiWheelChartView!
    var chartCake: ChartCake?
    var chart: Chart?
    var coverView: UIView!
    var natalChartLabel: UILabel!
    var selectedPlanetName: String?
    var selectedPlanet: Coordinate?

    let birthChartViewCollapsedHeight: CGFloat = 50.0
    let birthChartViewFullHeight = UIScreen.main.bounds.width + 50
    var isBirthChartViewCollapsed = false
    var selectedDate: Date? {
        didSet {
            // Here, you can update any relevant parts of the UI that depend on the selected date.
            // For example:
            // updateTransitDateAndRefreshUI(to: selectedDate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            manager.stopUpdatingLocation()
        }
    }

    // Error handling
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }

    // transitChart now uses the device's current location
//    func updateTransitDateAndRefreshUI(to newTransitDate: Date) {
//        if let updatedChartCake = chartCake?.withUpdatedTransitDate(newTransitDate) {
//            self.chartCake = updatedChartCake
//
//            // Refresh your transit signs and positions
//            _ = self.setupTransitSigns()
//            _ = self.getTransitPositions()
//
//            // Refresh your table view to reflect the updated data
//            self.tableView.reloadData()
//        }
//    }
//

    var planetGlyphs = ["sun","moon","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto"]

    func setupTransitSigns() -> [String] {

        transitSigns = [
            chartCake?.transits.sun.sign.keyName,
            chartCake?.transits.moon.sign.keyName,
            chartCake?.transits.mercury.sign.keyName,
            chartCake?.transits.venus.sign.keyName,
            chartCake?.transits.mars.sign.keyName,
            chartCake?.transits.jupiter.sign.keyName,
            chartCake?.transits.saturn.sign.keyName,
            chartCake?.transits.uranus.sign.keyName,
            chartCake?.transits.neptune.sign.keyName,
            chartCake?.transits.pluto.sign.keyName,
            chartCake?.transits.southNode.sign.keyName
        ].compactMap { $0 } // This will remove any nil values from the array



        // This will remove any nil values from the array

        return transitSigns
    }

    func getTransitPosition() -> String? {
         let planet =  selectedPlanetName

        switch planet {
        case "sun":
            return chartCake?.transits.sun.formatted
        case "moon":
            return chartCake?.transits.moon.formatted
        case "mercury":
            return chartCake?.transits.mercury.formatted
        case "venus":
            return chartCake?.transits.venus.formatted
        case "mars":
            return chartCake?.transits.mars.formatted
        case "jupiter":
            return chartCake?.transits.jupiter.formatted
        case "saturn":
            return chartCake?.transits.saturn.formatted
        case "uranus":
            return chartCake?.transits.uranus.formatted
        case "neptune":
            return chartCake?.transits.neptune.formatted
        case "pluto":
            return chartCake?.transits.pluto.formatted
        case .none:
            return chartCake?.transits.pluto.formatted
        case .some(_):
            return chartCake?.transits.pluto.formatted
        }
    }



    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return table
    }()

    private let transitPlanets: [String]

    // Init

    init(transitPlanets: [String]) {
        self.transitPlanets = transitPlanets
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {

        super.viewDidLoad()

        // Print the value of chartCake
     //   print("Value of chartCake: \(String(describing: chartCake))")  // This will
        view.backgroundColor = .black
        let screenWidth = UIScreen.main.bounds.width
        if let safeChartCake = chartCake {
            let transitChartView = TransitBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: safeChartCake)
            view.addSubview(transitChartView)

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()



            view.backgroundColor = .black
            tableView.backgroundColor = .black
            tableView.dataSource = self
            tableView.delegate = self
            view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)

            view.addSubview(tableView)

           let formatted = eventDate!.formatted(date: .complete, time: .omitted)

            let todaysDate = UILabel(frame: CGRect(x: 100, y: 535, width: 300, height: 20))
             todaysDate.text = ""
            todaysDate.font = .systemFont(ofSize: 13)
             todaysDate.textColor = .white
            todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)


            view.addSubview(todaysDate)
        }
    }



    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let yOffset: CGFloat = 550
        let tableViewHeight = view.bounds.height - yOffset - 20  // Adjust this as per your requirements
        tableView.frame = CGRect(x: 10, y: yOffset, width: view.bounds.width - 20, height: tableViewHeight)



      //  adding date labet
       // let formatted = selectedDate!.formatted(date: .complete, time: .omitted)

        let todaysDate = UILabel(frame: CGRect(x: 100, y: 535, width: 300, height: 20))
         todaysDate.text = ""
        todaysDate.font = .systemFont(ofSize: 13)
         todaysDate.textColor = .white
        todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)


        view.addSubview(todaysDate)
    }




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (chartCake?.transits.rickysBodies.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {

             return UITableViewCell()
         }

        cell.configure(signGlyphImageName: (chartCake?.natal.rickysBodies[indexPath.row].body.keyName.lowercased())!, planetImageImageName: (chartCake?.natal.rickysBodies[indexPath.row].body.keyName.lowercased())!, signTextText: (chartCake?.natal.rickysBodies[indexPath.row].formatted)!, planetTextText: (chartCake?.natal.rickysBodies[indexPath.row].body.keyName)!, headerTextText: "")

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

