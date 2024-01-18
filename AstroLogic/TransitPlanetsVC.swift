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
    var transitBiWheelChartView: TransitBiWheelChartView!
    var chartCake: ChartCake?
    var chart: Chart?
    var coverView: UIView!
    var natalChartLabel: UILabel!
    var latitude: Double?
    var longitude: Double?

    let birthChartViewCollapsedHeight: CGFloat = 50.0
    let birthChartViewFullHeight = UIScreen.main.bounds.width + 50
    var isBirthChartViewCollapsed = false
    // Define labels and buttons for time unit selection






    // Define a variable to store the selected date
    var selectedDate: Date? {
        didSet {
            // Update the UI and chart when the selected date changes
          
        }
    }

    lazy var todaysDate: UILabel = {
        //  adding date labet
        let formatted = selectedDate!.formatted(date: .long, time: .standard)

        let todaysDate = UILabel(frame: CGRect(x: 120, y: 580, width: 300, height: 20))
         todaysDate.text = formatted
        todaysDate.font = .systemFont(ofSize: 13)
         todaysDate.textColor = .white
        todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)

        return todaysDate

    }()




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


    
    var planetGlyphs = ["sun","moon","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto"]
    
  

    
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

//        chartCake = ChartCake(birthDate: chartCake!.natal.birthDate, latitude: latitude!, longitude: longitude!, transitDate: selectedDate)
        transitBiWheelChartView = TransitBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!)
    
         //   view.addSubview(transitBiWheelChartView)
            // Other setup code for transitBiWheelChartView

        self.tableView.tableHeaderView = transitBiWheelChartView
           // view.addSubview(transitBiWheelChartView)

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()

        if let tabBar = self.tabBarController?.tabBar {
            tabBar.isTranslucent = false
            tabBar.barTintColor = .black // Sets the background color to black
        }


            selectedDate = Date()

            view.backgroundColor = .black
            tableView.backgroundColor = .black
            tableView.dataSource = self
            tableView.delegate = self

      
            view.addSubview(tableView)

            
        }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let contentSizeHeight = tableView.contentSize.height
        tableView.frame = CGRect(x: 10, y: 0, width: view.bounds.width - 20, height: contentSizeHeight)
        
     

    }



    func updateUIWithSelectedDate() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        let formattedDate = dateFormatter.string(from: selectedDate!)
        todaysDate.text = formattedDate

        // Update the chart with the selected date
       
    }

    // ...

    // Modify the updateTransitDateAndRefreshUI method


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (chartCake?.transits.rickysBodies.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        guard let chartCake = chartCake else {
            assert(false, "We have much bigger problems")
            return UITableViewCell()
        }
        cell.configure(signGlyphImageName: (chartCake.transits.rickysBodies[indexPath.row].body.keyName.lowercased()), planetImageImageName: (chartCake.transits.rickysBodies[indexPath.row].body.keyName.lowercased()), signTextText: chartCake.transits.rickysBodies[indexPath.row].formatted, planetTextText: (chartCake.transits.rickysBodies[indexPath.row].body.transitName), headerTextText: "", capsuleText: chartCake.houseCusps.house(of: chartCake.transits.rickysBodies[safe: indexPath.row]!).houseString)
        
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

