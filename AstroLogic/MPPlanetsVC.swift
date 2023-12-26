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
    var majorsBiWheelChartView: MajorsBiWheelChartView!
    var chart: Chart?
    var latitude: Double?
    var longitude: Double?
    var chartCake: ChartCake?
    var selectedDate: Date?
    static var progressedDate: Date {
        let dobDate = Date()
        return dobDate
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

    func getProgressedSignsSigns(for date: Date) -> [String] {
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

    func getMajorPositions(for date: Date) -> [String] {

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

    func updateTransitPositionsAndUI(for date: Date) {
        transitSigns = getMajorPositions(for: date)
        tableView.reloadData()
    }
    func getDegree(chartCake: ChartCake) -> [(planet: CelestialObject, degree: String)]  {
        let planetDegree: [(planet: CelestialObject, degree: String)] = [
            (.planet(.sun), "\(Int(chartCake.major.sun.degree))°"),
            (.planet(.moon), "\(Int(chartCake.major.moon.degree))°"),
            (.planet(.mercury), "\(Int(chartCake.major.mercury.degree))°"),
            (.planet(.venus), "\(Int(chartCake.major.venus.degree))°"),
            (.planet(.mars), "\(Int(chartCake.major.mars.degree))°"),
            (.planet(.jupiter), "\(Int(chartCake.major.jupiter.degree))°"),
            (.planet(.saturn), "\(Int(chartCake.major.saturn.degree))°"),
            (.planet(.uranus), "\(Int(chartCake.major.uranus.degree))°"),
            (.planet(.neptune), "\(Int(chartCake.major.neptune.degree))°"),
            (.planet(.pluto), "\(Int(chartCake.major.pluto.degree))°"),
            (.lunarNode(.meanSouthNode), "\(Int(chartCake.major.southNode.degree))°")

        ]

return planetDegree
    }

    func updateTransitDateAndRefreshUI(to newTransitDate: Date) {
        if let updatedChartCake = chartCake?.withUpdatedTransitDate(newTransitDate) {
            self.chartCake = updatedChartCake

            // Refresh your transit signs and positions
            transitSigns = getMajorPositions(for: selectedDate!)

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
            for body in updatedChartCake.major.rickysBodies {
                updatedTransitPositions[body.body] = body.value
            }
            var updatedTransitDegrees: [(planet: CelestialObject, degree: String)] = []
            for body in updatedChartCake.major.rickysBodies {
                updatedTransitDegrees.append((planet: body.body, degree: "\(Int(body.degree))"))
            }


                   // Update the transit positions and degrees in your TransitBiWheelChartView
            majorsBiWheelChartView.updateTransitPlanetPositions(newTransitPositions: updatedTransitPositions)
            majorsBiWheelChartView.updateMajorDegrees(updatedTransitDegrees)

            majorsBiWheelChartView.setNeedsDisplay()

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
        majorsBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusHourButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .hour, value: -1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()
    }


    @objc func plusDayButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusDayButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()
    }

    @objc func plusWeekButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusWeekButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()
    }

    @objc func plusMonthButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusMonthButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()
    }

    @objc func plusYearButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .year, value: 1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()
    }

    @objc func minusYearButtonTapped() {
        selectedDate = Calendar.current.date(byAdding: .year, value: -1, to: selectedDate!)
        updateUIWithSelectedDate()
        updateChartCakeAndUI(for: selectedDate!)
        updateTransitPositionsAndUI(for: selectedDate!)
        majorsBiWheelChartView.setNeedsDisplay()

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
        let majorsBiWheelChartView = MajorsBiWheelChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!)

        // Add labels and buttons to the view
//        view.addSubview(hourLabel)
//        view.addSubview(dayLabel)
//        view.addSubview(weekLabel)
//        view.addSubview(monthLabel)
//        view.addSubview(yearLabel)
//        view.addSubview(minusHourButton)
//        view.addSubview(plusHourButton)
//        view.addSubview(minusDayButton)
//        view.addSubview(plusDayButton)
//        view.addSubview(minusWeekButton)
//        view.addSubview(plusWeekButton)
//        view.addSubview(minusMonthButton)
//        view.addSubview(plusMonthButton)
//        view.addSubview(minusYearButton)
//        view.addSubview(plusYearButton)

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
        view.addSubview(majorsBiWheelChartView)
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

    @objc func navigateToTimeChangeVC() {
        let timeChangeVC = ProgressedPlanetsTimeChangeViewController()
        self.navigationController?.pushViewController(timeChangeVC, animated: true)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (chartCake?.major.planets.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {

             return UITableViewCell()
         }

        cell.configure(signGlyphImageName: (chartCake?.major.planets[indexPath.row].body.keyName.lowercased())!, planetImageImageName: (chartCake?.major.planets[indexPath.row].body.keyName.lowercased())!, signTextText: (chartCake?.major.planets[indexPath.row].formatted)!, planetTextText: "Evolving \(chartCake!.major.planets[indexPath.row].body.archetype)", headerTextText: "")



         return cell


     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)







        let MovingPlanetVCs = [TodayViewController()]



        let vc = MovingPlanetVCs[indexPath.row]
        present(UINavigationController(rootViewController: vc), animated: true)



}

}
extension MajorProgressionsViewController: DatePickerDelegate {
    func datePickerDidChangeDate(_ date: Date) {
        self.selectedDate = date
        // Update the view controller as needed
    }
}
