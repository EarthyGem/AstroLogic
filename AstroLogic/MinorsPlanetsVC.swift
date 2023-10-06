
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

class MinorProgressionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var minorProgressedSigns: [String] = []
    var getMinors: (() -> Date)?
    var minorsChartView: MinorsBiWheelChartView!
    var chart: Chart?
    var chartCake: ChartCake?

    // Location manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var transitSigns: [String] = []
    
    var selectedDate: Date?
    static var currentDate: Date {
        let dobDate = Date()
        return dobDate
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

    
    var planetGlyphs = ["sun","moon","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto","southnode","ascendant", "midheaven"]
    
    func setupTransitSigns() -> [String] {
        transitSigns = [
            chartCake?.minor.sun.sign.keyName,
            chartCake?.minor.moon.sign.keyName,
            chartCake?.minor.mercury.sign.keyName,
            chartCake?.minor.venus.sign.keyName,
            chartCake?.minor.mars.sign.keyName,
            chartCake?.minor.jupiter.sign.keyName,
            chartCake?.minor.saturn.sign.keyName,
            chartCake?.minor.uranus.sign.keyName,
            chartCake?.minor.neptune.sign.keyName,
            chartCake?.minor.pluto.sign.keyName,
            chartCake?.minor.southNode.sign.keyName,
            chartCake?.minor.ascendant.sign.keyName,
            chartCake?.minor.midheaven.sign.keyName
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return minorProgressedSigns
    }
    
    func getTransitPositions() -> [String] {
       minorProgressedSigns = [
        chartCake?.minor.sun.formatted,
        chartCake?.minor.moon.formatted,
        chartCake?.minor.ascendant.formatted,
        chartCake?.minor.mercury.formatted,
        chartCake?.minor.venus.formatted,
        chartCake?.minor.mars.formatted,
        chartCake?.minor.jupiter.formatted,
        chartCake?.minor.saturn.formatted,
        chartCake?.minor.uranus.formatted,
        chartCake?.minor.neptune.formatted,
        chartCake?.minor.pluto.formatted,
        chartCake?.minor.southNode.formatted,
        chartCake?.minor.ascendant.formatted,
        chartCake?.minor.midheaven.formatted
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return minorProgressedSigns
    }
    


    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return table
    }()

    private let MP_Planets: [String]

    // Init

    init(MP_Planets: [String]) {
        self.MP_Planets = MP_Planets
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let screenWidth = UIScreen.main.bounds.width
        let minorsChartView = MinorsBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!)
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)
        view.addSubview(tableView)
        view.addSubview(minorsChartView)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let yOffset: CGFloat = 550
        let tableViewHeight = view.bounds.height - yOffset - 20  // Adjust this as per your requirements
        tableView.frame = CGRect(x: 10, y: yOffset, width: view.bounds.width - 20, height: tableViewHeight)
    

        
      //  adding date labet
        let formatted = selectedDate!.formatted(date: .complete, time: .omitted)
        
        let todaysDate = UILabel(frame: CGRect(x: 100, y: 535, width: 300, height: 20))
         todaysDate.text = formatted
        todaysDate.font = .systemFont(ofSize: 13)
         todaysDate.textColor = .white
        todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)
       
     
        view.addSubview(todaysDate)
    }

    @objc func navigateToTimeChangeVC() {
        let timeChangeVC = MinorsPlanetsTimeChangeViewController()
        self.navigationController?.pushViewController(timeChangeVC, animated: true)
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (chartCake?.minor.planets.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: (chartCake?.minor.planets[indexPath.row].body.keyName.lowercased())!, planetImageImageName: (chartCake?.minor.planets[indexPath.row].body.keyName.lowercased())!, signTextText: (chartCake?.minor.planets[indexPath.row].formatted)!, planetTextText: chartCake!.minor.planets[indexPath.row].body.minorsName, headerTextText: "")
        
         return cell
         
         
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)


}
 

}

