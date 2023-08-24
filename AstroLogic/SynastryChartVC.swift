
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
    var selectedChart: ChartCake?
    var natalChart: ChartCake?
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
            natalChart?.natal.sun.sign.keyName,
            natalChart?.natal.moon.sign.keyName,
            natalChart?.natal.ascendant.sign.keyName,
            natalChart?.natal.mercury.sign.keyName,
            natalChart?.natal.venus.sign.keyName,
            natalChart?.natal.mars.sign.keyName,
            natalChart?.natal.jupiter.sign.keyName,
            natalChart?.natal.saturn.sign.keyName,
            natalChart?.natal.uranus.sign.keyName,
            natalChart?.natal.neptune.sign.keyName,
            natalChart?.natal.pluto.sign.keyName,
            natalChart?.natal.southNode.sign.keyName
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return minorProgressedSigns
    }
    
    func getTransitPositions() -> [String] {
       minorProgressedSigns = [
        natalChart?.natal.sun.formatted,
        natalChart?.natal.moon.formatted,
        natalChart?.natal.ascendant.formatted,
        natalChart?.natal.mercury.formatted,
        natalChart?.natal.venus.formatted,
        natalChart?.natal.mars.formatted,
        natalChart?.natal.jupiter.formatted,
        natalChart?.natal.saturn.formatted,
        natalChart?.natal.uranus.formatted,
        natalChart?.natal.neptune.formatted,
        natalChart?.natal.pluto.formatted,
        natalChart?.natal.southNode.formatted
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
        let synastryChartView = SynastryBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), natalChart: natalChart!, selectedChart: selectedChart!)
        
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
        flipSynastryVC.selectedChart = self.selectedChart
        flipSynastryVC.natalChart = self.natalChart
        self.navigationController?.pushViewController(flipSynastryVC, animated: true)
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

