//
//  more scores.swift
//  AstroLogic
//
//  Created by Errick Williams on 7/13/23.
//

import Foundation
import SwiftEphemeris

func calculateAngleSignScores(chart: Chart) -> [String: Double] {
    let totalPowerScoresForAngles = getTotalPowerScoresForAngles(chart: chart)
    var angleSignScores: [String: Double] = [:]

    let anglesSign: [String] = [chart.houseCusps.ascendent.sign.keyName, chart.houseCusps.midHeaven.sign.keyName]
    let angles = [chart.houseCusps.ascendent, chart.houseCusps.midHeaven]

    for (index, angle) in angles.enumerated() {
        if let signScore = angleSignScores[anglesSign[index]] {
            angleSignScores[anglesSign[index]] = signScore + (totalPowerScoresForAngles[angle.name] ?? 0.0)
        } else {
            angleSignScores[anglesSign[index]] = totalPowerScoresForAngles[angle.name] ?? 0.0
        }
    }
    
    return angleSignScores
}

func getTotalPowerScoresForAngles(chart: Chart) -> [String: Double] {
    let cuspScores = chart.getAllCuspAspectScores()
    let parallelScores = chart.allParallelCuspAspectScores()
    let angleHouseScores: [String: Double] = ["ascendant": 15, "midheaven": 15]
    
    // Combine the scores for all aspects
    var combinedScores: [String: Double] = [:]
    
    // Add house scores to combined scores
    for (angle, score) in angleHouseScores {
        combinedScores[angle.lowercased()] = (combinedScores[angle.lowercased()] ?? 0) + score
    }
    
    // Add cusp aspect scores to combined scores
    for (angle, score) in cuspScores {
        combinedScores[angle.keyName.lowercased()] = (combinedScores[angle.keyName.lowercased()] ?? 0) + score
    }
    
    // Add parallel aspect scores to combined scores
    for (angle, score) in parallelScores {
        combinedScores[angle.keyName.lowercased()] = (combinedScores[angle.keyName.lowercased()] ?? 0) + score
    }
    
    // Sort the angles in descending order of their power scores
    let sortedAngles = combinedScores.sorted(by: { $0.value > $1.value })
    
    // Print the combined scores for each angle in order from most power to least
    for (_, _) in sortedAngles {
//        print("\(angle): \(score)")
    }
    return combinedScores
}


func calculatePlanetSignScores(chart: Chart) -> [String: Double] {
    let totalPowerScores = getTotalPowerScoresForPlanets2(chart: chart)
   
    var planetSignScores: [String: Double] = [:]
    
    for planet in chart.allBodies {
        if let signScore = planetSignScores[planet.sign.keyName] {
            planetSignScores[planet.sign.keyName] = signScore + (totalPowerScores[planet.body.keyName] ?? 0.0)
        } else {
            planetSignScores[planet.sign.keyName] = totalPowerScores[planet.body.keyName] ?? 0.0
        }
    }
    
    return planetSignScores
}

    



func calculateUnoccupiedSignStrengths(chart: Chart, houseCusps: [String], interceptedSigns: [String]) -> [String: Double] {
    let rulerPowers = getTotalPowerScoresForPlanets2(chart: chart)

    var signStrengths: [String: Double] = [:]

    for sign in Zodiac.allCases {
        var rulers: [String] = []

        switch sign {
        case .aries:
            rulers.append(chart.mars.body.keyName)
        case .taurus:
            rulers.append(chart.venus.body.keyName)
        case .gemini:
            rulers.append(chart.mercury.body.keyName)
        case .cancer:
            rulers.append(chart.moon.body.keyName)
        case .leo:
            rulers.append(chart.sun.body.keyName)
        case .virgo:
            rulers.append(chart.mercury.body.keyName)
        case .libra:
            rulers.append(chart.venus.body.keyName)
        case .scorpio:
            rulers.append(chart.mars.body.keyName)
            rulers.append(chart.pluto.body.keyName)
        case .sagittarius:
            rulers.append(chart.jupiter.body.keyName)
        case .capricorn:
            rulers.append(chart.saturn.body.keyName)
        case .aquarius:
            rulers.append(chart.uranus.body.keyName)
            rulers.append(chart.saturn.body.keyName)
        case .pisces:
            rulers.append(chart.neptune.body.keyName)
            rulers.append(chart.jupiter.body.keyName)
        }
        var rulerStrengths: [Double] = []
        for ruler in rulers {
            if let power = rulerPowers[ruler] {
                rulerStrengths.append(power)
            }
        }

        if rulerStrengths.isEmpty {
            signStrengths[sign.keyName] = 0.0
        } else {
            var totalStrength: Double = 0.0
            for strength in rulerStrengths {
                totalStrength += strength
            }
            let averageStrength = totalStrength / Double(rulerStrengths.count)
            
            if interceptedSigns.contains(sign.keyName) {
                // Intercepted sign: power is one-fourth the power of its ruler
                signStrengths[sign.keyName] = averageStrength * 0.25
            } else if houseCusps.filter({ $0 == sign.formatted }).count > 1 {
                // Occupies more than one house: power is one-half the power of its ruler (used only once in calculation)
                signStrengths[sign.keyName] = averageStrength * 0.5
            } else if houseCusps.contains(sign.keyName) {
                // Occupies one house: power is one-half the power of its ruler
                signStrengths[sign.keyName] = averageStrength * 0.5
            } else {
                // Unoccupied and not intercepted: power is one-fourth the power of its ruler
                signStrengths[sign.keyName] = averageStrength * 0.25
            }
        }
    }
    return signStrengths
}

func calculateTotalSignScore(chart: Chart, houseCusps: [String], interceptedSigns: [String]) -> [String: Double] {
    let planetSignScores = calculatePlanetSignScores(chart: chart)
    let unoccupiedSignStrengths = calculateUnoccupiedSignStrengths(chart: chart, houseCusps: houseCusps, interceptedSigns: interceptedSigns)
    
    let angleSignScores = calculateAngleSignScores(chart: chart)
    
    var totalSignScores: [String: Double] = [:]

    for sign in Zodiac.allCases {
        let planetScore = planetSignScores[sign.keyName] ?? 0.0
        let unoccupiedStrength = unoccupiedSignStrengths[sign.keyName] ?? 0.0
        let angleScore = angleSignScores[sign.keyName] ?? 0.0
        totalSignScores[sign.keyName] = planetScore + unoccupiedStrength + angleScore
    }

    return totalSignScores
}


func calculatePlanetInHouseScores(chart: Chart, planetsInHouses: [Int: [String]]) -> [Int: Double] {
    let planetPowerScores = getTotalPowerScoresForPlanets2(chart: chart)

    var planetInHouseScores: [Int: Double] = [:]

    for (house, celestialObjects) in planetsInHouses {
        var totalScore = 0.0
        for planet in celestialObjects {
            if let score = planetPowerScores[planet] {
                totalScore += score
            }
        }
        planetInHouseScores[house] = totalScore
    }

    return planetInHouseScores
}

func calculateHouseStrengths(chart: Chart, houseCusps: [String], interceptedSigns: [String], planetsInHouses: [Int: [String]]) -> [Int: Double] {
    let unoccupiedSignStrengths = calculateUnoccupiedSignStrengths(chart: chart, houseCusps: houseCusps, interceptedSigns: interceptedSigns)
    let totalPowerScores = getTotalPowerScoresForPlanets2(chart: chart)
    let anglePowerScores = getTotalPowerScoresForAngles(chart: chart)

    var houseStrengths: [Int: Double] = [:]

    for (houseIndex, sign) in houseCusps.enumerated() {
        let houseNumber = houseIndex + 1
        var houseStrength = unoccupiedSignStrengths[sign] ?? 0.0

        if let interceptedSignStrength = interceptedSigns.first(where: { $0 == sign }).flatMap({ unoccupiedSignStrengths[$0] }) {
            houseStrength += interceptedSignStrength
        }

        if let planetsInHouse = planetsInHouses[houseNumber] {
            let planetsStrength = planetsInHouse.compactMap({ totalPowerScores[$0] }).reduce(0.0, +)
            houseStrength += planetsStrength
        }

        if houseNumber == 1, let ascendantStrength = anglePowerScores["ascendant"] {
            houseStrength += ascendantStrength
        }

        if houseNumber == 10, let midheavenStrength = anglePowerScores["midheaven"] {
            houseStrength += midheavenStrength
        }

        houseStrengths[houseNumber] = houseStrength
    }

    return houseStrengths
}
