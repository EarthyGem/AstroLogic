//
//  HouseTranspositionStruct.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/31/23.
//

import Foundation
import SwiftEphemeris


struct AstrologicalData {
    let planetKeyPhrases: [String: String] = [
        "Sun": "personal empowerment",
        "Moon": "nurturing energy",
        "Rising": "style",
        "Mercury": "insight and intelligence",
        "Venus": "courtesy and diplomacy",
        "Mars": "sheer force",
        "Jupiter": "daring and boldness",
        "Saturn": "rigorous thinking",
        "Uranus": "innovation",
        "Neptune": "sheer inspiration",
        "Pluto": "pointed honesty and truthfulness"
    ]

    let planetVirtueTerms: [String: String] = [
        "Sun": "sheer liveliness",
        "Moon": "sensitivity",
        "Rising": "skillful self-presentation",
        "Mercury": "verbal skill",
        "Venus": "love",
        "Mars": "assertiveness",
        "Jupiter": "self-confidence",
        "Saturn": "self-discipline",
        "Uranus": "wildness and even genius",
        "Neptune": "inspiration",
        "Pluto": "penetrating honesty"
    ]

    let houseKeyWords: [Int: String] = [
        1: "ability to lead your own life",
        2: "ability to feel self-confident",
        3: "way of speaking",
        4: "domestic and family affairs",
        5: "sense of fun",
        6: "relationship with responsibility and duty",
        7: "ability to trust another person",
        8: "capacity to deal honestly with own psychic wounds",
        9: "openness to new ideas and perspectives",
        10: "career or sense of mission in the world",
        11: "circle of friends and associates",
        12: "relationship with own soul"
    ]
}


func generateAstrologicalInterpretation(planet: String, houseNumber: Int, templateNumber: Int, userA: String, userB: String) -> String {
    let data = AstrologicalData()
    
    guard let planetPhrase = data.planetKeyPhrases[planet],
          let virtueTerm = data.planetVirtueTerms[planet],
          let houseWords = data.houseKeyWords[houseNumber] else {
        return "Invalid input"
    }
    
    switch templateNumber {
    case 1:
        return "\(userA)'s \(planet) falls in \(userB)’s \(houseNumber)th house. That tells us that \(userA) brings a big dose of \(planetPhrase) into \(userB)'s \(houseWords). \(userA) is teaching \(userB) about how a little \(virtueTerm) can empower their soul."
    case 2:
        return "Your \(planet) falls in User B’s \(houseNumber)th house. As long as you are together in any way, you will bring \(planetPhrase) to bear upon User B’s \(houseWords). In your soul contract, you are teaching User B about how much simple \(virtueTerm) can help them reach their full potential in that specific area of life."
    case 3:
        return "As we compare your two charts, we see that your \(planet) falls in User B’s \(houseNumber)th house. As long as you are linked in any way, your \(planetPhrase) is going to trigger lots of development in User B’s \(houseWords). Why did the universe bring you together? Part of the answer is that the \(virtueTerm) that you bring to bear on User B in that area will help to empower them to have the experiences that challenge and strengthen them in that precise area."
    case 4:
        return "Where does your \(planet) land in User B’s chart? The answer is that it falls in User B’s \(houseNumber)th house. That means that your \(planetPhrase) will have a meteoric impact on User B’s \(houseWords) – and that’s an area of life where the \(virtueTerm) that you bring into their daily life supplies a missing piece of their puzzle."
    case 5:
        return "If we superimpose your chart over User B’s, your \(planet) falls in User B’s \(houseNumber)th house. As your energy bodies interact, you trigger a very specific evolutionary reaction in them. Even without thinking about it, you will focus \(planetPhrase) on User B’s \(houseWords). Deep down, you signed up to teach User B about how much your \(virtueTerm) can help them reach their full human potential."
    default:
        return "Invalid template number"
    }
}


// Assuming CelestialObject has a property 'name' that gives the planet's name
public func generateInterpretations(houseCusps: HouseCusps, bodies: [Coordinate], userA: String, userB: String) -> [String] {
    let planetsInHousesDict = chartCake!.planetsInHouses(using: houseCusps, with: bodies)
    var interpretations = [String]()

    for (houseNumber, celestialBodies) in planetsInHousesDict {
        for celestialBody in celestialBodies {
            let interpretation = generateAstrologicalInterpretation(planet: celestialBody.keyName, houseNumber: houseNumber, templateNumber: 1, userA: userA, userB: userB) // choose template number as needed
            interpretations.append(interpretation)
        }
    }

    return interpretations
}
