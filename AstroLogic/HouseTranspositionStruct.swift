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
    let houseNumbers: [Int: String] = [
        1: "first",
        2: "second",
        3: "third",
        4: "fourth",
        5: "fifth",
        6: "sixth",
        7: "seventh",
        8: "eighth",
        9: "ninth",
        10: "tenth",
        11: "eleventh",
        12: "twelfth"
    ]

}


func generateAstrologicalInterpretation(planet: String, houseNumber: Int, templateNumber: Int, userA: String, userB: String) -> String {
    let data = AstrologicalData()
    
    guard let planetPhrase = data.planetKeyPhrases[planet],
          let virtueTerm = data.planetVirtueTerms[planet],
          let houseWords = data.houseKeyWords[houseNumber],
            let houseNum = data.houseNumbers[houseNumber] else {
        return "Invalid input"
    }
    
    switch templateNumber {
    case 1:
        return "\(userA)'s \(planet) resides in \(userB)’s \(houseNum) house, signifying that \(userA) infuses a substantial amount of \(planetPhrase) into \(userB)'s \(houseWords). This alignment suggests that \(userA) plays a pivotal role in enlightening \(userB) about the importance of \(virtueTerm)"

    case 2:
        return "\(userA)'s \(planet) falls in \(userB)'s \(houseNum) house. As long as these two are together in any way, you will bring \(planetPhrase) to bear upon \(userB)'s \(houseWords). In \(userA)'s soul contract, you are teaching User B about how much simple \(virtueTerm) can help them reach their full potential in that specific area of life."
    case 3:
        return "As we compare these two charts, we see that \(userA)'s \(planet) falls in \(userB)'s \(houseNum) house. As long as these two souls are linked in any way, \(userA)'s \(planetPhrase) is going to trigger lots of development in \(userB)'s \(houseWords). Why did the universe bring \(userA) and \(userB) together? Part of the answer is that the \(virtueTerm) that \(userA) brings to bear on \(userB) in that area will empower experiences that challenge and strengthen \(userB) in that precise area."
    case 4:
        return "Where does \(userA)'s \(planet) land in \(userB)'s chart? The answer is that it falls in \(userB)'s \(houseNum) house. That means that \(userA)'s \(planetPhrase) will have a meteoric impact on \(userB)'s \(houseWords) – and that’s an area of life where the \(virtueTerm) that \(userA) brings to daily life, supplies a missing piece of \(userB)'s puzzle."
    case 5:
        return "If we superimpose \(userA)'s chart over \(userB)'s, \(userA)'s \(planet) falls in \(userB)'s \(houseNum) house. As these two energy bodies interact, \(userA) triggers a very specific evolutionary reaction in \(userB). Even without thinking about it, \(userA)'s will focus \(planetPhrase) on \(userB)'s \(houseWords). Deep down, \(userA) signed up to demonstrate how much \(virtueTerm) can help \(userB) thrive in this area of life."
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
            let randomTemplateNumber = Int.random(in: 1...5) // Randomly choose a template number between 1 and 5
            let interpretation = generateAstrologicalInterpretation(planet: celestialBody.keyName, houseNumber: houseNumber, templateNumber: randomTemplateNumber, userA: userA, userB: userB)
            interpretations.append(interpretation)
        }
    }

    return interpretations
}
