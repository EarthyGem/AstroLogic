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



class EpochViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    // Location manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var transitSigns: [String] = []
//    var transitBiWheelChartView: TransitBiWheelChartView!
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
            updateUIWithSelectedDate()
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


    // Define and configure other buttons similarly


    // Define and configure other buttons similarly


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
    
    func getTransitPositions(for date: Date) -> [String] {
        transitSigns = [
            chartCake?.transits.sun.formatted,
            chartCake?.transits.moon.formatted,
            chartCake?.transits.mercury.formatted,
            chartCake?.transits.venus.formatted,
            chartCake?.transits.mars.formatted,
            chartCake?.transits.jupiter.formatted,
            chartCake?.transits.saturn.formatted,
            chartCake?.transits.uranus.formatted,
            chartCake?.transits.neptune.formatted,
            chartCake?.transits.pluto.formatted,
            chartCake?.transits.southNode.formatted
        ].compactMap { $0 }

        return transitSigns
    }

    func updateTransitPositionsAndUI(for date: Date) {
        transitSigns = getTransitPositions(for: date)
        tableView.reloadData()
    }
    func getDegree(chartCake: ChartCake) -> [(planet: CelestialObject, degree: String)]  {
        let planetDegree: [(planet: CelestialObject, degree: String)] = [
            (.planet(.sun), "\(Int(chartCake.transits.sun.degree))°"),
            (.planet(.moon), "\(Int(chartCake.transits.moon.degree))°"),
            (.planet(.mercury), "\(Int(chartCake.transits.mercury.degree))°"),
            (.planet(.venus), "\(Int(chartCake.transits.venus.degree))°"),
            (.planet(.mars), "\(Int(chartCake.transits.mars.degree))°"),
            (.planet(.jupiter), "\(Int(chartCake.transits.jupiter.degree))°"),
            (.planet(.saturn), "\(Int(chartCake.transits.saturn.degree))°"),
            (.planet(.uranus), "\(Int(chartCake.transits.uranus.degree))°"),
            (.planet(.neptune), "\(Int(chartCake.transits.neptune.degree))°"),
            (.planet(.pluto), "\(Int(chartCake.transits.pluto.degree))°"),
            (.lunarNode(.meanSouthNode), "\(Int(chartCake.transits.southNode.degree))°")

        ]

return planetDegree
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

     //   transitBiWheelChartView = TransitBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!)
         //   view.addSubview(transitBiWheelChartView)
            // Other setup code for transitBiWheelChartView
        view.backgroundColor = .black
      //  let screenWidth = UIScreen.main.bounds.width
        // Assuming you have a UIImage of your chart
   let chartImage = UIImage(named: "ancient")
            let imageView = UIImageView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth))
            imageView.image = chartImage
            imageView.contentMode = .scaleAspectFit // or .scaleAspectFill depending on your needs
            imageView.clipsToBounds = true
            // Add the imageView to your view, make sure you're adding it to the right parent view
            self.view.addSubview(imageView)
        

        tableView.dataSource = self
        tableView.delegate = self
     //   view.addSubview(birthChartView)
        view.addSubview(tableView)
    

        self.tableView.tableHeaderView = imageView
           // view.addSubview(transitBiWheelChartView)

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()

            // Add labels and buttons to the view
//            view.addSubview(hourLabel)
//            view.addSubview(dayLabel)
//            view.addSubview(weekLabel)
//            view.addSubview(monthLabel)
//            view.addSubview(yearLabel)
//            view.addSubview(minusHourButton)
//            view.addSubview(plusHourButton)
//            view.addSubview(minusDayButton)
//            view.addSubview(plusDayButton)
//            view.addSubview(minusWeekButton)
//            view.addSubview(plusWeekButton)
//            view.addSubview(minusMonthButton)
//            view.addSubview(plusMonthButton)
//            view.addSubview(minusYearButton)
//            view.addSubview(plusYearButton)
        if let tabBar = self.tabBarController?.tabBar {
            tabBar.isTranslucent = false
            tabBar.barTintColor = .black // Sets the background color to black
        }

        
        

            // Set an initial selected date
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
     //   let formattedDate = dateFormatter.string(from: selectedDate!)
    //    todaysDate.text = formattedDate

        // Update the chart with the selected date
     
    }

    // ...

    // Modify the updateTransitDateAndRefreshUI method


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: (chartCake?.transits.rickysBodies[indexPath.row].body.keyName.lowercased())!, planetImageImageName: (chartCake?.transits.rickysBodies[indexPath.row].body.keyName.lowercased())!, signTextText: (getTransitPositions(for: selectedDate!)[indexPath.row]), planetTextText: (chartCake?.transits.rickysBodies[indexPath.row].body.transitName)!, headerTextText: "")
        
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

