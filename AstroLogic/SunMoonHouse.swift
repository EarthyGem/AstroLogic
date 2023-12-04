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
import EventKit
import FSCalendar
//
//struct DateAndHouse {
//    var date: Date4
//    var house: Int
//    var celestialBody: CelestialObject
//}


class HouseTransitionVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, FSCalendarDataSource, FSCalendarDelegate {
    var tableView: UITableView!
    var DateAndHouses: [ChartCake.DateAndHouse] = []
    var chartCake: ChartCake!
    let locationManager = CLLocationManager()
    let eventStore = EKEventStore()
    var calendar: FSCalendar!
    override func viewDidLoad() {
            super.viewDidLoad()
        setupTableView(below: 500)
        requestCalendarAccess()
            configureLocationManager()
            requestHouseTransitionData()
        setupCalendar()
     //   setupCustomCalendarHeader()
        addCustomHeaderLabel1()
        addCustomHeaderLabel2()
        }
    private func requestCalendarAccess() {
        eventStore.requestAccess(to: .event) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    print("Access Granted")
                } else if let error = error {
                    print("Error requesting calendar access: \(error)")
                } else {
                    print("Access Denied")
                    // Consider alerting the user to enable access in Settings
                }
            }
        }
    }
    private func addCustomHeaderLabel1() {
        let customHeaderLabel = UILabel()
        customHeaderLabel.backgroundColor = .clear
        customHeaderLabel.textAlignment = .center
        customHeaderLabel.textColor = .black
        customHeaderLabel.text = "♐️" // Your custom text here

        // Add constraints or set the frame of the label to position it correctly
        // This is just an example using frames
        customHeaderLabel.frame = CGRect(
            x: 0,
            y: calendar.frame.minY, // Adjust this as needed
            width: calendar.frame.width,
            height: 20 // The height of your custom label
        )

        // Insert the label into the view hierarchy
       // view.insertSubview(customHeaderLabel, aboveSubview: calendar)
    }
    
    private func addCustomHeaderLabel2() {
        let customHeaderLabel = UILabel()
        customHeaderLabel.backgroundColor = .clear
        customHeaderLabel.textAlignment = .center
        customHeaderLabel.textColor = .black
        customHeaderLabel.text = "\(chartCake.transits.sun.sign.shortName)" // Your custom text here

        // Add constraints or set the frame of the label to position it correctly
        // This is just an example using frames
        customHeaderLabel.frame = CGRect(
            x: 0,
            y: calendar.frame.minY, // Adjust this as needed
            width: calendar.frame.width,
            height: 20 // The height of your custom label
        
        )

        // Insert the label into the view hierarchy
      //  view.insertSubview(customHeaderLabel, aboveSubview: calendar)
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
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "CELL")
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
    
    func addTransitionToCalendar(transition: ChartCake.DateAndHouse) {
        guard let calendar = eventStore.defaultCalendarForNewEvents else {
               // Handle the case where there is no default calendar
               return
           }

        let event = EKEvent(eventStore: eventStore)
        event.calendar = calendar
        event.title = "\(transition.celestialBody) enters House \(transition.house)"
        event.startDate = transition.date
        // Assume a default duration for the event or customize as needed
        event.endDate = transition.date.addingTimeInterval(2 * 60 * 60)

        do {
            try eventStore.save(event, span: .thisEvent)
        } catch {
            // Handle errors
        }
    }
    func findTransitions(for date: Date) -> (Int?) {
     //   let signTransition = DateAndSigns.first { $0.date.isSameDay(as: date) }
        let houseTransition = DateAndHouses.first { $0.date.isSameDay(as: date) }
        return (houseTransition?.house)
    }


    // Helper function to adjust dates for a given timezone
    private func adjustForTimezone(date: Date, timezone: TimeZone) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let localDateString = dateFormatter.string(from: date)
        return dateFormatter.date(from: localDateString) ?? date
    }
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position) as! CustomCalendarCell
        
        if let house = findTransitions(for: date) {
            cell.houseLabel.text = "\(house)"
            // Set the sign image if necessary
          
            
        } else {
            // Reset to default state if no transition
            cell.houseLabel.text = nil
            cell.signImageView.image = nil
        }

        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transition = DateAndHouses[indexPath.row]
        addTransitionToCalendar(transition: transition)
        // Maybe show an alert or confirmation to the user
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
extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
}
