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
    let planetIconSize: CGFloat = 15.0 // Adjust the icon size as needed
    let deviceDiameter: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) // Adjust based on your device or canvas size
    let angleSpacing: Double = 10.0 // Adjust the values as needed
    let _planetIconSize: CGFloat = 15.0 // Replace 20.0 with your desired icon size
    let _planetSignIconSize: CGFloat = 12.0 // Replace 20.0 with your desired icon size

    let chartMargin: CGFloat = 10.0
    let planetSpacing: Double = 10.0

    let wheelChartContent: WheelChartContent!
    let _spacing: CGFloat = 10.0 // Adjust the spacing as needed

    let _deviceDiameter: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) // Adjust based on your device or canvas size
    let _angleSpacing: Double = 10.0 // Adjust the values as needed


    let _chartMargin: CGFloat = 10.0
    let _planetSpacing: Double = 10.0
    

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

      //  drawOuterZodiacSigns(in: context, rect: rect, chartCake: chartCake)
        var houseData: [(houseId: Int, signId: Int, sign: String, startDegree: Double, endDegree: Double)] = [
            (1, chartCake.natal.houseCusps.first.sign.signId, chartCake.natal.houseCusps.first.sign.keyName, 0, 30),
            (2, chartCake.natal.houseCusps.second.sign.signId, chartCake.natal.houseCusps.second.sign.keyName, 30, 60),
            (3, chartCake.natal.houseCusps.third.sign.signId, chartCake.natal.houseCusps.third.sign.keyName, 60, 90),
            (4, chartCake.natal.houseCusps.fourth.sign.signId, chartCake.natal.houseCusps.fourth.sign.keyName, 90, 120),
            (5, chartCake.natal.houseCusps.fifth.sign.signId, chartCake.natal.houseCusps.fifth.sign.keyName, 120, 150),
            (6, chartCake.natal.houseCusps.sixth.sign.signId, chartCake.natal.houseCusps.sixth.sign.keyName, 150, 180),
            (7, chartCake.natal.houseCusps.seventh.sign.signId, chartCake.natal.houseCusps.seventh.sign.keyName, 180, 210),
            (8, chartCake.natal.houseCusps.eighth.sign.signId, chartCake.natal.houseCusps.eighth.sign.keyName, 210, 240),
            (9, chartCake.natal.houseCusps.ninth.sign.signId, chartCake.natal.houseCusps.ninth.sign.keyName, 240, 270),
            (10, chartCake.natal.houseCusps.tenth.sign.signId, chartCake.natal.houseCusps.tenth.sign.keyName, 270, 300),
            (11, chartCake.natal.houseCusps.eleventh.sign.signId, chartCake.natal.houseCusps.eleventh.sign.keyName, 300, 330),
            (12, chartCake.natal.houseCusps.twelfth.sign.signId, chartCake.natal.houseCusps.twelfth.sign.keyName, 330, 360)
        ]



            let planetData: [(name: String, signId: Int, sign: String, house: Int, fullDegree: Double, isRetrograde: Bool)] = [
            ("Sun", chartCake.natal.sun.sign.signId, chartCake.natal.sun.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.sun).number, chartCake.natal.sun.degree, false),
            ("Moon", chartCake.natal.moon.sign.signId, chartCake.natal.moon.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.moon).number, chartCake.natal.moon.degree, false),
            ("mercury", chartCake.natal.mercury.sign.signId, chartCake.natal.mercury.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.mercury).number, chartCake.natal.mercury.degree, false),
            ("venus", chartCake.natal.venus.sign.signId, chartCake.natal.venus.sign.keyName.lowercased(), chartCake.natal.houseCusps.house(of: chartCake.natal.venus).number, chartCake.natal.venus.degree, false),
            ("Mars", chartCake.natal.mars.sign.signId, chartCake.natal.mars.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.mars).number, chartCake.natal.mars.degree, false),
            ("Jupiter", chartCake.natal.jupiter.sign.signId, chartCake.natal.jupiter.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.jupiter).number, chartCake.natal.jupiter.degree, false),
            ("Saturn", chartCake.natal.saturn.sign.signId, chartCake.natal.saturn.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.saturn).number, chartCake.natal.saturn.degree, false),
            ("Uranus", chartCake.natal.uranus.sign.signId, chartCake.natal.uranus.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.uranus).number, chartCake.natal.uranus.degree, false),
            ("Neptune", chartCake.natal.neptune.sign.signId
             , chartCake.natal.neptune.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.neptune).number, chartCake.natal.neptune.degree, false),
            ("Pluto", chartCake.natal.pluto.sign.signId, chartCake.natal.pluto.sign.keyName, chartCake.natal.houseCusps.house(of: chartCake.natal.pluto).number, chartCake.natal.pluto.degree, false),
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


        drawZodiacCircle(context: context)
        drawHouseLines(context: context)
        createInnerPlanetSigns(context: context, wheelChartContent: wheelChartContent)
        // Now, the 'planets' array contains instances of PlanetModel for all the planets
    }
    
    private func drawZodiacCircle(context: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.45
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.3)
        context.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        context.strokePath()

        let innerRadius1 = radius * 0.34
        let innerRadius2 = radius * 0.41
        context.addEllipse(in: CGRect(x: center.x - innerRadius1, y: center.y - innerRadius1, width: innerRadius1 * 2, height: innerRadius1 * 2))
        context.strokePath()

        context.addEllipse(in: CGRect(x: center.x - innerRadius2, y: center.y - innerRadius2, width: innerRadius2 * 2, height: innerRadius2 * 2))
        context.strokePath()

        // Draw the image in the middle of the zodiac circle
        let lilaImage = UIImage(named: "Lila")
        let imageRadius = radius * 0.2
        let imageSize = CGSize(width: imageRadius * 1.5, height: imageRadius * 1.5)
        let imageOrigin = CGPoint(x: center.x - imageSize.width / 2, y: center.y - imageSize.height / 2)
        let imageFrame = CGRect(origin: imageOrigin, size: imageSize)
        lilaImage?.draw(in: imageFrame)
    }
    
    func adjustedFontSize(for size: CGFloat) -> CGFloat {
        let screenBounds = UIScreen.main.bounds
        let adjustmentFactor = screenBounds.width / 375  // 375 is the width of the iPhone 6/7/8
        return size * adjustmentFactor
    }

    private func drawHouseLines(context: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.45
        let houseDegrees = getHousesDegree()
        let houseMinutes = getHousesMinute()
        let houseDistances = getHousesDistances()
        let houseCuspSignNames = getHouseNames()

        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.5)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        
        let equalHouseAngle: CGFloat = 30
        var accumulatedAngle: CGFloat = 0
        
        for index in 0..<12 {
            let angle = 2 * .pi - ((accumulatedAngle + equalHouseAngle) * .pi / 180) + .pi
            let startX = center.x + cos(angle) * (0.34 * radius)
            let startY = center.y + sin(angle) * (0.34 * radius)
            
            // Line doesn't intersect with the innermost circle, draw full line
            let endX = center.x + cos(angle) * radius
            let endY = center.y + sin(angle) * radius
                
            context.move(to: CGPoint(x: startX, y: startY))
            context.addLine(to: CGPoint(x: endX, y: endY))
            context.strokePath()
            let houseDegree = houseDegrees[(index + 2) % 12]
            let houseMinute = houseMinutes[(index + 2) % 12]
           
      
                let glyphLabelAngleOffset: CGFloat = 0.8
           
        
            let degreeLabelAngleOffset: CGFloat
                let minuteLabelAngleOffset: CGFloat

                let adjustedIndex = (index + 1) % 12

                if index == 10 { // House 1
                    degreeLabelAngleOffset = 0.11
                    minuteLabelAngleOffset = -0.08
                } else if adjustedIndex < 5 { // Houses 2-6
                    degreeLabelAngleOffset = 0.11
                    minuteLabelAngleOffset = -0.08
                } else { // Houses 7-12
                    degreeLabelAngleOffset = -0.08
                    minuteLabelAngleOffset = 0.08
                }
//            print("House \(index + 1): Degree \(Int(houseDegrees[index]))°, Minute \(Int(houseMinutes[index]))'")


            
          
            // Add the planet number label
            let houseNumberLabel = UILabel()
            houseNumberLabel.textColor = .white
            houseNumberLabel.textAlignment = .center
            houseNumberLabel.text = "\((index + 1) % 12 + 1)"
            houseNumberLabel.font = UIFont.systemFont(ofSize: 10)
            houseNumberLabel.sizeToFit()
            let labelRadius = (0.34 + 0.41) / 2 * radius
            let labelAngle = angle - equalHouseAngle / 2 * .pi / 180
            let labelX = center.x + cos(labelAngle) * labelRadius - houseNumberLabel.bounds.width / 2
            let labelY = center.y + sin(labelAngle) * labelRadius - houseNumberLabel.bounds.height / 2
            houseNumberLabel.frame.origin = CGPoint(x: labelX, y: labelY)
            addSubview(houseNumberLabel)
            
            
            // Add the house degree label
            let houseDegreeLabel = UILabel()
            houseDegreeLabel.textColor = .white
            houseDegreeLabel.textAlignment = .center
            houseDegreeLabel.text = "\(Int(houseDegree))°"

            houseDegreeLabel.font = UIFont.systemFont(ofSize: 10)
            houseDegreeLabel.sizeToFit()
            let labelRadius1 = 1.07 * radius
            let labelAngle1 = angle - equalHouseAngle * .pi / 180 + degreeLabelAngleOffset
            let labelX1 = center.x + cos(labelAngle1) * labelRadius1 - houseDegreeLabel.bounds.width / 2
            let labelY1 = center.y + sin(labelAngle1) * labelRadius1 - houseDegreeLabel.bounds.height / 2
            houseDegreeLabel.frame.origin = CGPoint(x: labelX1, y: labelY1)
            addSubview(houseDegreeLabel)
     
            
            let signIndex = Int((accumulatedAngle + equalHouseAngle / 2) / 30)
            let imageName = getHouseNames()[signIndex]
            guard let image = UIImage(named: imageName) else { continue }

            let imageSize = min(bounds.width, bounds.height) / 30
            let labelRadius2 = 1.07 * radius // Keep the same radius as the degree and minute labels
            let labelAngle2 = angle - equalHouseAngle / 2 * .pi / 180 + glyphLabelAngleOffset
            let labelX2 = center.x + cos(labelAngle2) * labelRadius2 - imageSize / 2
            let labelY2 = center.y + sin(labelAngle2) * labelRadius2 - imageSize / 2
            let imageRect = CGRect(x: labelX2, y: labelY2, width: imageSize, height: imageSize)
            image.draw(in: imageRect)
            
            // Add the house minute label
            let houseMinuteLabel = UILabel()
            houseMinuteLabel.textColor = .white
            houseMinuteLabel.textAlignment = .center
            houseMinuteLabel.text = "\(Int(houseMinute))'"

            houseMinuteLabel.font = UIFont.systemFont(ofSize: 8)
            houseMinuteLabel.sizeToFit()
            let labelRadius3 = 1.07 * radius
            let labelAngle3 = angle - equalHouseAngle * .pi / 180 + minuteLabelAngleOffset
            let labelX3 = center.x + cos(labelAngle3) * labelRadius3 - houseMinuteLabel.bounds.width / 2
            let labelY3 = center.y + sin(labelAngle3) * labelRadius3 - houseMinuteLabel.bounds.height / 2
            houseMinuteLabel.frame.origin = CGPoint(x: labelX3, y: labelY3)
            addSubview(houseMinuteLabel)
            
            accumulatedAngle += equalHouseAngle
        }
    }


    func createInnerPlanetSigns(context: CGContext, wheelChartContent: WheelChartContent) {
        // UIColor for black with blending
        let planetIconColor = UIColor.black
        let planetSignIconColor = UIColor.gray
        let planetDegreesColor = UIColor.white
        let planetMinutesColor = UIColor.white

        let planetDegreesFont = UIFont(name: "Arial", size: 10)!
        let planetMinutesFont = UIFont(name: "Arial", size: 8)!

        var planetIconDiameter = deviceDiameter - chartMargin - (planetIconSize * 2) - spacing

        let x1 = planetIconDiameter / 2 * CGFloat(cos(degreesToRadians(0)))
        let x2 = planetIconDiameter / 2 * CGFloat(cos(degreesToRadians(30)))
        let y1 = planetIconDiameter / 2 * CGFloat(sin(degreesToRadians(0)))
        let y2 = planetIconDiameter / 2 * CGFloat(sin(degreesToRadians(30)))

        let houseSpacing = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))

        let houseGroups = wheelChartContent.chart.planets.filter { !$0.name.contains("Fortune") }.sorted(by: { $0.house < $1.house }).reduce(into: [Int: [PlanetModel]]()) { dict, planet in
            dict[planet.house, default: []].append(planet)
        }

        for (_, houseGroup) in houseGroups {
            let planets = houseGroup.count
            let scaleSpacing: CGFloat = planets > 3 ? (CGFloat(houseSpacing) / (CGFloat(planets) + 0.65) / _planetIconSize).rounded() : 1
            let planetSpacing = planets >= 3 ? floor(30 / Double(planets)) : 8
            let angleSpacing = planets >= 3 ? round(Double(planetSpacing) / 2) : 8

            let orderedPlanets = getOrderedPlanets(angleSpacing: angleSpacing, planetSpacing: planetSpacing, houseGroup: houseGroup, wheelChartContent: wheelChartContent)

        
         //   let chartMargin: CGFloat = 100.0 // Example: margin around the chart within the view
          //  let planetIconSize: CGFloat = 20.0 // Example: size of each planet icon
          //  let spacing: CGFloat = 20.0 // Example: spacing between elements in the chart

            
            for (angle, planet) in orderedPlanets {
                
                let planetDegrees = "\(Int(planet.fullDegree))°".split(separator: " ")

                // Planet Icon
                let currentPlanetIconSize = _planetIconSize * scaleSpacing
                planetIconDiameter = _deviceDiameter - _chartMargin - (currentPlanetIconSize * 2) - _spacing - 20

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
                let planetDegreesDiameter = planetIconDiameter - ((planetDegreesSize.height + _spacing) * 2)

                let planetDegreesX = CGFloat(planetDegreesDiameter / 2 * cos(angle.degreesToRadians)).rounded()
                let planetDegreesY = CGFloat(planetDegreesDiameter / 2 * sin(angle.degreesToRadians)).rounded()
                let planetDegreesCenterX = planetDegreesX + (bounds.width / 2)
                let planetDegreesCenterY = planetDegreesY + (bounds.height / 2)

                // Draw planet degrees text
                let planetDegreesRect = CGRect(x: planetDegreesCenterX - planetDegreesSize.width / 2, y: planetDegreesCenterY - planetDegreesSize.height / 2, width: planetDegreesSize.width, height: planetDegreesSize.height)
                if let planetDegreesText = planetDegreesText as? NSString {
                    planetDegreesText.draw(in: planetDegreesRect, withAttributes: [NSAttributedString.Key.font: planetDegreesFont, NSAttributedString.Key.foregroundColor: UIColor.white])
                }
                // Planet Sign Icon
                let currentPlanetSignIconSize = _planetSignIconSize * scaleSpacing
                let planetSignIconDiameter = planetDegreesDiameter - ((planetDegreesSize.height + currentPlanetSignIconSize) * 2) + 10

                let planetSignX = CGFloat(planetSignIconDiameter / 2 * cos(angle.degreesToRadians)).rounded()
                let planetSignY = CGFloat(planetSignIconDiameter / 2 * sin(angle.degreesToRadians)).rounded()
                let planetSignCenterX = planetSignX + (bounds.width / 2)
                let planetSignCenterY = planetSignY + (bounds.height / 2)

                // Draw planet sign icon
                if let planetSignIcon = UIImage(named: planet.sign) { // Assuming your sign icons are named after the sign's name
                    let planetSignScaleX = currentPlanetSignIconSize / planetSignIcon.size.width
                    let planetSignScaleY = currentPlanetSignIconSize / planetSignIcon.size.height
                    let planetSignScale = min(planetSignScaleX, planetSignScaleY)
                    let planetSignIconRect = CGRect(x: planetSignCenterX - (currentPlanetSignIconSize / 2), y: planetSignCenterY - (currentPlanetSignIconSize / 2), width: currentPlanetSignIconSize, height: currentPlanetSignIconSize)
                    planetSignIcon.draw(in: planetSignIconRect)
                    

                   }

            }
        }
    }

    // Add the getOrderedPlanets function here

  

    func getOrderedPlanets(angleSpacing: Double, planetSpacing: Double, houseGroup: [PlanetModel], wheelChartContent: WheelChartContent) -> [Double: PlanetModel] {
        var orderedPlanets = [Double: PlanetModel]()

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

        guard let house = wheelChartContent.chart.houses.first(where: { $0.houseId == houseGroup.first?.house }) else {
            return orderedPlanets
        }

        let zodiacOrder = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]

           // Sort the planets within the house group first by zodiacal order, then by degree.
        var orderedHouseGroup = houseGroup.sorted {
            let signOrder1 = zodiacOrder.firstIndex(of: $0.sign) ?? 0
            let signOrder2 = zodiacOrder.firstIndex(of: $1.sign) ?? 0
            
            if signOrder1 == signOrder2 {
                // If they are in the same sign, sort by descending degree (higher degree to the left)
                return $0.fullDegree > $1.fullDegree
            } else {
                // If they are in different signs, sort by sign order
                return signOrder1 > signOrder2
            }
        }



        if wheelChartContent.signIntercepts.contains(where: { $0.house == houseGroup.first?.house }) {
            orderedHouseGroup = orderedHouseGroup.sorted { $0.signId > $1.signId }
        }

        var isLeftToRight: Bool? = nil
        for planet in orderedHouseGroup {
            var currentAngle: Double = 0.0
            let centeredAngle = (house.endDegree - house.startDegree) / 3.0
            let midAngle = (house.endDegree - house.startDegree) / 2.0

            if orderedHouseGroup.count < 3 {
                if abs(planet.fullDegree - house.startDegree) <= centeredAngle {
                    isLeftToRight = true
                    currentAngle = fixedHouseAngle[house.houseId]! - angleSpacing
                } else if abs(house.endDegree - planet.fullDegree) <= centeredAngle {
                    isLeftToRight = false
                    currentAngle = fixedHouseAngle[house.houseId]! + angleSpacing - 30.0
                } else {
                    isLeftToRight = false
                    currentAngle = fixedHouseAngle[house.houseId]! - 15.0
                }
            } else {
                if isLeftToRight == nil {
                    isLeftToRight = abs(planet.fullDegree - house.startDegree) <= midAngle
                }
                currentAngle = isLeftToRight! ? fixedHouseAngle[house.houseId]! - angleSpacing : fixedHouseAngle[house.houseId]! + angleSpacing - 30.0
            }

            while orderedPlanets.keys.contains(currentAngle) {
                currentAngle += isLeftToRight! ? -planetSpacing : planetSpacing
            }

            orderedPlanets[currentAngle] = planet
        }
        
        return orderedPlanets
    }

    func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180
    }
    private func getHouses() -> [CGFloat] {
        guard let chartCake = chartCake else {
            return [CGFloat]()
        }

        let houseCusps = chartCake.natal.houseCusps
        let first = houseCusps.first.value
        let second = houseCusps.second.value
        let third = houseCusps.third.value
        let fourth = houseCusps.fourth.value
        let fifth = houseCusps.fifth.value
        let sixth = houseCusps.sixth.value
        let seventh = houseCusps.seventh.value
        let eighth = houseCusps.eighth.value
        let ninth = houseCusps.ninth.value
        let tenth = houseCusps.tenth.value
        let eleventh = houseCusps.eleventh.value
        let twelfth = houseCusps.twelfth.value
//    print("House cusps: \(first), \(second), \(third), \(fourth), \(fifth), \(sixth), \(seventh), \(eighth), \(ninth), \(tenth), \(eleventh), \(twelfth)")

        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }

    private func getHousesDegree() -> [CGFloat] {
        guard let chartCake = chartCake else {
            return [CGFloat]()
        }

        let houseCusps = chartCake.natal.houseCusps
        let first = houseCusps.first.degree
        let second = houseCusps.second.degree
        let third = houseCusps.third.degree
        let fourth = houseCusps.fourth.degree
        let fifth = houseCusps.fifth.degree
        let sixth = houseCusps.sixth.degree
        let seventh = houseCusps.seventh.degree
        let eighth = houseCusps.eighth.degree
        let ninth = houseCusps.ninth.degree
        let tenth = houseCusps.tenth.degree
        let eleventh = houseCusps.eleventh.degree
        let twelfth = houseCusps.twelfth.degree

        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }

    private func getHousesMinute() -> [CGFloat] {
        guard let chartCake = chartCake else {
            return [CGFloat]()
        }

        let houseCusps = chartCake.natal.houseCusps
        let first = houseCusps.first.minute
        let second = houseCusps.second.minute
        let third = houseCusps.third.minute
        let fourth = houseCusps.fourth.minute
        let fifth = houseCusps.fifth.minute
        let sixth = houseCusps.sixth.minute
        let seventh = houseCusps.seventh.minute
        let eighth = houseCusps.eighth.minute
        let ninth = houseCusps.ninth.minute
        let tenth = houseCusps.tenth.minute
        let eleventh = houseCusps.eleventh.minute
        let twelfth = houseCusps.twelfth.minute

        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }

    private func getHouseNames() -> [String] {
        guard let chartCake = chartCake else {
            return [String]()
        }

        let houseCusps = chartCake.natal.houseCusps
        let first = houseCusps.first.sign.keyName
        let second = houseCusps.second.sign.keyName
        let third = houseCusps.third.sign.keyName
        let fourth = houseCusps.fourth.sign.keyName
        let fifth = houseCusps.fifth.sign.keyName
        let sixth = houseCusps.sixth.sign.keyName
        let seventh = houseCusps.seventh.sign.keyName
        let eighth = houseCusps.eighth.sign.keyName
        let ninth = houseCusps.ninth.sign.keyName
        let tenth = houseCusps.tenth.sign.keyName
        let eleventh = houseCusps.eleventh.sign.keyName
        let twelfth = houseCusps.twelfth.sign.keyName

        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    
    private func getHousesCuspLongitude() -> [CGFloat] {
        guard let chartCake = chartCake else {
            return [CGFloat]()
        }

        let houseCusps = chartCake.natal.houseCusps
        let first = houseCusps.first.value
        let second = houseCusps.second.value
        let third = houseCusps.third.value
        let fourth = houseCusps.fourth.value
        let fifth = houseCusps.fifth.value
        let sixth = houseCusps.sixth.value
        let seventh = houseCusps.seventh.value
        let eighth = houseCusps.eighth.value
        let ninth = houseCusps.ninth.value
        let tenth = houseCusps.tenth.value
        let eleventh = houseCusps.eleventh.value
        let twelfth = houseCusps.twelfth.value

        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }


    private func getHousesDistances() -> [CGFloat] {
        let houseCusps = getHouses()
        // print("House cusps: \(houseCusps)")

        var houseDistances: [CGFloat] = []

        for i in 0..<houseCusps.count {
            let nextIndex = (i + 1) % houseCusps.count
            let distance = (houseCusps[nextIndex] - houseCusps[i] + 360).truncatingRemainder(dividingBy: 360)
            houseDistances.append(distance)
            //   print("House \(i + 1) to \(nextIndex + 1) distance: \(distance)")

        }

        return houseDistances
    }
}

extension Double {
    // Convert degrees to radians
    var degreesToRadians: CGFloat { return self * .pi / 180 }
}
