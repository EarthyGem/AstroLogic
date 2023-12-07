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

    lazy var hourLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 25, y: 535, width: 60, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "Hour"
        return label
    }()

    lazy var minusHourButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 5, y: hourLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.setTitle("⏪", for: .normal)
        return button
    }()

    lazy var plusHourButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: minusHourButton.frame.maxX + 5, y: hourLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.cyan, for: .normal)
        button.setTitle("⏩", for: .normal)
        return button
    }()

    lazy var dayLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: plusHourButton.frame.maxX + 10, y: 535, width: 60, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "Day"
        return label
    }()

    lazy var minusDayButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: dayLabel.frame.minX, y: dayLabel.frame.maxY , width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.setTitle("⏪", for: .normal)
        return button
    }()

    lazy var plusDayButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: minusDayButton.frame.maxX + 5, y: dayLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.cyan, for: .normal)
        button.setTitle("⏩", for: .normal)
        return button
    }()

    lazy var weekLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: plusDayButton.frame.maxX + 10, y: 535, width: 60, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "Week"
        return label
    }()

    lazy var minusWeekButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: weekLabel.frame.minX, y: weekLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.setTitle("⏪", for: .normal)
        return button
    }()

    lazy var plusWeekButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: minusWeekButton.frame.maxX + 5, y: weekLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.cyan, for: .normal)
        button.setTitle("⏩", for: .normal)
        return button
    }()

    lazy var monthLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: plusWeekButton.frame.maxX + 10, y: 535, width: 60, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "Month"
        return label
    }()

    lazy var minusMonthButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: monthLabel.frame.minX, y: monthLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.setTitle("⏪", for: .normal)
        return button
    }()

    lazy var plusMonthButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: minusMonthButton.frame.maxX + 5, y: monthLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.cyan, for: .normal)
        button.setTitle("⏩", for: .normal)
        return button
    }()

    lazy var yearLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: plusMonthButton.frame.maxX + 10, y: 535, width: 60, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "Year"
        return label
    }()

    lazy var minusYearButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: yearLabel.frame.minX, y: yearLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.setTitle("⏪", for: .normal)
        return button
    }()

    lazy var plusYearButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: minusYearButton.frame.maxX + 5, y: yearLabel.frame.maxY, width: 30, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.cyan, for: .normal)
        button.setTitle("⏩", for: .normal)
        return button
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

    func updateTransitDateAndRefreshUI(to newTransitDate: Date) {
        if let updatedChartCake = chartCake?.withUpdatedTransitDate(newTransitDate) {
            self.chartCake = updatedChartCake

            // Refresh your transit signs and positions
            transitSigns = getTransitPositions(for: selectedDate!)

            // Refresh your table view to reflect the updated data
            self.tableView.reloadData()
        }
    }



    func updateChartCakeAndUI(for date: Date) -> ChartCake? {
        // Assuming chartCake is an optional
        guard var chartCake = chartCake else {
            return nil // Handle the case where chartCake is nil
        }

        // Update the transitDate property with a new date
        let newTransitDate = date // Replace this with your desired date
        chartCake.transitDate = newTransitDate

        // Create a new ChartCake instance with the updated transit date
        if let updatedChartCake = ChartCake(
            birthDate: chartCake.natal.date,
            latitude: latitude!,
            longitude: longitude!,
            transitDate: newTransitDate
        ) {
            // Update the chartCake property with the new instance
            self.chartCake = updatedChartCake

            // Update transit planet positions for all celestial bodies
            var updatedTransitPositions: [CelestialObject: CGFloat] = [:]
            for body in updatedChartCake.transits.rickysBodies {
                updatedTransitPositions[body.body] = body.value
            }
            var updatedTransitDegrees: [(planet: CelestialObject, degree: String)] = []
            for body in updatedChartCake.transits.rickysBodies {
                updatedTransitDegrees.append((planet: body.body, degree: "\(Int(body.degree))"))
            }


                   // Update the transit positions and degrees in your TransitBiWheelChartView
                   transitBiWheelChartView.updateTransitPlanetPositions(newTransitPositions: updatedTransitPositions)
       //     transitBiWheelChartView.updateTransitDegrees(updatedTransitDegrees)

                   transitBiWheelChartView.setNeedsDisplay()

                   return updatedChartCake
               } else {
                   // Handle the case where creating a new ChartCake instance failed
                   return nil
               }
           }
    @objc func plusHourButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .hour, value: 1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateTransitPositionsAndUI(for: selectedDate!)
        updateChartCakeAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusHourButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .hour, value: -1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    
    @objc func plusDayButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusDayButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    @objc func plusWeekButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusWeekButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    @objc func plusMonthButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusMonthButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    @objc func plusYearButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .year, value: 1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusYearButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .year, value: -1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        transitBiWheelChartView.setNeedsDisplay()
        
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

        transitBiWheelChartView = TransitBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!)
            view.addSubview(transitBiWheelChartView)
            // Other setup code for transitBiWheelChartView


            view.addSubview(transitBiWheelChartView)

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

            plusHourButton.addTarget(self, action: #selector(plusHourButtonTapped), for: .touchUpInside)
            minusHourButton.addTarget(self, action: #selector(minusHourButtonTapped), for: .touchUpInside)

            plusDayButton.addTarget(self, action: #selector(plusDayButtonTapped), for: .touchUpInside)
            minusDayButton.addTarget(self, action: #selector(minusDayButtonTapped), for: .touchUpInside)

            plusWeekButton.addTarget(self, action: #selector(plusWeekButtonTapped), for: .touchUpInside)
            minusWeekButton.addTarget(self, action: #selector(minusWeekButtonTapped), for: .touchUpInside)

            plusMonthButton.addTarget(self, action: #selector(plusMonthButtonTapped), for: .touchUpInside)
            minusMonthButton.addTarget(self, action: #selector(minusMonthButtonTapped), for: .touchUpInside)

            plusYearButton.addTarget(self, action: #selector(plusYearButtonTapped), for: .touchUpInside)
            minusYearButton.addTarget(self, action: #selector(minusYearButtonTapped), for: .touchUpInside)


            // Set an initial selected date
            selectedDate = Date()

            view.backgroundColor = .black
            tableView.backgroundColor = .black
            tableView.dataSource = self
            tableView.delegate = self
            view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)

            view.addSubview(tableView)

            
        }

    


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let yOffset: CGFloat = 600
        let tableViewHeight = view.bounds.height - yOffset - 20  // Adjust this as per your requirements
        tableView.frame = CGRect(x: 10, y: yOffset, width: view.bounds.width - 20, height: tableViewHeight)

        view.addSubview(todaysDate)
    }


    func updateUIWithSelectedDate() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        let formattedDate = dateFormatter.string(from: selectedDate!)
        todaysDate.text = formattedDate

        // Update the chart with the selected date
        updateTransitDateAndRefreshUI(to: selectedDate!)
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

