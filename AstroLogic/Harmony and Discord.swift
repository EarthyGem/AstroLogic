////
////  Harmony and Discord.swift
////  AstroLogic
////
////  Created by Errick Williams on 7/13/23.
////
//
//
//import Foundation
//import SwiftEphemeris
//
//func getTotalHarmonyDiscordScoresForPlanets(chart: Chart) -> [String: (harmony: Double, discord: Double)] {
//    let aspectScores = getAspectHarmonyAndDiscordScores(chart: chart)
//    let parallelScores = getParallelHarmonyAndDiscordScores(chart: chart)
//    let dignityScores = calculateDignityScore(chart: chart)
//    let angularCuspScores = getAspectHarmonyAndDiscordScoresToAngularCusps(chart: chart)
//    
//    let angularParallelScores = calculateParallelHarmonyAndDiscordScores(chart: chart)
//    
//    
//    var combinedScores: [String: (harmony: Double, discord: Double)] = [:]
//    
//    // Add aspect scores to combined scores
//    for (planet, score) in aspectScores {
//        combinedScores[planet.keyName] = score
//    }
//    
//    // Add parallel scores to combined scores
//    for (planet, score) in parallelScores {
//        if let existingScore = combinedScores[planet.keyName] {
//            let harmonyScore = max(0, existingScore.harmony + score.harmony)
//            let discordScore = max(0, existingScore.discord + score.discord)
//            combinedScores[planet.keyName] = (harmony: harmonyScore, discord: discordScore)
//        } else {
//            let harmonyScore = max(0, score.harmony)
//            let discordScore = max(0, score.discord)
//            combinedScores[planet.keyName] = (harmony: harmonyScore, discord: discordScore)
//        }
//    }
//    // Add paraleells to cusps scores to combined scores
//    for (planet, score) in angularParallelScores {
//        if let existingScore = combinedScores[planet.keyName] {
//            let harmonyScore = max(0, existingScore.harmony + score.harmony)
//            let discordScore = max(0, existingScore.discord + score.discord)
//            combinedScores[planet.keyName] = (harmony: harmonyScore, discord: discordScore)
//        } else {
//            let harmonyScore = max(0, score.harmony)
//            let discordScore = max(0, score.discord)
//            combinedScores[planet.keyName] = (harmony: harmonyScore, discord: discordScore)
//        }
//    }
//    
//    
//    // Add dignity scores to combined scores
//    for (planet, score) in dignityScores {
//        if let existingScore = combinedScores[planet.keyName] {
//            let harmonyScore = max(0, existingScore.harmony + score.harmony)
//            let discordScore = max(0, existingScore.discord + score.discord)
//            combinedScores[planet.keyName] = (harmony: harmonyScore, discord: discordScore)
//        } else {
//            let harmonyScore = max(0, score.harmony)
//            let discordScore = max(0, score.discord)
//            combinedScores[planet.keyName] = (harmony: harmonyScore, discord: discordScore)
//        }
//    }
//    
//    // Add angular cusp scores to combined scores
//    for (planet, score) in angularCuspScores {
//        if let existingScore = combinedScores[planet.keyName] {
//            let harmonyScore = max(0, existingScore.harmony + score.harmony)
//            let discordScore = max(0, existingScore.discord + score.discord)
//            combinedScores[planet.keyName] = (harmony: harmonyScore, discord: discordScore)
//        } else {
//            let harmonyScore = max(0, score.harmony)
//            let discordScore = max(0, score.discord)
//            combinedScores[planet.keyName] = (harmony: harmonyScore, discord: discordScore)
//        }
//    }
//    
//    return combinedScores
//}
//
//
//func getHarmonyScoreDifferenceForPlanets(chart: Chart) -> [String: Double] {
//    let totalScores = getTotalHarmonyDiscordScoresForPlanets(chart: chart)
//    var harmonyScoreDifferences: [String: Double] = [:]
//    
//    for (planet, scores) in totalScores {
//        let harmonyScore = scores.harmony
//        let discordScore = scores.discord
//        let scoreDifference = harmonyScore - discordScore
//        
//        harmonyScoreDifferences[planet] = scoreDifference
//        
//        if scoreDifference >= 0 {
//           
//        } else {
//       
//        }
//    }
//   
//    return harmonyScoreDifferences
//}
//    
//func getScoresAndDifferenceForPlanets(chart: Chart) -> [String: (harmony: Double, discord: Double, difference: Double)] {
//    let totalScores = getTotalHarmonyDiscordScoresForPlanets(chart: chart)
//    var scoresAndDifference: [String: (harmony: Double, discord: Double, difference: Double)] = [:]
//    
//    for (planet, scores) in totalScores {
//        let harmonyScore = scores.harmony
//        let discordScore = scores.discord
//        let scoreDifference = harmonyScore - discordScore
//        
//        scoresAndDifference[planet] = (harmony: harmonyScore, discord: discordScore, difference: scoreDifference)
//    }
//    
//    return scoresAndDifference
//}
//
//
//func getAspectHarmonyAndDiscordScores(chart: Chart) -> [CelestialObject: (harmony: Double, discord: Double)] {
//    let totalAspectScores = chart.getAllCelestialAspectScores(chart.planets)
//    var aspectScores = [CelestialObject: (harmony: Double, discord: Double)]()
//    
//    for (planet, aspectScore) in totalAspectScores {
//   
//        let currentScores = aspectScores[planet] ?? (harmony: 0, discord: 0)
//        var harmony = currentScores.harmony
//        var discord = currentScores.discord
//                    
//        if aspectScore > 0 {
//            if planet == .planet(.mars) {
//                discord += aspectScore * 0.25
//            } else if planet == .planet(.saturn) {
//                discord += aspectScore * 0.5
//            } else if planet == .planet(.venus) {
//                harmony += aspectScore * 0.25
//            } else if planet == .planet(.jupiter) {
//                harmony += aspectScore * 0.5
//            }
//        }
//                
//        aspectScores[planet] = (harmony: harmony, discord: discord)
//    }
//
//    return aspectScores
//}
//
//
//func getParallelHarmonyAndDiscordScores(chart: Chart) -> [CelestialObject: (harmony: Double, discord: Double)] {
//    let allAspects = chart.getAllParallelAspects(<#[Coordinate]#>)
//    var aspectScores: [CelestialObject: (harmony: Double, discord: Double)] = [:]
//    
//    for aspect in allAspects {
//        let planet1 = aspect.body1
//        let planet2 = aspect.body2
//        _ = aspect.kind
//        let orb = aspect.orb
//
//        let isPlanet1Luminary = (planet1 == chart.sun || planet1 == chart.moon || planet1 == chart.mercury)
//        let isPlanet2Luminary = (planet2 == chart.sun || planet2 == chart.moon || planet2 == chart.mercury)
//        
//        // This could be redefined or removed depending on what it represents.
//        // For now, we just assume it's a constant or some predefined value.
//        let assignedOrb = 1.0
//
//        let actualOrb = orb
//        let aspectScore = (1 - abs(actualOrb)) * assignedOrb
//            
//        let planets = [planet1, planet2]
//            
//        for planet in planets {
//            let currentScores = aspectScores[planet.body] ?? (harmony: 0, discord: 0)
//            var harmony = currentScores.harmony
//            var discord = currentScores.discord
//                
//            if aspectScore > 0 {
//                if planet == chart.mars {
//                    discord += aspectScore * 0.25
//                } else if planet == chart.saturn {
//                    discord += aspectScore * 0.5
//                } else if planet == chart.venus {
//                    harmony += aspectScore * 0.25
//                } else if planet == chart.jupiter {
//                    harmony += aspectScore * 0.5
//                }
//            }
//                
//            aspectScores[planet.body] = (harmony: harmony, discord: discord)
//        }
//    }
//    
//    return aspectScores
//}
//
//func getAspectHarmonyAndDiscordScoresToAngularCusps(chart: Chart) -> [CelestialObject: (harmony: Double, discord: Double)] {
//    let allCuspAspectScores = chart.getAllCuspAspectScores()
//    var aspectScores: [CelestialObject: (harmony: Double, discord: Double)] = [:]
//    
//    for (planet, aspectScore) in allCuspAspectScores {
//        let isPlanetLuminary = (planet == .planet(.sun) || planet == .planet(.moon) || planet == .planet(.mercury))
//        let currentScores = aspectScores[planet] ?? (harmony: 0, discord: 0)
//        var harmony = currentScores.harmony
//        var discord = currentScores.discord
//        
//        if aspectScore > 0 {
//            if planet == .planet(.mars) {
//                discord += aspectScore * 0.25
//            } else if planet == .planet(.saturn) {
//                discord += aspectScore * 0.5
//            } else if planet == .planet(.venus) {
//                harmony += aspectScore * 0.25
//            } else if planet == .planet(.jupiter) {
//                harmony += aspectScore * 0.5
//            }
//        }
//        
//        aspectScores[planet] = (harmony: harmony, discord: discord)
//    }
//
//    return aspectScores
//}
//
//func calculateParallelHarmonyAndDiscordScores(chart: Chart) -> [CelestialObject: (harmony: Double, discord: Double)] {
//    let parallelScores = chart.allParallelCuspAspectScores()
//    
//    var harmonyAndDiscordScores: [CelestialObject: (harmony: Double, discord: Double)] = [:]
//    
//    for (planet, score) in parallelScores {
//        var harmonyScore = 0.0
//        var discordScore = 0.0
//        
//        switch planet {
//        case .planet(.jupiter):
//            harmonyScore = 0.5 * score
//        case .planet(.venus):
//            harmonyScore = 0.25 * score
//        case .planet(.saturn):
//            discordScore = 0.5 * score
//        case .planet(.mars):
//            discordScore = 0.25 * score
//        default:
//            break
//        }
//        
//        harmonyAndDiscordScores[planet] = (harmony: harmonyScore, discord: discordScore)
//    }
//    
//    return harmonyAndDiscordScores
//}
//
//
////
////func calculateAngleSignScores(birthChart: BirthChart, ascDeclination: Double, mcDeclination: Double) -> [String: Double] {
////    let totalPowerScoresForAngles = getTotalPowerScoresForAngles(birthChart: birthChart, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
////    var angleSignScores: [String: Double] = [:]
////
////    let anglesSign: [String] = [birthChart.houseCusps.ascendent.sign.keyName, birthChart.houseCusps.midHeaven.sign.keyName]
////    let angles = [birthChart.houseCusps.ascendent, birthChart.houseCusps.midHeaven]
////
////    for (index, angle) in angles.enumerated() {
////        if let signScore = angleSignScores[anglesSign[index]] {
////            angleSignScores[anglesSign[index]] = signScore + (totalPowerScoresForAngles[angle.name] ?? 0.0)
////        } else {
////            angleSignScores[anglesSign[index]] = totalPowerScoresForAngles[angle.name] ?? 0.0
////        }
////    }
////
////    return angleSignScores
////}
////
////
////func calculatePlanetSignScores(birthChart: BirthChart, date: Date, ascDeclination: Double, mcDeclination: Double) -> [String: Double] {
////    let totalPowerScores = getTotalPowerScoresForPlanets(birthChart: birthChart, date: date, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
////
////    var planetSignScores: [String: Double] = [:]
////
////    for planet in birthChart.allBodies {
////        if let signScore = planetSignScores[planet.sign.keyName] {
////            planetSignScores[planet.sign.keyName] = signScore + (totalPowerScores[planet.body.keyName] ?? 0.0)
////        } else {
////            planetSignScores[planet.sign.keyName] = totalPowerScores[planet.body.keyName] ?? 0.0
////        }
////    }
////
////    return planetSignScores
////}
////
////
////
////
////func calculateUnoccupiedSignStrengths(birthChart: BirthChart, date: Date, ascDeclination: Double, mcDeclination: Double, houseCusps: [String], interceptedSigns: [String]) -> [String: Double] {
////    let rulerPowers = getTotalPowerScoresForPlanets(birthChart: birthChart, date: date, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
////
////    var signStrengths: [String: Double] = [:]
////
////    for sign in Zodiac.allCases {
////        var rulers: [String] = []
////
////        switch sign {
////        case .aries:
////            rulers.append(birthChart.mars.body.keyName)
////        case .taurus:
////            rulers.append(birthChart.venus.body.keyName)
////        case .gemini:
////            rulers.append(birthChart.mercury.body.keyName)
////        case .cancer:
////            rulers.append(birthChart.moon.body.keyName)
////        case .leo:
////            rulers.append(birthChart.sun.body.keyName)
////        case .virgo:
////            rulers.append(birthChart.mercury.body.keyName)
////        case .libra:
////            rulers.append(birthChart.venus.body.keyName)
////        case .scorpio:
////            rulers.append(birthChart.mars.body.keyName)
////            rulers.append(birthChart.pluto.body.keyName)
////        case .sagittarius:
////            rulers.append(birthChart.jupiter.body.keyName)
////        case .capricorn:
////            rulers.append(birthChart.saturn.body.keyName)
////        case .aquarius:
////            rulers.append(birthChart.uranus.body.keyName)
////            rulers.append(birthChart.saturn.body.keyName)
////        case .pisces:
////            rulers.append(birthChart.neptune.body.keyName)
////            rulers.append(birthChart.jupiter.body.keyName)
////        }
////        var rulerStrengths: [Double] = []
////        for ruler in rulers {
////            if let power = rulerPowers[ruler] {
////                rulerStrengths.append(power)
////            }
////        }
////
////        if rulerStrengths.isEmpty {
////            signStrengths[sign.keyName] = 0.0
////        } else {
////            var totalStrength: Double = 0.0
////            for strength in rulerStrengths {
////                totalStrength += strength
////            }
////            let averageStrength = totalStrength / Double(rulerStrengths.count)
////
////            if interceptedSigns.contains(sign.keyName) {
////                // Intercepted sign: power is one-fourth the power of its ruler
////                signStrengths[sign.keyName] = averageStrength * 0.25
////            } else if houseCusps.filter({ $0 == sign.formatted }).count > 1 {
////                // Occupies more than one house: power is one-half the power of its ruler (used only once in calculation)
////                signStrengths[sign.keyName] = averageStrength * 0.5
////            } else if houseCusps.contains(sign.keyName) {
////                // Occupies one house: power is one-half the power of its ruler
////                signStrengths[sign.keyName] = averageStrength * 0.5
////            } else {
////                // Unoccupied and not intercepted: power is one-fourth the power of its ruler
////                signStrengths[sign.keyName] = averageStrength * 0.25
////            }
////        }
////    }
////    return signStrengths
////}
////
////func calculateTotalSignScore(birthChart: BirthChart, date: Date, ascDeclination: Double, mcDeclination: Double, houseCusps: [String], interceptedSigns: [String]) -> [String: Double] {
////    let planetSignScores = calculatePlanetSignScores(birthChart: birthChart, date: date, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
////    let unoccupiedSignStrengths = calculateUnoccupiedSignStrengths(birthChart: birthChart, date: date, ascDeclination: ascDeclination, mcDeclination: mcDeclination, houseCusps: houseCusps, interceptedSigns: interceptedSigns)
////
////    let angleSignScores = calculateAngleSignScores(birthChart: birthChart, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
////
////    var totalSignScores: [String: Double] = [:]
////
////    for sign in Zodiac.allCases {
////        let planetScore = planetSignScores[sign.keyName] ?? 0.0
////        let unoccupiedStrength = unoccupiedSignStrengths[sign.keyName] ?? 0.0
////        let angleScore = angleSignScores[sign.keyName] ?? 0.0
////        totalSignScores[sign.keyName] = planetScore + unoccupiedStrength + angleScore
////    }
////
////    return totalSignScores
////}
////
////
////func calculatePlanetInHouseScores(birthChart: BirthChart, date: Date, ascDeclination: Double, mcDeclination: Double, planetsInHouses: [Int: [String]]) -> [Int: Double] {
////    let planetPowerScores = getTotalPowerScoresForPlanets(birthChart: birthChart, date: date, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
////
////    var planetInHouseScores: [Int: Double] = [:]
////
////    for (house, celestialObjects) in planetsInHouses {
////        var totalScore = 0.0
////        for planet in celestialObjects {
////            if let score = planetPowerScores[planet] {
////                totalScore += score
////            }
////        }
////        planetInHouseScores[house] = totalScore
////    }
////
////    return planetInHouseScores
////}
////
////func calculateHouseStrengths(birthChart: BirthChart, date: Date, ascDeclination: Double, mcDeclination: Double, houseCusps: [String], interceptedSigns: [String], planetsInHouses: [Int: [String]]) -> [Int: Double] {
////    let unoccupiedSignStrengths = calculateUnoccupiedSignStrengths(birthChart: birthChart, date: date, ascDeclination: ascDeclination, mcDeclination: mcDeclination, houseCusps: houseCusps, interceptedSigns: interceptedSigns)
////    let totalPowerScores = getTotalPowerScoresForPlanets(birthChart: birthChart, date: date, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
////    let anglePowerScores = getTotalPowerScoresForAngles(birthChart: birthChart, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
////
////    var houseStrengths: [Int: Double] = [:]
////
////    for (houseIndex, sign) in houseCusps.enumerated() {
////        let houseNumber = houseIndex + 1
////        var houseStrength = unoccupiedSignStrengths[sign] ?? 0.0
////
////        if let interceptedSignStrength = interceptedSigns.first(where: { $0 == sign }).flatMap({ unoccupiedSignStrengths[$0] }) {
////            houseStrength += interceptedSignStrength
////        }
////
////        if let planetsInHouse = planetsInHouses[houseNumber] {
////            let planetsStrength = planetsInHouse.compactMap({ totalPowerScores[$0] }).reduce(0.0, +)
////            houseStrength += planetsStrength
////        }
////
////        if houseNumber == 1, let ascendantStrength = anglePowerScores["ascendant"] {
////            houseStrength += ascendantStrength
////        }
////
////        if houseNumber == 10, let midheavenStrength = anglePowerScores["midheaven"] {
////            houseStrength += midheavenStrength
////        }
////
////        houseStrengths[houseNumber] = houseStrength
////    }
////
////    return houseStrengths
////}
////
////
////
////func getPositiveNegativeAspectScores(birthChart: BirthChart, date: Date) -> [String: (angels: [String], demons: [String])] {
////    let allAspects = getAllNatalAspects(birthChart: birthChart, date: date)
////    var aspectScores: [String: (angels: [String], demons: [String])] = [:]
////
////    for aspect in allAspects {
////        let planet1 = aspect.planet1
////        let planet2 = aspect.planet2
////        let kind = aspect.kind
////        let orb = aspect.orb
////        let planet1House = aspect.planet1House
////        let planet2House = aspect.planet2House
////        let isPlanet1Luminary = (planet1 == .planet(.sun) || planet1 == .planet(.moon) || planet1 == .planet(.mercury))
////        let isPlanet2Luminary = (planet2 == .planet(.sun) || planet2 == .planet(.moon) || planet2 == .planet(.mercury))
////
////        if let planet1House = planet1House, let planet2House = planet2House {
////            // Calculate the assigned and actual orb values for the aspect
////            let assignedOrb = getOrbCategory(for: planet1House, planet2House: planet2House, aspectKind: kind, isPlanet1Luminary: isPlanet1Luminary, isPlanet2Luminary: isPlanet2Luminary)
////            let actualOrb = orb
////
////            // Calculate the aspect score for the aspect
////            let aspectScore = (assignedOrb - abs(actualOrb))
////
////            // Only update the aspectScores if the aspect score is greater than or equal to 0
////            if aspectScore > 0 {
////                // Update positiveScore for planet1
////                if aspectScores[planet1.keyName] != nil {
////                    aspectScores[planet1.keyName]?.angels.append(planet2.keyName)
////                } else {
////                    aspectScores[planet1.keyName] = (angels: [planet2.keyName], demons: [])
////                }
////
////                // Update positiveScore for planet2
////                if aspectScores[planet2.keyName] != nil {
////                    aspectScores[planet2.keyName]?.angels.append(planet1.keyName)
////                } else {
////                    aspectScores[planet2.keyName] = (angels: [planet1.keyName], demons: [])
////                }
////            } else {
////                // Update negativeScore for planet1
////                if aspectScores[planet1.keyName] != nil {
////                    aspectScores[planet1.keyName]?.demons.append(planet2.keyName)
////                } else {
////                    aspectScores[planet1.keyName] = (angels: [], demons: [planet2.keyName])
////                }
////
////                // Update negativeScore for planet2
////                if aspectScores[planet2.keyName] != nil {
////                    aspectScores[planet2.keyName]?.demons.append(planet1.keyName)
////                } else {
////                    aspectScores[planet2.keyName] = (angels: [], demons: [planet1.keyName])
////                }
////            }
////        }
////    }
////
////    return aspectScores
////}
