//
//  34.swift
//  AstroLogic
//
//  Created by Errick Williams on 7/13/23.
//

import Foundation
import SwiftEphemeris

var chart: Chart?



func getTotalPowerScoresForPlanets(chart: Chart)  -> [(String, Double)]  {
    let aspectScores = chart.getAllCelestialAspectScores(chart.planets)
    let houseScores = chart.getHouseScoreForPlanets(chart.planets)
    let cuspScores = chart.getAllCuspAspectScoresForPlanets()
    let parallelScores = chart.getAllParallelAspectScores(chart.planets)
    let parallelScores2 = chart.getAllParallelAspects(chart.planets)
    let parallelAngleScores = chart.allParallelCuspAspectScores(chart.planets)
  //  print("angle scores for parallels to planets: \(parallelAngleScores)")
//
//    let angleAspectsScores = getTotalPowerScoresForAngles(birthChart: birthChart, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
//    print("angleScores: \(angleAspectsScores)")

    // Combine the scores for all aspects
    var combinedScores: [String: Double] = [:]
   
    // Add aspect scores to combined scores
    for (planet, score) in aspectScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
 //       print("Combined Planets \(combinedScores)")
    }

    // Add house scores to combined scores
    for (planet, score) in houseScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
 //       print("House Scores Planets \(combinedScores)")
    }

    // Add cusp aspect scores to combined scores
    for (planet, score) in cuspScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
      //  print("Combined Planets \(combinedScores)")
    }

    // Add parallel aspect scores to combined scores
    for (planet, score) in parallelScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
       // print("Combined Planets \(combinedScores)")
    }

    // Add parallel aspect scores to angles to combined scores
    for (planet, score) in parallelAngleScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
       // print("Combined Planets \(combinedScores)")
    }

    // Add angle scores to combined scores
//    for (angle, score) in angleAspectsScores {
//        combinedScores[angle] = (combinedScores[angle] ?? 0) + score
//      //  print("Combined Planets \(combinedScores)")
//    }

    // Sort the planets in descending order of their power scores
    let sortedPlanets = combinedScores.sorted(by: { $0.value > $1.value })

  //  print("Sorted Planets \(sortedPlanets)")
    return sortedPlanets
}


func getTotalPowerScoresForPlanets2(chart: Chart)  -> [String: Double]  {
    let aspectScores = chart.getAllCelestialAspectScores(chart.planets)
    let houseScores = chart.getHouseScoreForPlanets(chart.planets)
    let cuspScores = chart.getAllCuspAspectScoresForPlanets()
    let parallelScores = chart.getAllParallelAspectScores(chart.planets)
    let parallelAngleScores = chart.allParallelCuspAspectScores(chart.planets)
    
    houseScores.forEach { (key: CelestialObject, score: Double) in
        _ = aspectScores[key] ?? Double.nan
        // continue with your code
            // Your code to process the aspectScore goes here
        }
    

        
    
    
    // Combine the scores for all aspects
    var combinedScores: [String: Double] = [:]
    
    // Add aspect scores to combined scores
    for (planet, score) in aspectScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
    }
    
    // Add house scores to combined scores
    for (planet, score) in houseScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
    }
    
    // Add cusp aspect scores to combined scores
    for (planet, score) in cuspScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
    }
    
    // Add parallel aspect scores to combined scores
    for (planet, score) in parallelScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
    }
    
    for (planet, score) in parallelAngleScores {
        combinedScores[planet.keyName] = (combinedScores[planet.keyName] ?? 0) + score
    }
    
    // Sort the planets in descending order of their power scores
    let sortedPlanets = combinedScores.sorted(by: { $0.value > $1.value })
    
    // Print the combined scores for each planet in order from most power to least
    for (_, _) in sortedPlanets {
//            print(" the correct one \(planet.formatted): \(score)")
    }
    return combinedScores
}
