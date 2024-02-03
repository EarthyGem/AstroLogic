//
//  newChart.swift
//  AstroLogic
//
//  Created by Errick Williams on 2/3/24.
//

import Foundation
import UIKit
import SwiftEphemeris
import UIKit
import SwiftEphemeris

struct PlanetModel {
    var name: String
    var signId: Int
    var sign: String
    var house: Int
    var fullDegree: Double
    var isRetrograde: Bool
}

struct HouseModel {
    var houseId: Int
    var signId: Int
    var sign: String
    var startDegree: Double
    var endDegree: Double
}

class AstrologicalChartView: UIView {
    var planetPositions: [CelestialObject: CGFloat] = [:]
    var chartCake: ChartCake?
    let spacing: CGFloat = 10.0 // Adjust the spacing as needed
    let planetIconSize: CGFloat = 20.0 // Adjust the icon size as needed
    let deviceDiameter: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) // Adjust based on your device or canvas size
    let angleSpacing: Double = 10.0 // Adjust the values as needed
    let _planetIconSize: CGFloat = 20.0 // Replace 20.0 with your desired icon size
    let _planetSignIconSize: CGFloat = 20.0 // Replace 20.0 with your desired icon size

    let chartMargin: CGFloat = 10.0
    let planetSpacing: Double = 20.0

    let wheelChartContent: WheelChartContent!
    let _spacing: CGFloat = 10.0 // Adjust the spacing as needed

    let _deviceDiameter: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) // Adjust based on your device or canvas size
    let _angleSpacing: Double = 10.0 // Adjust the values as needed


    let _chartMargin: CGFloat = 10.0
    let _planetSpacing: Double = 20.0   
    let fixedHouseAngle: [Int: Double] = [
        1: 180.0,
        2: 150.0,
        3: 120.0,
        4: 90.0,
        5: 60.0,
        6: 30.0,
        7: 0.0,
        8: 330.0,
        9: 300.0,
        10: 270.0,
        11: 240.0,
        12: 210.0
    ]

    init(frame: CGRect, chartCake: ChartCake, wheelChartContent: WheelChartContent) {
        self.chartCake = chartCake
        self.wheelChartContent = wheelChartContent
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext(), let chartCake = chartCake else { return }

        // Call createInnerPlanetSigns to draw the inner planets

        drawOuterZodiacSigns(in: context, rect: rect, chartCake: chartCake)
        let houseData: [(houseId: Int, signId: Int, sign: String, startDegree: Double, endDegree: Double)] = [(1,6,"Virgo",68.0,98.0)]


            let planetData: [(name: String, signId: Int, sign: String, house: Int, fullDegree: Double, isRetrograde: Bool)] = [
            ("Sun", 1, chartCake.natal.sun.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.sun).number, chartCake.natal.sun.longitude, false),
            ("Moon", 2, chartCake.natal.moon.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.moon).number, chartCake.natal.moon.longitude, false),
            ("mercury", 3, chartCake.natal.mercury.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.mercury).number, chartCake.natal.mercury.longitude, false),
            ("venus", 4, chartCake.natal.venus.sign.keyName.lowercased(), chartCake.natal.houseCusps.house(of: chartCake.natal.venus).number, chartCake.natal.venus.longitude, false),
            ("Mars", 5, chartCake.natal.mars.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.mars).number, chartCake.natal.mars.longitude, false),
            ("Jupiter", 6, chartCake.natal.jupiter.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.jupiter).number, chartCake.natal.jupiter.longitude, false),
            ("Saturn", 7, chartCake.natal.saturn.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.saturn).number, chartCake.natal.saturn.longitude, false),
            ("Uranus", 8, chartCake.natal.uranus.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.uranus).number, chartCake.natal.uranus.longitude, false),
            ("Neptune", 9, chartCake.natal.neptune.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.neptune).number, chartCake.natal.neptune.longitude, false),
            ("Pluto", 10, chartCake.natal.uranus.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.uranus).number, chartCake.natal.uranus.longitude, false),
            // Add data for other planets here
        ]

        // Create an empty array to store the PlanetModel instances
        var planets: [PlanetModel] = []

        // Loop through the planet data and create PlanetModel instances
        for data in planetData {
            let planet = PlanetModel(
                name: data.name.lowercased(),
                signId: data.signId,
                sign: data.sign,
                house: data.house,
                fullDegree: data.fullDegree,
                isRetrograde: data.isRetrograde
            )
            planets.append(planet)
        //    print(planets)
        }

        var houses: [HouseModel] = []

        // Loop through the planet data and create PlanetModel instances 
        for data2 in houseData {
            let house = HouseModel(
                houseId: data2.houseId,
                signId: data2.signId,
                sign: data2.sign,
                startDegree: data2.startDegree,
                endDegree: data2.endDegree

            )
            houses.append(house)
          //  print(houses)
        }



        createInnerPlanetSigns(context: context, wheelChartContent: wheelChartContent)
        // Now, the 'planets' array contains instances of PlanetModel for all the planets
    }

    func createInnerPlanetSigns(context: CGContext, wheelChartContent: WheelChartContent) {
        // UIColor for black with blending
        let planetIconColor = UIColor.black
        let planetSignIconColor = UIColor.gray
        let planetDegreesColor = UIColor.black
        let planetMinutesColor = UIColor.black

        let planetDegreesFont = UIFont(name: "Arial", size: 13)!
        let planetMinutesFont = UIFont(name: "Arial", size: 13)!

        var planetIconDiameter = deviceDiameter - chartMargin - (planetIconSize * 2) - spacing

        let x1 = planetIconDiameter / 2 * CGFloat(cos(degreesToRadians(0)))
        let x2 = planetIconDiameter / 2 * CGFloat(cos(degreesToRadians(30)))
        let y1 = planetIconDiameter / 2 * CGFloat(sin(degreesToRadians(0)))
        let y2 = planetIconDiameter / 2 * CGFloat(sin(degreesToRadians(30)))

        let houseSpacing = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))

        let houseGroups = wheelChartContent.chart.planets.filter { !$0.name.contains("Fortune") }.sorted(by: { $0.house < $1.house }).reduce(into: [Int: [PlanetModel]]()) { dict, planet in
            dict[planet.house, default: []].append(planet)
        }

        for (house, houseGroup) in houseGroups {
            let planets = houseGroup.count
            let scaleSpacing: CGFloat = planets > 3 ? (CGFloat(houseSpacing) / (CGFloat(planets) + 0.65) / _planetIconSize).rounded() : 1
            let planetSpacing = planets >= 3 ? floor(30 / Double(planets)) : 8
            let angleSpacing = planets >= 3 ? round(Double(planetSpacing) / 2) : 8

            let orderedPlanets = getOrderedPlanets(angleSpacing: angleSpacing, planetSpacing: planetSpacing, houseGroup: houseGroup, wheelChartContent: wheelChartContent)

            for (angle, planet) in orderedPlanets {
                let planetDegrees = "\(Int(planet.fullDegree))°".split(separator: " ")

                // Planet Icon
                let currentPlanetIconSize = _planetIconSize * scaleSpacing
                planetIconDiameter = _deviceDiameter - _chartMargin - (currentPlanetIconSize * 2) - _spacing

                let planetX = CGFloat(planetIconDiameter / 2 * cos(angle.degreesToRadians)).rounded()
                let planetY = CGFloat(planetIconDiameter / 2 * sin(angle.degreesToRadians)).rounded()
                let planetCenterX = planetX + (bounds.width / 2)
                let planetCenterY = planetY + (bounds.height / 2)

                // Draw planet icon
                if let planetIcon = UIImage(named: planet.name) {
                    let planetScaleX = currentPlanetIconSize / planetIcon.size.width
                    let planetScaleY = currentPlanetIconSize / planetIcon.size.height
                    let planetScale = min(planetScaleX, planetScaleY)
                    let planetIconRect = CGRect(x: planetCenterX - (currentPlanetIconSize / 2), y: planetCenterY - (currentPlanetIconSize / 2), width: currentPlanetIconSize, height: currentPlanetIconSize)
                    planetIcon.draw(in: planetIconRect)
                }

                // Planet Degrees Text
                let planetDegreesText = planetDegrees[0]
                let planetDegreesSize = (planetDegreesText as NSString).size(withAttributes: [NSAttributedString.Key.font: planetDegreesFont])
                let planetDegreesDiameter = planetIconDiameter - currentPlanetIconSize - ((planetDegreesSize.height + _spacing) * 2)

                let planetDegreesX = CGFloat(planetDegreesDiameter / 2 * cos(angle.degreesToRadians)).rounded()
                let planetDegreesY = CGFloat(planetDegreesDiameter / 2 * sin(angle.degreesToRadians)).rounded()
                let planetDegreesCenterX = planetDegreesX + (bounds.width / 2)
                let planetDegreesCenterY = planetDegreesY + (bounds.height / 2)

                // Draw planet degrees text
                let planetDegreesRect = CGRect(x: planetDegreesCenterX - planetDegreesSize.width / 2, y: planetDegreesCenterY - planetDegreesSize.height / 2, width: planetDegreesSize.width, height: planetDegreesSize.height)
                if let planetDegreesText = planetDegreesText as? NSString {
                    planetDegreesText.draw(in: planetDegreesRect, withAttributes: [NSAttributedString.Key.font: planetDegreesFont, NSAttributedString.Key.foregroundColor: UIColor.black])
                }


                // Planet Sign Icon
                let currentPlanetSignIconSize = _planetSignIconSize * scaleSpacing
                let planetSignIconDiameter = planetDegreesDiameter - ((planetDegreesSize.height + currentPlanetSignIconSize) * 2)

                let planetSignX = CGFloat(planetSignIconDiameter / 2 * cos(angle.degreesToRadians)).rounded()
                let planetSignY = CGFloat(planetSignIconDiameter / 2 * sin(angle.degreesToRadians)).rounded()
                let planetSignCenterX = planetSignX + (bounds.width / 2)
                let planetSignCenterY = planetSignY + (bounds.height / 2)

                // Draw planet sign icon
                // You'll need to load and draw the appropriate sign icon here
                // Use planetSignCenterX and planetSignCenterY to position the icon
            }
        }
    }

    // Add the getOrderedPlanets function here

    private func drawOuterZodiacSigns(in context: CGContext, rect: CGRect, chartCake: ChartCake) {
        let houses = chartCake.natal.houseCusps.houses

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius: CGFloat = min(rect.width, rect.height) / 2 * 0.8 // Adjust radius as needed

        houses.forEach { house in
            let angle = CGFloat(house.value) // Adjust angle calculation as needed
            let signName = house.sign

            // Calculate positions for text and sign icon
            let textPosition = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let signIconPosition = CGPoint(x: textPosition.x + 20, y: textPosition.y) // Example offset, adjust as needed

            // Draw the sign name
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.white
            ]
            let attributedString = NSAttributedString(string: signName.keyName, attributes: attributes)
            attributedString.draw(at: textPosition)

            // Draw the sign icon
            if let signImage = UIImage(named: "\(signName).png") { // Ensure you have images named after signs
                let imageSize = CGSize(width: 30, height: 30) // Adjust size as needed
                let imageRect = CGRect(x: signIconPosition.x - imageSize.width / 2, y: signIconPosition.y - imageSize.height, width: imageSize.width, height: imageSize.height)
                signImage.draw(in: imageRect)
            }
        }
    }

    func getOrderedPlanets(angleSpacing: Double, planetSpacing: Double, houseGroup: [PlanetModel], wheelChartContent: WheelChartContent) -> [Double: PlanetModel] {
        var orderedPlanets = [Double: PlanetModel]()
        let planetsCount = houseGroup.count

        guard let house = chartCake?.natal.houseCusps.houses.first(where: { $0.number == houseGroup.first?.signId }) else {
            return orderedPlanets
        }

        let orderedHouseGroup = houseGroup.sorted(by: { $0.fullDegree > $1.fullDegree })
        var isLeftToRight: Bool? = nil

        for planet in orderedHouseGroup {
            var currentAngle = 0.0
            if planetsCount < 3 {
                let centeredAngle = abs(Double(house.degree - house.degree)) / 3
                if abs(planet.fullDegree - Double(house.degree)) <= centeredAngle {
                    isLeftToRight = true
                    currentAngle = fixedHouseAngle[house.number]! - angleSpacing
                } else if abs(Double(house.degree) - planet.fullDegree) <= centeredAngle {
                    isLeftToRight = false
                    currentAngle = fixedHouseAngle[house.number]! + angleSpacing - 30
                } else {
                    isLeftToRight = false
                    currentAngle = fixedHouseAngle[house.number]! - 15
                }

                while orderedPlanets.keys.contains(currentAngle) {
                    currentAngle += isLeftToRight! ? Double(-planetSpacing) : planetSpacing
                }
            } else {
                let midAngle = abs(Double(house.degree - house.degree)) / 2
                if isLeftToRight == nil || planetsCount > 3 {
                    isLeftToRight = abs(planet.fullDegree - Double(house.degree)) <= midAngle
                }
                currentAngle = isLeftToRight! ? fixedHouseAngle[house.number]! - angleSpacing : fixedHouseAngle[house.number]! + angleSpacing - 30

                while orderedPlanets.keys.contains(currentAngle) {
                    currentAngle += isLeftToRight! ? Double(-planetSpacing) : planetSpacing
                }
            }

            orderedPlanets[currentAngle] = planet
        }

        return orderedPlanets
    }

    private func drawPlanetDetails(in context: CGContext, planet: PlanetModel, position: CGPoint) {
        guard let font = UIFont(name: "Helvetica", size: 12) else { return }

        // Assuming you have methods or properties to get these values
        let degreeText = "\(Int(planet.fullDegree))°"
        let signImageName = planet.sign // Adjust based on how you manage sign images
        let minutesText = "\(Int((planet.fullDegree - floor(planet.fullDegree)) * 60))'"

        // Draw degree text
        let degreeAttributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.white]
        let degreeAttributedString = NSAttributedString(string: degreeText, attributes: degreeAttributes)
        let degreeSize = degreeAttributedString.size()
        degreeAttributedString.draw(at: CGPoint(x: position.x - degreeSize.width / 2, y: position.y - 30)) // Adjust positioning as needed

        // Draw sign symbol
        if let signImage = UIImage(named: signImageName) {
            let signImageSize = CGSize(width: 20, height: 20) // Adjust as needed
            signImage.draw(in: CGRect(x: position.x - signImageSize.width / 2, y: position.y, width: signImageSize.width, height: signImageSize.height))
        }

        // Draw minutes text
        let minuteAttributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.white]
        let minuteAttributedString = NSAttributedString(string: minutesText, attributes: minuteAttributes)
        let minuteSize = minuteAttributedString.size()
        minuteAttributedString.draw(at: CGPoint(x: position.x - minuteSize.width / 2, y: position.y + 30)) // Adjust positioning as needed
    }

    func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180
    }
}

extension Double {
    // Convert degrees to radians
    var degreesToRadians: CGFloat { return self * .pi / 180 }
}
