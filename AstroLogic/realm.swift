////
////  realm.swift
////  AstroLogic
////
////  Created by Errick Williams on 9/17/23.
////
//
//import Foundation
//import DGCharts
//import SwiftEphemeris
//
//enum Realm: String {
//    case Order, Relationship, Creativity, Change, Action
//}
//
//// This is a hypothetical mapping and you'd need to adjust it according to your specifications
//let planetToRealm: [CelestialObject: Realm] = [
//    Planet.sun.celestialObject: .Order,
//    Planet.moon.celestialObject: .Relationship,
//    Planet.mercury.celestialObject: .Creativity,
//    Planet.venus.celestialObject: .Relationship,
//    Planet.mars.celestialObject: .Action,
//    Planet.jupiter.celestialObject: .Action,
//    Planet.saturn.celestialObject: .Order,
//    Planet.uranus.celestialObject: .Change,
//    Planet.neptune.celestialObject: .Creativity,
//    Planet.pluto.celestialObject: .Change
//]
//func getRealmScores(from celestialScores: [CelestialObject: Double]) -> [Realm: Double] {
//    var realmScores = [Realm: Double]()
//
//    for (celestialObject, score) in celestialScores {
//        if let realm = planetToRealm[celestialObject] {
//            realmScores[realm] = (realmScores[realm] ?? 0.0) + score
//        }
//    }
//
//    return realmScores
//}
//
//
//
//func generatePieChartData(from realmScores: [Realm: Double]) -> PieChartData {
//    var dataEntries: [PieChartDataEntry] = []
//
//    for (realm, score) in realmScores {
//        let entry = PieChartDataEntry(value: score, label: realm.rawValue)
//        dataEntries.append(entry)
//    }
//
//    let dataSet = PieChartDataSet(entries: dataEntries, label: "Realms")
//    // Customize dataSet (colors, values, etc.) if needed here
//    return PieChartData(dataSet: dataSet)
//}
//
//// Assuming you have a PieChartView instance named `pieChartView`:
//pieChartView.data = generatePieChartData(from: realmScores)
