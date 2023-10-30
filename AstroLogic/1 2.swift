////
////  1.swift
////  AstroLogic
////
////  Created by Errick Williams on 7/12/23.
////
//
//import Foundation
//import SwiftEphemeris
//
//
//
//func getTotalPowerScoresForPlanets(chart: Chart)   {
//    
//
//    let aspectScores = chart.getAllCelestialAspectScores()
//    let houseScores = chart.getHouseScoreForPlanets()
//    let cuspScores = chart.getAllCuspAspectScores()
//    let parallelScores = chart.getAllParallelAspectScores()
//    let parallelAspectScoresToAngles = chart.allParallelCuspAspectScores()
//    
//    houseScores.forEach { (key: CelestialObject, score: Double) in
//        let aspectScore = aspectScores[key] ?? Double.nan
//        // continue with your code
//    }
//
//        
//    
//    
//    // Combine the scores for all aspects
//    var combinedScores: [String: Double] = [:]
//    
//    // Add aspect scores to combined scores
//    for (planet, score) in aspectScores {
//        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
//    }
//    
//    // Add house scores to combined scores
//    for (planet, score) in houseScores {
//        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
//    }
//    
//    // Add cusp aspect scores to combined scores
//    for (planet, score) in cuspScores {
//        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
//    }
//    
//    // Add parallel aspect scores to combined scores
//    for (planet, score) in parallelScores {
//        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
//    }
//    
//    for (planet, score) in parallelAspectScoresToAngles {
//        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
//    }
//    
//    // Sort the planets in descending order of their power scores
//    let sortedPlanets = combinedScores.sorted(by: { $0.value > $1.value })
//    
//    // Print the combined scores for each planet in order from most power to least
//    for (_, _) in sortedPlanets {
////            print(" the correct one \(planet.formatted): \(score)")
//    }
//    print(combinedScores)
//}
//
//    
