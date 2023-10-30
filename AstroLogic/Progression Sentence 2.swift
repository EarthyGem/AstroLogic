//
//  Progression Sentence.swift
//  AstroLogic
//
//  Created by Errick Williams on 7/16/23.
//

import Foundation
import SwiftEphemeris


var aspectingPlanet: Planet?
var aspectingPlanetUrges: String?
var aspectingPlanetHouseEffect: String?
var aspectingEntryDate: Date?
var aspectingExactDate: Date?
var aspectingLeaveDate: Date?
var aspectedPlanet: Planet?
var aspectedPlanetHouseEffect: String?
var aspectKind: Kind?
var aspectKeyword: String?
var natureOfAspect: String?
//chart?.quality(of: aspectKind)
var progressedHousePositions = [Cusp]()
var progressedHouseMatters = [Cusp : String]()
var natalPositions = [Cusp]()
var natalHouseMatters = [Cusp : String]()
var aspectingPlanetPower: Double?
var aspectingPlanetHarmony: Double?
var aspectingPlanetDiscord: Double?
var aspectedAtBirth = [Bool : Kind]()
var progressionSentence: String?

