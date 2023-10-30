//
//  Dignity.swift
//  AstroLogic
//
//  Created by Errick Williams on 7/13/23.
//

import Foundation
import SwiftEphemeris

func calculateDignityScore(chart: Chart) -> [CelestialObject: (harmony: Double, discord: Double)] {
    let mutualReceptions = getMutualReceptions(chart: chart)
    let planets = chart.planets
    
    let dignities = [
        chart.sun: [
            Zodiac.leo: "rulership",
            Zodiac.aries: "exaltation",
            Zodiac.sagittarius: "harmony",
            Zodiac.aquarius: "detriment",
            Zodiac.gemini: "inharmony",
            Zodiac.libra: "fall"
        ],
        chart.moon: [
            Zodiac.cancer: "rulership",
            Zodiac.taurus: "exaltation",
            Zodiac.pisces: "harmony",
            Zodiac.capricorn: "detriment",
            Zodiac.virgo: "inharmony",
            Zodiac.scorpio: "fall"
        ],
        chart.mercury: [
            Zodiac.virgo: "rulership",
            Zodiac.gemini: "rulership",
            Zodiac.aquarius: "exaltation",
            Zodiac.scorpio: "harmony",
            Zodiac.sagittarius: "detriment",
            Zodiac.pisces: "detriment",
            Zodiac.taurus: "inharmony",
            Zodiac.leo: "fall"
        ],
        chart.venus: [
            Zodiac.libra: "rulership",
            Zodiac.taurus: "rulership",
            Zodiac.pisces: "exaltation",
            Zodiac.aquarius: "harmony",
            Zodiac.aries: "detriment",
            Zodiac.scorpio: "detriment",
            Zodiac.leo: "inharmony",
            Zodiac.virgo: "fall"
        ],
        chart.mars: [
            Zodiac.aries: "rulership",
            Zodiac.scorpio: "rulership",
            Zodiac.capricorn: "exaltation",
            Zodiac.leo: "harmony",
            Zodiac.libra: "detriment",
            Zodiac.taurus: "detriment",
            Zodiac.aquarius: "inharmony",
            Zodiac.cancer: "fall"
        ],
        chart.jupiter: [
            Zodiac.sagittarius: "rulership",
            Zodiac.pisces: "rulership",
            Zodiac.cancer: "exaltation",
            Zodiac.taurus: "harmony",
            Zodiac.gemini: "detriment",
            Zodiac.virgo: "detriment",
            Zodiac.scorpio: "inharmony",
            Zodiac.capricorn: "fall"
        ],
        chart.saturn: [
            Zodiac.capricorn: "rulership",
            Zodiac.aquarius: "rulership",
            Zodiac.libra: "exaltation",
            Zodiac.virgo: "harmony",
            Zodiac.cancer: "detriment",
            Zodiac.leo: "detriment",
            Zodiac.pisces: "inharmony",
            Zodiac.aries: "fall"
        ],
        chart.uranus: [
            Zodiac.aquarius: "rulership",
            Zodiac.gemini: "exaltation",
            Zodiac.libra: "harmony",
            Zodiac.leo: "detriment",
            Zodiac.aries: "inharmony",
            Zodiac.sagittarius: "fall"
        ],
        chart.neptune: [
            Zodiac.pisces: "rulership",
            Zodiac.sagittarius: "exaltation",
            Zodiac.cancer: "harmony",
            Zodiac.virgo: "detriment",
            Zodiac.capricorn: "inharmony",
            Zodiac.gemini: "fall"
            
        ],
        chart.pluto: [
            Zodiac.scorpio: "rulership",
            Zodiac.leo: "exaltation",
            Zodiac.aries: "harmony",
            Zodiac.taurus: "detriment",
            Zodiac.libra: "inharmony",
            Zodiac.aquarius: "fall"
        ]
    ]
        
    var scores: [CelestialObject: (harmony: Double, discord: Double)] = [:]
        
    for planet in planets {
        let planetSign = planet.sign
        let planetDignity = dignities[planet]
        var harmonyScore = 0.0
        var discordScore = 0.0
            
        // Check if planet is involved in mutual reception and add 5 to its score if it is
        for (planet1, planet2) in mutualReceptions {
               if planet.body == planet1 || planet.body == planet2 {
                   harmonyScore += 5
               }
           }
            
        if let dignity = planetDignity![planetSign] {
            switch dignity {
            case "rulership":
                harmonyScore += 2
            case "exaltation":
                harmonyScore += 3
            case "harmony":
                harmonyScore += 1
            case "detriment":
                discordScore += 2
            case "inharmony":
                discordScore += 1
            case "fall":
                discordScore += 3
            default:
                break
            }
        }
            
        scores[planet.body] = (harmony: max(0, harmonyScore), discord: max(0, discordScore))

    }
        
    return scores
}

//
//  7.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 3/26/23.
//





//There are three things which may influence a planet’s harmony or discord: 1. Signs. 2. The nature of the planets making the aspect. 3. The nature of the aspect between two planets.

var mutRec = 5
var degExalted = 4
var degFall = -4
var exalted = 3
var fall = -3
var home = 2
var detriment = -2
var harmony = 1
var inHarmony = -1



func getMutualReceptions(chart: Chart) -> [(CelestialObject, CelestialObject)] {
    let planets = [chart.sun, chart.moon, chart.mercury, chart.venus, chart.mars, chart.jupiter, chart.saturn, chart.uranus, chart.neptune, chart.pluto]
    var mutualReceptions: [(CelestialObject, CelestialObject)] = []
    
    let rulerships = [
        chart.sun: [Zodiac.leo],
        chart.moon: [Zodiac.cancer],
        chart.mercury: [Zodiac.gemini, Zodiac.virgo],
        chart.venus: [Zodiac.taurus, Zodiac.libra],
        chart.mars: [Zodiac.aries, Zodiac.scorpio],
        chart.jupiter: [Zodiac.sagittarius, Zodiac.pisces],
        chart.saturn: [Zodiac.capricorn, Zodiac.aquarius],
        chart.uranus: [Zodiac.aquarius],
        chart.neptune: [Zodiac.pisces],
        chart.pluto: [Zodiac.scorpio]
    ]
    
    let exaltations = [
        chart.sun: Zodiac.aries,
        chart.moon: Zodiac.taurus,
        chart.mercury: Zodiac.aquarius,
        chart.venus: Zodiac.pisces,
        chart.mars: Zodiac.capricorn,
        chart.jupiter: Zodiac.cancer,
        chart.saturn: Zodiac.libra,
        chart.uranus: Zodiac.gemini,
        chart.neptune: Zodiac.cancer,
        chart.pluto: Zodiac.leo
    ]
    
    for planet1 in planets {
          for planet2 in planets {
              if planet1 == planet2 || mutualReceptions.contains(where: { ($0 == planet2.body && $1 == planet1.body) }) {
                  continue
              }
              
              let planet1Sign = planet1.sign
              let planet2Sign = planet2.sign
              
              let planet1InRulershipOrExaltationOfPlanet2 = (rulerships[planet2]?.contains(planet1Sign) ?? false) || (exaltations[planet2] == planet1Sign)
              let planet2InRulershipOrExaltationOfPlanet1 = (rulerships[planet1]?.contains(planet2Sign) ?? false) || (exaltations[planet1] == planet2Sign)
              
              if planet1InRulershipOrExaltationOfPlanet2 && planet2InRulershipOrExaltationOfPlanet1 {
                            // Add the mutual reception to the list
                            mutualReceptions.append((planet1.body, planet2.body))
                        }
                    }
                }
                
                return mutualReceptions
            }
