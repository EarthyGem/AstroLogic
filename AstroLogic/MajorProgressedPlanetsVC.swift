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

class MajorProgressionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var progressedSigns: [String] = []
    var getMajorProgresseDate: (() -> Date)?
    var majorsChartView: MajorsBiWheelChartView!
    var chart: Chart?
    var chartCake: ChartCake?
    var selectedDate: Date?
    static var progressedDate: Date {
        let dobDate = Date()
        return dobDate
    }

    // Location manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var transitSigns: [String] = []
    
    
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
  
    
    var planetGlyphs = ["sun","moon","ascendant","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto"]
    
    func getProgressedSignsSigns() -> [String] {
       progressedSigns = [
        chartCake?.major.sun.sign.keyName,
            chartCake?.major.moon.sign.keyName,
            chartCake?.major.ascendant.sign.keyName,
            chartCake?.major.mercury.sign.keyName,
            chartCake?.major.venus.sign.keyName,
            chartCake?.major.mars.sign.keyName,
            chartCake?.major.jupiter.sign.keyName,
            chartCake?.major.saturn.sign.keyName,
            chartCake?.major.uranus.sign.keyName,
            chartCake?.major.neptune.sign.keyName,
            chartCake?.major.pluto.sign.keyName,
            chartCake?.major.southNode.sign.keyName
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return transitSigns
    }
    
    func getTransitPositions() -> [String] {
       transitSigns = [
            chartCake?.major.sun.formatted,
            chartCake?.major.moon.formatted,
            chartCake?.major.ascendant.formatted,
            chartCake?.major.mercury.formatted,
            chartCake?.major.venus.formatted,
            chartCake?.major.mars.formatted,
            chartCake?.major.jupiter.formatted,
            chartCake?.major.saturn.formatted,
            chartCake?.major.uranus.formatted,
            chartCake?.major.neptune.formatted,
            chartCake?.major.pluto.formatted,
            chartCake?.major.southNode.formatted
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return transitSigns
    }
    
    
var mySunText = ""
    var myMoonText = ""
    var myAscText = ""
    var myMercuryText = ""
    var myVenusText = ""
    var myMarsText = ""
    var myJupiterText = ""
    var mySaturnText = ""
    var myUranusText = ""
    var myNeptuneText = ""
    var myPlutoText = ""
    var mySunText1 = ""
    var mySunText2 = ""
    var mySunText3 = ""
    var mySunText4 = ""

    
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
        let majorsChartView = MajorsBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!)
        
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)
        view.addSubview(tableView)
        view.addSubview(majorsChartView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let yOffset: CGFloat = 550
        let tableViewHeight = view.bounds.height - yOffset - 20  // Adjust this as per your requirements
        tableView.frame = CGRect(x: 10, y: yOffset, width: view.bounds.width - 20, height: tableViewHeight)
  
        let formatted = selectedDate!.formatted(date: .complete, time: .omitted)
        
        let todaysDate = UILabel(frame: CGRect(x: 100, y: 535, width: 300, height: 20))
         todaysDate.text = formatted
        todaysDate.font = .systemFont(ofSize: 13)
         todaysDate.textColor = .white
        todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)
       
        view.addSubview(todaysDate)
     
        
    }

    @objc func navigateToTimeChangeVC() {
        let timeChangeVC = ProgressedPlanetsTimeChangeViewController()
        self.navigationController?.pushViewController(timeChangeVC, animated: true)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: planetGlyphs[indexPath.row], planetImageImageName: planetGlyphs[indexPath.row], signTextText: getTransitPositions()[indexPath.row], planetTextText: "", headerTextText: "")
        
//        cell.configure(signGlyphImageName: planetGlyphs[indexPath.row], planetImageImageName: "\(planetImages2[indexPath.row])", signTextText: getNatalPositions()[indexPath.row], planetTextText: "\(h_Planets[indexPath.row])", headerTextText: "\(h_planets[indexPath.row])")
        
        
         return cell
         
         
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

}

}
