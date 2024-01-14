
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

class SynastryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var minorProgressedSigns: [String] = []
   
    var synastryBiWheelChartView: SynastryBiWheelChartView!
    var otherChart: ChartCake?
    var chartCake: ChartCake?
    var selectedName: String!
    var name: String!
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

     
    var planetGlyphs = ["sun","moon","","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto"]
    
    func setupTransitSigns() -> [String] {
        transitSigns = [
            chartCake?.natal.sun.sign.keyName,
            chartCake?.natal.moon.sign.keyName,
            chartCake?.natal.ascendant.sign.keyName,
            chartCake?.natal.mercury.sign.keyName,
            chartCake?.natal.venus.sign.keyName,
            chartCake?.natal.mars.sign.keyName,
            chartCake?.natal.jupiter.sign.keyName,
            chartCake?.natal.saturn.sign.keyName,
            chartCake?.natal.uranus.sign.keyName,
            chartCake?.natal.neptune.sign.keyName,
            chartCake?.natal.pluto.sign.keyName,
            chartCake?.natal.southNode.sign.keyName
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return minorProgressedSigns
    }
    
    func getTransitPositions() -> [String] {
       minorProgressedSigns = [
        chartCake?.natal.sun.formatted,
        chartCake?.natal.moon.formatted,
        chartCake?.natal.ascendant.formatted,
        chartCake?.natal.mercury.formatted,
        chartCake?.natal.venus.formatted,
        chartCake?.natal.mars.formatted,
        chartCake?.natal.jupiter.formatted,
        chartCake?.natal.saturn.formatted,
        chartCake?.natal.uranus.formatted,
        chartCake?.natal.neptune.formatted,
        chartCake?.natal.pluto.formatted,
        chartCake?.natal.southNode.formatted
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return minorProgressedSigns
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
        let synastryChartView = SynastryBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!, otherChart: otherChart!)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Flip Charts", style: .plain, target: self, action: #selector(flipChartsButtonTapped))
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)
        view.addSubview(tableView)
        view.addSubview(synastryChartView)
        
    }
    
    @objc func flipChartsButtonTapped() {
        let flipSynastryVC = FlipSynastryViewController(MP_Planets: planetGlyphs)
        flipSynastryVC.otherChart = self.otherChart
        flipSynastryVC.chartCake = self.chartCake
        self.navigationController?.pushViewController(flipSynastryVC, animated: true)
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let yOffset: CGFloat = 550
        let tableViewHeight = view.bounds.height - yOffset - 20  // Adjust this as per your requirements
        tableView.frame = CGRect(x: 10, y: yOffset, width: view.bounds.width - 20, height: tableViewHeight)


    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: planetGlyphs[indexPath.row], planetImageImageName: planetGlyphs[indexPath.row], signTextText: getTransitPositions()[indexPath.row], planetTextText: "", headerTextText: "", capsuleText: "")
        

         return cell
         
         
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

}
    

}

