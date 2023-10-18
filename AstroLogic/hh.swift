//
//  hh.swift
//  AstroLogic
//
//  Created by Errick Williams on 10/15/23.
//


import Foundation
import CSwissEphemeris
import SwiftEphemeris
import CoreLocation

func findCrossingZeroDeclination(targetPlanet: CelestialObject, latitude: Double, longitude: Double, maxIterations: Int) {
    // Fetch the timezone for the specified location
    let timestamp = Int(Date().timeIntervalSince1970)
    fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: timestamp) { timeZone in
        guard let timeZone = timeZone else {
            print("Unable to determine the timezone for the location.")
            return
        }

        // Define the initial date and time step for iteration.
        var currentDate = Date()
        let timeStep: TimeInterval = 60 * 60 * 24 // 1 hour (adjust as needed)

        // Define a flag to check if declination crosses 0 degrees.
        var hasCrossedZeroDeclination = false

        for _ in 1...maxIterations {
            // Create a Coordinate object for the target planet at the current date and with the determined timezone.
            let calendar = Calendar.current
            let components = calendar.dateComponents(in: timeZone, from: currentDate)
            var dateComponents = DateComponents()
            dateComponents.year = components.year
            dateComponents.month = components.month
            dateComponents.day = components.day
            dateComponents.hour = components.hour
            dateComponents.minute = components.minute
            dateComponents.second = components.second
            dateComponents.timeZone = timeZone

            if let dateWithTimeZone = Calendar.current.date(from: dateComponents) {
                let coordinate = Coordinate(body: targetPlanet, date: dateWithTimeZone)

                // Check if the declination crosses 0 degrees from negative to positive.
                if coordinate.declination >= 0 {
                    hasCrossedZeroDeclination = true

                    // Print the date and time when declination crosses 0 degrees.
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.timeZone = timeZone
                    let formattedTime = dateFormatter.string(from: dateWithTimeZone)

                    // Display the location (latitude and longitude).
                    print("Planet \(targetPlanet) reaches 0 degrees North declination at \(formattedTime) in \(timeZone.identifier)")
                    print("Location: Latitude \(latitude), Longitude \(longitude)")

                    // Exit the loop once the event is detected.
                    break
                }
            }

            // Increment the current date for the next iteration.
            currentDate = currentDate.addingTimeInterval(timeStep)
        }

        // Check if the desired moment was not reached.
        if !hasCrossedZeroDeclination {
            print("Planet \(targetPlanet) did not cross 0 degrees North declination in the specified range.")
        }
    }
}


func fetchCycleChart(for selectedDate: Date, at coordinate: CLLocationCoordinate2D, cycleChart: ChartCake, selectedPlanet: Coordinate) -> ChartCake? {
    let maxIterations = 10000
    var currentDate = selectedDate
    let timeStep: TimeInterval = -60 * 60  // Go backward in time by 1 hour
    var cycleChart = ChartCake(birthDate: currentDate, latitude: coordinate.latitude, longitude: coordinate.longitude)
    var previousCoordinate = selectedPlanet
    var hasCrossedSouthToNorthDeclination = false

    for _ in 1...maxIterations {
        let currentCoordinate = selectedPlanet // Update this line to get the current position of the planet at 'currentDate'

        if previousCoordinate.declination < 0 && currentCoordinate.declination >= 0 {
            hasCrossedSouthToNorthDeclination = true
            let chartCake = ChartCake(birthDate: currentDate, latitude: coordinate.latitude, longitude: coordinate.longitude, transitDate: currentDate)

print("first CC \(chartCake)")
            return chartCake
        }

        previousCoordinate = currentCoordinate
        currentDate = currentDate.addingTimeInterval(timeStep)
    }

    if !hasCrossedSouthToNorthDeclination {
        print("\(selectedPlanet.body.keyName) did not cross from south to north declination at the specified location prior to the given date.")
    }

    return nil
}


// Example usage:
let latitude = 33.7128 // Replace with your latitude
let longitude = -118.0060 // Replace with your longitude
let targetPlanet = CelestialObject.planet(Planet.sun) // Replace with the desired planet
let maxIterations = 365 // Adjust as needed

