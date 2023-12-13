//
//  PlanetaryHoursVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/12/23.
//

import Foundation
import UIKit

import SwiftEphemeris
import CoreLocation
// Assuming you have a PlanetaryHour model which includes the planet, start time, and end time
struct PlanetaryHour {
    var planet: String
    var startTime: Date
    var endTime: Date
    var isCurrent: Bool {
        let now = Date()
        return now >= startTime && now < endTime
    }
}

class PlanetaryHourTableViewCell: UITableViewCell {
    // Configure your cell with labels, etc.
    let timeFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.timeStyle = .short
          formatter.dateStyle = .none
          formatter.timeZone = TimeZone.current // Using the system timezone
          return formatter
      }()

      func configure(with planetaryHour: PlanetaryHour) {
          textLabel?.text = "\(planetaryHour.planet) Hour \(timeFormatter.string(from: planetaryHour.startTime)) - \(timeFormatter.string(from: planetaryHour.endTime))"
          // Additional configuration...
        // Additional configuration

        // Distinguish if it's the current hour
        backgroundColor = planetaryHour.isCurrent ? UIColor.yellow : UIColor.clear
    }
}

class PlanetaryHoursViewController: UIViewController, UITableViewDataSource, CLLocationManagerDelegate {
    var tableView: UITableView!
    var planetaryHours: [PlanetaryHour] = [] // Populate this array with your calculated planetary hours
    var latitude: Double!
    var longitude: Double!

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.register(PlanetaryHourTableViewCell.self, forCellReuseIdentifier: "PlanetaryHourCell")
        view.addSubview(tableView)

        // Calculate planetary hours and reload the tableView
        calculatePlanetaryHours()
        tableView.reloadData()

        // Initialize the location manager and request authorization
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // or requestAlwaysAuthorization() depending on your needs

        // Start updating the location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }





      // Handle the location updates
      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          if let location = locations.last {
              latitude = location.coordinate.latitude
              longitude = location.coordinate.longitude

              // Stop location updates if you only need the location once
              locationManager.stopUpdatingLocation()

              // Calculate planetary hours with the current location
              calculatePlanetaryHours()
          }
      }

      // Handle authorization status changes
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
          switch status {
          case .authorizedWhenInUse, .authorizedAlways:
              locationManager.startUpdatingLocation()
          default:
              // Handle other authorization states
              break
          }
      }

      // Handle potential errors
      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          print(error)
      }


      let planetsSequence = ["Sun", "Venus", "Mercury", "Moon", "Saturn", "Jupiter", "Mars"]

    func calculatePlanetaryHours() {
           let calendar = Calendar.current

        guard let latitude = self.latitude, let longitude = self.longitude else {
               print("Location is not yet available.")
               return
           }

        let currentDate = Date()
           let sunrise = RiseTime(date: currentDate, body: Planet.sun.celestialObject, longitude: longitude, latitude: latitude)
           let sunset = SetTime(date: currentDate, body: Planet.sun.celestialObject, longitude: longitude, latitude: latitude)
        print(sunrise.date)
        print(currentDate)
           // Make sure you have valid sunrise and sunset times before proceeding
           guard let sunriseDate = sunrise.date, let sunsetDate = sunset.date else {
               print("Could not calculate sunrise or sunset times.")
               return
           }

           // Calculate the length of the day and the night
           let dayLengthInSeconds = sunsetDate.timeIntervalSince(sunriseDate)
           let nightLengthInSeconds = 24 * 60 * 60 - dayLengthInSeconds

           // Calculate the duration of each planetary hour
           let dayHourDuration = dayLengthInSeconds / 12
           let nightHourDuration = nightLengthInSeconds / 12

           // Determine the planet for the first hour of the day
           let weekday = calendar.component(.weekday, from: sunriseDate) // 1 = Sunday, 2 = Monday, etc.
           let firstPlanetIndex = (weekday + 5) % planetsSequence.count // Adjusted to account for array index starting at 0

           var currentPlanetIndex = firstPlanetIndex
           var currentTime = sunriseDate
           for _ in 1...12 {
               let endTime = currentTime.addingTimeInterval(dayHourDuration)
               let planetaryHour = PlanetaryHour(planet: planetsSequence[currentPlanetIndex], startTime: currentTime, endTime: endTime)
               planetaryHours.append(planetaryHour)

               currentTime = endTime
               currentPlanetIndex = (currentPlanetIndex + 1) % planetsSequence.count
           }

           // Reset for the night hours
           currentTime = sunsetDate
           currentPlanetIndex = (firstPlanetIndex + 6) % planetsSequence.count // The planet ruling the first hour of the night

           for _ in 1...12 {
               let endTime = currentTime.addingTimeInterval(nightHourDuration)
               let planetaryHour = PlanetaryHour(planet: planetsSequence[currentPlanetIndex], startTime: currentTime, endTime: endTime)
               planetaryHours.append(planetaryHour)

               currentTime = endTime
               currentPlanetIndex = (currentPlanetIndex + 1) % planetsSequence.count
           }

           // Sort the array by start time
           planetaryHours.sort { $0.startTime < $1.startTime }

           // Reload the tableView on the main thread after calculation
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }

    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetaryHours.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetaryHourCell", for: indexPath) as! PlanetaryHourTableViewCell
        let planetaryHour = planetaryHours[indexPath.row]
        cell.configure(with: planetaryHour)
        return cell
    }
}
