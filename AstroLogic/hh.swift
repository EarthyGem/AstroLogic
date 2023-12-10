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

    var chartCake: ChartCake!
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


func findCycleStartDate(forPlanet planet: CelestialObject, startingFromDate date: Date, at coordinate: CLLocationCoordinate2D,  on eventDate: Date) -> ChartCake? {
        var currentDate = date
        var previousDeclination = getDeclination(forPlanet: planet, onDate: currentDate)

        let increment: Int
        switch planet {
        case Planet.jupiter.celestialObject, Planet.mars.celestialObject, Planet.saturn.celestialObject:
            increment = -1 // Smaller steps for slower-moving planets
        default:
            increment = -30 // Adjusting for other planets
        }

        while true {
            guard let newDate = Calendar.current.date(byAdding: .day, value: increment, to: currentDate) else { break }
            let currentDeclination = getDeclination(forPlanet: planet, onDate: newDate)

            if previousDeclination >= 0 && currentDeclination < 0 {
                let refinedDate = refineSearchForZeroCrossing(fromDate: newDate, forPlanet: planet)
                if let refinedDate = refinedDate {
                    let finalDeclination = getDeclination(forPlanet: planet, onDate: refinedDate)
                    print("Cycle start date for \(planet): \(refinedDate), Declination at start: \(finalDeclination)")

                    // Create and return a ChartCake with the found date
                    let chartCake = ChartCake(birthDate: refinedDate, latitude: coordinate.latitude, longitude: coordinate.longitude, transitDate: eventDate)
                    return chartCake
                }
            }

            currentDate = newDate
            previousDeclination = currentDeclination
        }

        return nil
    }
func findCycleStartDate(forPlanet planet: CelestialObject, startingFromDate date: Date) -> Date? {
    var currentDate = date
    var previousDeclination = getDeclination(forPlanet: planet, onDate: currentDate)
    var increment = -1 // Initial step

    while true {
        guard let newDate = Calendar.current.date(byAdding: .day, value: increment, to: currentDate) else { break }
        let currentDeclination = getDeclination(forPlanet: planet, onDate: newDate)

        if previousDeclination >= 0 && currentDeclination < 0 {
            // When close to zero, refine search
            return refineSearchForZeroCrossing(fromDate: newDate, forPlanet: planet)
        }

        currentDate = newDate
        previousDeclination = currentDeclination

        // Dynamically adjust step size based on proximity to zero
        if abs(currentDeclination) < 1.0 {
            increment = -1 // Smaller steps when close to zero
        } else {
            increment = -5 // Larger steps when far from zero
        }
    }

    return nil
}

func refineSearchForZeroCrossing(fromDate date: Date, forPlanet planet: CelestialObject) -> Date? {
    var lowerBound = date
    var upperBound = Calendar.current.date(byAdding: .day, value: 1, to: date)!

    while lowerBound < upperBound {
        let middlePoint = lowerBound.addingTimeInterval(upperBound.timeIntervalSince(lowerBound) / 2)
        let midDeclination = getDeclination(forPlanet: planet, onDate: middlePoint)

        if abs(midDeclination) < 0.00001 { // Reduced threshold for zero
            return middlePoint
        } else if midDeclination > 0 {
            upperBound = middlePoint
        } else {
            lowerBound = middlePoint
        }

        if upperBound.timeIntervalSince(lowerBound) <= 0.5 { // More refined interval, e.g., 0.5 seconds
            break
        }
    }

    return lowerBound // Closest approximation to zero declination
}

func getDeclination(forPlanet planet: CelestialObject, onDate date: Date) -> Double {
    let coordinate = Coordinate(body: planet, date: date)
    return coordinate.declination
}


func findNewMoonDate(startingFromDate date: Date) -> Date? {
    var currentDate = date
    let dayIncrement = 1 // Daily check for broad search
    let degreeThreshold = 13.0 // Threshold for close alignment

    while true {
        let moonCoordinate = getCoordinate(forCelestialBody: Planet.moon.celestialObject, onDate: currentDate)
        let sunCoordinate = getCoordinate(forCelestialBody: Planet.sun.celestialObject, onDate: currentDate)

        let longitudeDifference = abs(moonCoordinate.longitude - sunCoordinate.longitude)

        if longitudeDifference < degreeThreshold {
            // Once within the threshold, refine search for exact conjunction
            return refineSearchForConjunction(startingFromDate: currentDate)
        }

        // Move to the next day
        guard let newDate = Calendar.current.date(byAdding: .day, value: dayIncrement, to: currentDate) else { break }
        currentDate = newDate
    }

    return nil
}

func refineSearchForConjunction(startingFromDate date: Date) -> Date? {
    var lowerBound = date
    var upperBound = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    let threshold = 0.01 // Fine threshold for exact conjunction

    while lowerBound < upperBound {
        let middlePoint = lowerBound.addingTimeInterval(upperBound.timeIntervalSince(lowerBound) / 2)
        let moonCoordinate = getCoordinate(forCelestialBody: Planet.moon.celestialObject, onDate: middlePoint)
        let sunCoordinate = getCoordinate(forCelestialBody: Planet.sun.celestialObject, onDate: middlePoint)

        let longitudeDifference = abs(moonCoordinate.longitude - sunCoordinate.longitude)

        if longitudeDifference < threshold {
            return middlePoint
        } else if moonCoordinate.longitude < sunCoordinate.longitude {
            lowerBound = middlePoint
        } else {
            upperBound = middlePoint
        }

        if upperBound.timeIntervalSince(lowerBound) <= 1 { // More refined interval, e.g., 1 second
            break
        }
    }

    return lowerBound
}


func getCoordinate(forCelestialBody body: CelestialObject, onDate date: Date) -> Coordinate {
    let coordinate = Coordinate(body: body, date: date)
    return coordinate
}

func findAspectsInYear(forPlanets planet1: CelestialObject,
                       planet2: CelestialObject,
                       year: Int,
                       at location: CLLocationCoordinate2D,
                       orb: Double) -> [ChartCake] {

    // Construct the date range for the specified year
    var components = DateComponents()
    components.year = year
    components.month = 1
    components.day = 1
    guard let startDate = Calendar.current.date(from: components) else { return [] }

    components.month = 12
    components.day = 31
    guard let endDate = Calendar.current.date(from: components) else { return [] }

    var currentDate = startDate
    var foundChartCakes: [ChartCake] = []

    // Check for aspects every day of the year
    while currentDate <= endDate {
        let coordinate1 = Coordinate(body: planet1, date: currentDate)
        let coordinate2 = Coordinate(body: planet2, date: currentDate)

        for aspectKind in Kind.majorAspects { // Assuming Kind includes all your aspect types
            if let celestialAspect = CelestialAspect(body1: coordinate1, body2: coordinate2, orb: orb),

                celestialAspect.kind == aspectKind {

                let chartCake = ChartCake(birthDate: currentDate, latitude: location.latitude, longitude: location.longitude, transitDate: currentDate)
                foundChartCakes.append(chartCake!)
            }
        }

        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    }

    return foundChartCakes
}



    // Example usage:

