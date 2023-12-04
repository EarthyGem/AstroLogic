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
import EventKit
import FSCalendar

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

class SunMoonSeasonVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, FSCalendarDataSource, FSCalendarDelegate {
    var calendar: FSCalendar!
    let eventStore = EKEventStore()
    var tableView: UITableView!
    var DateAndSigns: [DateAndSign] = []
    var chartCake: ChartCake!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(below: 300 + 20)
        requestCalendarAccess()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupCalendar()
        
    }
    private func requestCalendarAccess() {
            eventStore.requestAccess(to: .event) { granted, error in
                if granted {
                    // Access granted
                } else {
                    // Handle access denied
                }
            }
        }
    private func setupCustomCalendarHeader() {
        let headerView = CustomCalendarHeaderView(frame: CGRect(x: 0, y: 20, width: self.view.bounds.width, height: 40))
        headerView.updateHeader(for: Date(), sunSign: getCurrentSunSign())
        self.view.addSubview(headerView)
    }
    private func getCurrentSunSign() -> String {
        // Logic to determine the current Sun sign
        // Example:
        return chartCake.transits.sun.sign.keyName
    }
    
    private func setupCalendar() {
        let calendarHeight: CGFloat = 300
        calendar = FSCalendar(frame: CGRect(x: 0, y: 80, width: self.view.bounds.width, height: calendarHeight))
        
        
        // Customization
        calendar.backgroundColor = UIColor.white
        calendar.appearance.titleDefaultColor = UIColor.black
        calendar.appearance.headerTitleColor = UIColor.black
        calendar.appearance.weekdayTextColor = UIColor.black
        calendar.calendarHeaderView.backgroundColor = UIColor.lightGray

        calendar.dataSource = self
        calendar.delegate = self
        self.view.addSubview(calendar)
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "customCell")
        setupTableView(below: calendarHeight + 20)
        
     
    }


    private func setupTableView(below yOffset: CGFloat) {
        let tableViewFrame = CGRect(x: 0, y: 380, width: self.view.bounds.width, height: self.view.bounds.height - yOffset)
        tableView = UITableView(frame: tableViewFrame, style: .plain)
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
    func addSignTransitionToCalendar(transition: DateAndSign) {
        let event = EKEvent(eventStore: eventStore)
        event.calendar = eventStore.defaultCalendarForNewEvents
        event.title = "\(transition.celestialBody) enters \(transition.sign)"
        event.startDate = transition.date
        event.endDate = transition.date.addingTimeInterval(3600) // Example duration

        do {
            try eventStore.save(event, span: .thisEvent)
        } catch {
            // Handle the error
        }
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
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at monthPosition: FSCalendarMonthPosition) -> FSCalendarCell {
           let cell = calendar.dequeueReusableCell(withIdentifier: "customCell", for: date, at: monthPosition) as! CustomCalendarCell

           // Configure your cell here
           // For example, setting images based on the date
           if let transitionData = findTransitionDataForDate(date) {
               cell.signImageView.image = UIImage(named: transitionData.signImageName)
               cell.celestialBodyImageView.image = UIImage(named: transitionData.celestialBodyImageName)
           }

           return cell
       }

       // Helper function to find transition data for a given date

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
            cell.textLabel?.numberOfLines = 0 // Allow multiple lines
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            let sunTransitionText = "☀️ enters \(change.sign.shortName) \(change.sign.emoji) on \(dateString) \(timeZoneAbbreviation)"
            let moonSignAtSunTransition = chartCake.moonSignForDate(change.date)
            cellText = "\(sunTransitionText)\nMoon in \(moonSignAtSunTransition.shortName) \(moonSignAtSunTransition.emoji) at this time"
            cell.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        } else {
            // Configuration for moon transitions and default case
            switch change.celestialBody {
            case Planet.moon.celestialObject:
                cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
                let lunarPhase = chartCake.lunarPhaseForDate(change.date, chart: chartCake)
                cellText = "\(lunarPhase.emoji) Moon in \(change.sign.shortName) \(change.sign.emoji) \(dateString) \(timeZoneAbbreviation)"
                cell.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
            default:
                cellText = "Transition on \(dateString)"
                cell.backgroundColor = UIColor.clear
            }
        }

        
    
        cell.textLabel?.text = cellText

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transition = DateAndSigns[indexPath.row]
        addSignTransitionToCalendar(transition: transition)
        // Maybe show an alert or confirmation to the user
    }


}
extension SunMoonSeasonVC {

    // Helper function to find transition data for a given date
    func findTransitionDataForDate(_ date: Date) -> (signImageName: String, celestialBodyImageName: String)? {
        // Example logic to find the transition data
        if let signTransition = DateAndSigns.first(where: { $0.date.isSameDay(as: date) }) {
            let signImageName = signTransition.sign.keyName // Assuming you have a method to get the image name
            let celestialBodyImageName = getCelestialBodyImageName(celestialBody: signTransition.celestialBody)
            return (signImageName, celestialBodyImageName)
        }

        // Return nil if there's no transition data for the given date
        return nil
    }

    // Helper function to get the celestial body image name
    func getCelestialBodyImageName(celestialBody: CelestialObject) -> String {
        // Example implementation, adjust as needed
        switch celestialBody {
        case chartCake.transits.sun.body:
            return "sun" // Replace with your actual image name for the sun
        case chartCake.transits.moon.body:
            return "moon" // Replace with your actual image name for the moon
        default:
            return "defaultImage" // Replace with a default image name
        }
    }
}
