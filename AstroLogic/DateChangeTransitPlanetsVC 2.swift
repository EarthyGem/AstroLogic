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

class DateTransitPlanets: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    // Location manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var transitSigns: [String] = []
    var transitsChartView: TransitBiWheelChartView!
    var chartCake: ChartCake?
    var chart: Chart?
    var passedData = Date()
    var myDatePicker = TimeChangeViewController().chateTimeDP
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
        view.backgroundColor = .black
        let screenWidth = UIScreen.main.bounds.width
        let transitChartView = TransitBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!)
        locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)
        
        view.addSubview(transitChartView)
        view.addSubview(tableView)
        
       
           
           // Reload your table or update any other UI components accordingly:
           tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 10, y: 560, width: 380, height: 700)
        
        let formatted = Date().formatted(date: .complete, time: .omitted)
        
        let todaysDate = UILabel(frame: CGRect(x: 100, y: 535, width: 300, height: 20))
         todaysDate.text = formatted
        todaysDate.font = .systemFont(ofSize: 13)
         todaysDate.textColor = .white
        todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)
        view.addSubview(todaysDate)
        let calendarButton = UIButton(type: .system)  // .system to get the default UIButton styling
        calendarButton.setImage(UIImage(systemName: "calendar"), for: .normal)
        calendarButton.frame = CGRect(x: 65,
                                      y: 530,
                                      width: 30,  // Width of the button
                                      height: 30) // Height of the button sunScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
      
        calendarButton.addTarget(self, action: #selector(navigateToTimeChangeVC), for: .touchUpInside)
        view.addSubview(calendarButton)
        
    }

    @objc func navigateToTimeChangeVC() {
        let timeChangeVC = TimeChangeViewController()
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
//        print(planets[indexPath.row])
        
      


        

        
        let MovingPlanetVCs = [TodayViewController()]
        
//        [MovingSunViewController(),MovingMoonController(),MovingAscendantController(),MovingMercuryController(),MovingVenusController(),MovingMarsController(),MovingJupiterController(),MovingSaturnController(),MovingUranusController(),MovingNeptuneController(),MovingPlutoController()]
       
        
        let vc = MovingPlanetVCs[indexPath.row]
        present(UINavigationController(rootViewController: vc), animated: true)
        
        
     
}

}

