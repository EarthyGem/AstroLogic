//
//  SunMoonSeasonVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/3/23.
//

import Foundation
import CoreLocation
import UIKit
import SwiftEphemeris

// Assuming you have a struct or class to hold your moon sign change data
struct DateAndSign {
    var date: Date
    var sign: Zodiac
    var celestialBody: CelestialObject
}



// Function to adjust DateAndSign times to the local timezone
func adjustToUserTimeZone(DateAndSigns: [DateAndSign], userCoordinate: CLLocationCoordinate2D) async -> [DateAndSign] {
    guard let userTimeZone = await ChartCake.getTimeZone(userCoordinate) else {
        print("Unable to retrieve user's timezone")
        return DateAndSigns // Return the original array if timezone can't be determined
    }

    return DateAndSigns.map { change in
        var adjustedChange = change
        adjustedChange.date = change.date.convertToTimeZone(from: TimeZone(identifier: "UTC")!, to: userTimeZone)
        return adjustedChange
    }
}

// Extension to convert dates from one timezone to another
extension Date {
    func convertToTimeZone(from sourceTimeZone: TimeZone, to destinationTimeZone: TimeZone) -> Date {
        let sourceGMTOffset = sourceTimeZone.secondsFromGMT(for: self)
        let destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: self)
        let interval = TimeInterval(destinationGMTOffset - sourceGMTOffset)
        return addingTimeInterval(interval)
    }
}

class SunMoonSeasonVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {


    var tableView: UITableView!
    var DateAndSigns: [DateAndSign] = []
    var chartCake: ChartCake!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }


    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    
    // Assume you have a method to fetch raw DateAndSigns data
    func fetchDateAndSigns() async -> [DateAndSign] {
        // Fetch your raw DateAndSigns data here
        // For now, we'll return an empty array
        return []
    }

    func loadAndAdjustDateAndSigns(for coordinate: CLLocationCoordinate2D) async {
        let rawDateAndSigns = await fetchDateAndSigns()
        DateAndSigns = await adjustToUserTimeZone(DateAndSigns: rawDateAndSigns, userCoordinate: coordinate)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation() // Stop updating location to save battery
            Task {
                await fetchAndDisplayData(for: location.coordinate)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        // Handle the error appropriately, maybe set a default location or show an error message
    }


    func fetchAndDisplayData(for coordinate: CLLocationCoordinate2D) async {
        guard let userTimeZone = await ChartCake.getTimeZone(coordinate) else {
            print("Could not retrieve user's timezone.")
            return
        }
        
        var sunStartDate = chartCake.getSunStartDate(currentDate: Date(), calendar: Calendar.current) ?? Date()
        sunStartDate = chartCake.adjustForTimezone(date: sunStartDate, timezone: userTimeZone)
        print("Adjusted Sun Start Date: \(sunStartDate)")
        
        // Fetch the sun transition moment
        let sunTransitions = chartCake.findSignTransitionMoment(startSearchDate: sunStartDate, celestialBody: chartCake.transits.sun.body, maxSearchDays: 2)
        if let sunTransitionMoment = sunTransitions.first?.date {
            // Adjust the sun's transition moment to local time
            let localSunTransitionMoment = chartCake.adjustForTimezone(date: sunTransitionMoment, timezone: userTimeZone)
            
            // Now use this local time to check the moon's sign
            let moonSignAtSunTransition = chartCake.moonSignForDate(localSunTransitionMoment)
        }
        let moonTransitions = chartCake.findSignTransitionMoment(startSearchDate: sunStartDate, celestialBody: chartCake.transits.moon.body, maxSearchDays: 30)
            let combinedTransitions = (sunTransitions + moonTransitions)
                .map { transition in
                    DateAndSign(date: transition.date, sign: transition.sign, celestialBody: transition.celestialBody)
                }
                .sorted(by: { $0.date < $1.date })

            DateAndSigns = await adjustTransitions(combinedTransitions, for: coordinate)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    

    func adjustTransitions(_ transitions: [DateAndSign], for coordinate: CLLocationCoordinate2D) async -> [DateAndSign] {
        guard let userTimeZone = await ChartCake.getTimeZone(coordinate) else {
            print("Could not retrieve user's timezone.")
            return transitions
        }

        print("User's timezone: \(userTimeZone)")
        
        return transitions.map { transition in
            let adjustedDate = chartCake.adjustForTimezone(date: transition.date, timezone: userTimeZone)
            print("Original date: \(transition.date), Adjusted date: \(adjustedDate), Timezone: \(userTimeZone)")
            return DateAndSign(date: adjustedDate, sign: transition.sign, celestialBody: transition.celestialBody)
        }
    }


    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DateAndSigns.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let change = DateAndSigns[indexPath.row]

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "E, MMM d, yyyy 'at' h:mma"
        let timeZoneAbbreviation = dateFormatter.timeZone.abbreviation() ?? "TZ" // Fallback to "TZ" if abbreviation is nil

        let dateString = dateFormatter.string(from: change.date)
        
        var cellText: String = ""
        
        if indexPath.row == 0, change.celestialBody == Planet.sun.celestialObject {
            let sunTransitionText = "☀️ enters \(change.sign.shortName) \(change.sign.emoji) on \(dateString) \(timeZoneAbbreviation)"
            let moonSignAtSunTransition = chartCake.moonSignForDate(change.date)
            cellText = "\(sunTransitionText)\nMoon in \(moonSignAtSunTransition.shortName) \(moonSignAtSunTransition.emoji) at this time"
            cell.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        } else {
            // Configuration for moon transitions and default case
            switch change.celestialBody {
            case Planet.moon.celestialObject:
                let lunarPhase = chartCake.lunarPhaseForDate(change.date, chart: chartCake)
                cellText = "\(lunarPhase.emoji) Moon in \(change.sign.shortName) \(change.sign.emoji) \(dateString) \(timeZoneAbbreviation)"
                cell.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
            default:
                cellText = "Transition on \(dateString)"
                cell.backgroundColor = UIColor.clear
            }
        }

        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.numberOfLines = 0 // Allow multiple lines
        cell.textLabel?.text = cellText

        return cell
    }

}
