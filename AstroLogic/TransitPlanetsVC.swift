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

class TransitPlanets: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    // Location manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var transitSigns: [String] = []
    var transitsChartView: TransitBiWheelChartView!
    var chartCake: ChartCake?
    var chart: Chart?
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
    func updateTransitDateAndRefreshUI(to newTransitDate: Date) {
        if let updatedChartCake = chartCake?.withUpdatedTransitDate(newTransitDate) {
            self.chartCake = updatedChartCake

            // Refresh your transit signs and positions
            _ = self.setupTransitSigns()
            _ = self.getTransitPositions()

            // Refresh your table view to reflect the updated data
            self.tableView.reloadData()
        }
    }

    
    var planetGlyphs = ["sun","moon","","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto"]
    
    func setupTransitSigns() -> [String] {

        transitSigns = [
            chartCake?.transits.sun.sign.keyName,
            chartCake?.transits.moon.sign.keyName,
            chartCake?.transits.ascendant.sign.keyName,
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
    
    func getTransitPositions() -> [String] {
       transitSigns = [
            chartCake?.transits.sun.formatted,
            chartCake?.transits.moon.formatted,
            chartCake?.transits.ascendant.formatted,
            chartCake?.transits.mercury.formatted,
            chartCake?.transits.venus.formatted,
            chartCake?.transits.mars.formatted,
            chartCake?.transits.jupiter.formatted,
            chartCake?.transits.saturn.formatted,
            chartCake?.transits.uranus.formatted,
            chartCake?.transits.neptune.formatted,
            chartCake?.transits.pluto.formatted,
            chartCake?.transits.southNode.formatted
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
        print("Value of chartCake: \(String(describing: chartCake))")  // This will print the value or "nil" if it's nil


        view.backgroundColor = .black
        let screenWidth = UIScreen.main.bounds.width
        if let safeChartCake = chartCake {
            let transitChartView = TransitBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: safeChartCake)
            view.addSubview(transitChartView)

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()

            let timeChangeVC = TimeChangeViewController()
            timeChangeVC.delegate = self
            self.present(timeChangeVC, animated: true)

            view.backgroundColor = .black
            tableView.backgroundColor = .black
            tableView.dataSource = self
            tableView.delegate = self
            view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)

            view.addSubview(tableView)

            let formatted = selectedDate!.formatted(date: .complete, time: .omitted)

            let todaysDate = UILabel(frame: CGRect(x: 100, y: 535, width: 300, height: 20))
             todaysDate.text = formatted
            todaysDate.font = .systemFont(ofSize: 13)
             todaysDate.textColor = .white
            todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)
            let calendarButton = UIButton(type: .system)  // .system to get the default UIButton styling
            calendarButton.setImage(UIImage(systemName: "calendar"), for: .normal)
            calendarButton.frame = CGRect(x: 65,
                                          y: 530,
                                          width: 30,  // Width of the button
                                          height: 30) // Height of the button sunScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)


            view.addSubview(calendarButton)
            view.addSubview(todaysDate)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 10, y: 550, width: 380, height: 700)

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
//        print(planets[indexPath.row])
        
      


        

        
        let MovingPlanetVCs = [TodayViewController()]
        
//        [MovingSunViewController(),MovingMoonController(),MovingAscendantController(),MovingMercuryController(),MovingVenusController(),MovingMarsController(),MovingJupiterController(),MovingSaturnController(),MovingUranusController(),MovingNeptuneController(),MovingPlutoController()]
       
        
        let vc = MovingPlanetVCs[indexPath.row]
        present(UINavigationController(rootViewController: vc), animated: true)
        
        
     
}

}

extension TransitPlanets: DatePickerDelegate {
    func datePickerDidChangeDate(_ date: Date) {
        updateTransitDateAndRefreshUI(to: date)
    }
}
