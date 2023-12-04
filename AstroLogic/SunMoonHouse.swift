//
//  SunMoonHouse.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/3/23.
//

import Foundation
import CoreLocation
import UIKit
import SwiftEphemeris
//
//struct DateAndHouse {
//    var date: Date4
//    var house: Int
//    var celestialBody: CelestialObject
//}


class HouseTransitionVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    var tableView: UITableView!
    var DateAndHouses: [ChartCake.DateAndHouse] = []
    var chartCake: ChartCake!
    let locationManager = CLLocationManager()

    // ... similar setup and methods as in SunMoonSeasonVC ...
    override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
            configureLocationManager()
            requestHouseTransitionData()
        }

        private func setupTableView() {
            tableView = UITableView(frame: self.view.bounds, style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.view.addSubview(tableView)
        }

        private func configureLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }

        private func requestHouseTransitionData() {
            if let location = locationManager.location {
                Task {
                    await fetchAndDisplayHouseData(for: location.coordinate)
                }
            } else {
                print("Location data is not available.")
            }
        }

    func fetchAndDisplayHouseData(for coordinate: CLLocationCoordinate2D) async {
        guard let userTimeZone = await ChartCake.getTimeZone(coordinate) else {
            print("Could not retrieve user's timezone.")
            return
        }
        
        let currentDate = Date()
        let currentSunCoordinate = chartCake.getCoordinate(for: chartCake.transits.sun.body, on: currentDate)
            let currentMoonCoordinate = chartCake.getCoordinate(for: chartCake.transits.moon.body, on: currentDate)
            
            let currentSunHouse = chartCake.houseCusps.house(of: currentSunCoordinate)
            let currentMoonHouse = chartCake.houseCusps.house(of: currentMoonCoordinate)
            
            // Create an array for the first cell with current house data
            let currentHouses = [
                ChartCake.DateAndHouse(date: currentDate, house: currentSunHouse.number, celestialBody: chartCake.transits.sun.body),
                ChartCake.DateAndHouse(date: currentDate, house: currentMoonHouse.number, celestialBody: chartCake.transits.moon.body)
            ]
        
        // Assume you have a start date for your search, e.g., the current date
        let startDate = Date()

        // Fetch the house transition moments for the Sun and Moon
        let sunHouseTransitions = chartCake.findHouseTransitionMoment(startSearchDate: startDate, celestialBody: chartCake.transits.sun.body, latitude: coordinate.latitude, longitude: coordinate.longitude, maxSearchDays: 30)
        let moonHouseTransitions = chartCake.findHouseTransitionMoment(startSearchDate: startDate, celestialBody: chartCake.transits.moon.body, latitude: coordinate.latitude, longitude: coordinate.longitude, maxSearchDays: 30)

        // Combine and sort the transitions
        let combinedTransitions = (sunHouseTransitions + moonHouseTransitions)
            .sorted(by: { $0.date < $1.date })

        // Adjust the transitions for the user's timezone
        let adjustedTransitions = combinedTransitions.map { transition in
            var adjustedTransition = transition
            adjustedTransition.date = adjustForTimezone(date: transition.date, timezone: userTimeZone)
            return adjustedTransition
        }

        // Update your data source and refresh the table view
        DateAndHouses = currentHouses + adjustedTransitions

           DispatchQueue.main.async {
               self.tableView.reloadData()
        }
    }

    // Helper function to adjust dates for a given timezone
    private func adjustForTimezone(date: Date, timezone: TimeZone) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let localDateString = dateFormatter.string(from: date)
        return dateFormatter.date(from: localDateString) ?? date
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return DateAndHouses.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let houseTransition = DateAndHouses[indexPath.row]
        
        // Configure the cell with house transition data
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "E, MMM d, yyyy 'at' h:mma"

        let dateString = dateFormatter.string(from: houseTransition.date)
        let timeZoneAbbreviation = dateFormatter.timeZone.abbreviation() ?? "TZ"
        
        if indexPath.row < 2 { 
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)// Assuming the first two entries are the current Sun and Moon positions
            let celestialBodyName = (houseTransition.celestialBody == chartCake.transits.sun.body) ? "🌞" : "🌖"
            cell.textLabel?.text = "Current \(celestialBodyName) House: \(houseTransition.house)"
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            let celestialBodyName = (houseTransition.celestialBody == chartCake.transits.sun.body) ? "🌞" : "🌖"
            cell.textLabel?.text = "\(celestialBodyName) enters H\(houseTransition.house) on \(dateString) \(timeZoneAbbreviation)"
        }
        

        // Set background color based on celestial body
        if houseTransition.celestialBody == chartCake.transits.sun.body {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1) // Light orange for Sun
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1) // Light green for Moon
        }

        return cell
    }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                manager.stopUpdatingLocation()
                Task {
                    await fetchAndDisplayHouseData(for: location.coordinate)
                }
            }
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to find user's location: \(error.localizedDescription)")
        }
    }
