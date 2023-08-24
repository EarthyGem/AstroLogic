//
//  SynastryFlipBiWheel.swift
//  AstroLogic
//
//  Created by Errick Williams on 8/23/23.
//

import Foundation
import UIKit
import SwiftEphemeris


class FlipSynastryBiWheelChartView: UIView {
    var natalChart: ChartCake!
    var selectedChart: ChartCake!
 
    
    var planetPositions: [CelestialObject: CGFloat] = [:]
    var synastryPlanetPositions: [CelestialObject: CGFloat] = [:]
    
    
    
init(frame: CGRect, natalChart: ChartCake, selectedChart: ChartCake) {
        self.natalChart = selectedChart
        self.selectedChart = natalChart
        super.init(frame: frame)
        setupGestureRecognizers()
        updateBirthChart()
    updateSynastryChart()
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    private var pinchGesture: UIPinchGestureRecognizer!
    private var panGesture: UIPanGestureRecognizer!
    private var currentScale: CGFloat = 1.0
    private var lastLocation: CGPoint = .zero
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = min(bounds.width, bounds.height) / 2
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    
    
    private func setupGestureRecognizers() {
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        addGestureRecognizer(pinchGesture)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began {
            currentScale = gestureRecognizer.scale
        }
        
        let minScale: CGFloat = 0.1
        let maxScale: CGFloat = 3.0
        
        var newScale = currentScale * gestureRecognizer.scale
        newScale = min(newScale, maxScale)
        newScale = max(newScale, minScale)
        
        let scaleTransform = CGAffineTransform(scaleX: newScale, y: newScale)
        transform = scaleTransform
        
        currentScale = gestureRecognizer.scale
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self.superview)
        switch gestureRecognizer.state {
        case .began:
            lastLocation = self.center
        case .changed:
            let center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
            self.center = center
        default:
            break
        }
    }
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Draw the zodiac circle, houses, and planet symbols
        drawZodiacCircle(context: context)
        drawHouseLines(context: context)
        drawPlanetSymbols(context: context)
        drawTransitZodiacCircle(context: context)
        drawTransitPlanetSymbols(context: context)
        
    }
    
    private func drawZodiacCircle(context: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.45
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.5)
        context.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        context.strokePath()
        
        let innerRadius1 = radius * 0.21
        let innerRadius2 = radius * 0.28
        context.addEllipse(in: CGRect(x: center.x - innerRadius1, y: center.y - innerRadius1, width: innerRadius1 * 2, height: innerRadius1 * 2))
        context.strokePath()
        
        context.addEllipse(in: CGRect(x: center.x - innerRadius2, y: center.y - innerRadius2, width: innerRadius2 * 2, height: innerRadius2 * 2))
        context.strokePath()
    }
    
    private func drawHouseLines(context: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.45
        let houseDegrees = getHousesDegree()
        let houseMinutes = getHousesMinute()

        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.5)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        
        let equalHouseAngle: CGFloat = 30
        var accumulatedAngle: CGFloat = 0
        
        for index in 0..<12 {
            let angle = 2 * .pi - ((accumulatedAngle + equalHouseAngle) * .pi / 180) + .pi
            let startX = center.x + cos(angle) * (0.21 * radius)
            let startY = center.y + sin(angle) * (0.21 * radius)
            
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
            houseNumberLabel.font = UIFont.systemFont(ofSize: 9)
            houseNumberLabel.sizeToFit()
            let labelRadius = (0.21 + 0.28) / 2 * radius
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

private func drawTransitZodiacCircle(context: CGContext) {
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    let radius = min(bounds.width, bounds.height) * 0.30
    context.setStrokeColor(UIColor.white.cgColor)
    context.setLineWidth(0.5)
    context.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
    context.strokePath()
    
 
}



    private func getHouses1() -> [CGFloat] {
        
        let first = natalChart!.natal.houseCusps.first.value
        let second = natalChart!.natal.houseCusps.second.value
        let third = natalChart!.natal.houseCusps.third.value
        let fourth = natalChart!.natal.houseCusps.fourth.value
        let fifth = natalChart!.natal.houseCusps.fifth.value
        let sixth = natalChart!.natal.houseCusps.sixth.value
        let seventh = natalChart!.natal.houseCusps.seventh.value
        let eighth = natalChart!.natal.houseCusps.eighth.value
        let ninth = natalChart!.natal.houseCusps.ninth.value
        let tenth = natalChart!.natal.houseCusps.tenth.value
        let eleventh = natalChart!.natal.houseCusps.eleventh.value
        let twelfth = natalChart!.natal.houseCusps.twelfth.value
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    private func getHousesDegree() -> [CGFloat] {
    
        let first = natalChart!.natal.houseCusps.first.degree
        let second = natalChart!.natal.houseCusps.second.degree
        let third = natalChart!.natal.houseCusps.third.degree
        let fourth = natalChart!.natal.houseCusps.fourth.degree
        let fifth = natalChart!.natal.houseCusps.fifth.degree
        let sixth = natalChart!.natal.houseCusps.sixth.degree
        let seventh = natalChart!.natal.houseCusps.seventh.degree
        let eighth = natalChart!.natal.houseCusps.eighth.degree
        let ninth = natalChart!.natal.houseCusps.ninth.degree
        let tenth = natalChart!.natal.houseCusps.tenth.degree
        let eleventh = natalChart!.natal.houseCusps.eleventh.degree
        let twelfth = natalChart!.natal.houseCusps.twelfth.degree
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    
    private func getHousesMinute() -> [CGFloat] {
        
        let first = natalChart!.natal.houseCusps.first.minute
        let second = natalChart!.natal.houseCusps.second.minute
        let third = natalChart!.natal.houseCusps.third.minute
        let fourth = natalChart!.natal.houseCusps.fourth.minute
        let fifth = natalChart!.natal.houseCusps.fifth.minute
        let sixth = natalChart!.natal.houseCusps.sixth.minute
        let seventh = natalChart!.natal.houseCusps.seventh.minute
        let eighth = natalChart!.natal.houseCusps.eighth.minute
        let ninth = natalChart!.natal.houseCusps.ninth.minute
        let tenth = natalChart!.natal.houseCusps.tenth.minute
        let eleventh = natalChart!.natal.houseCusps.eleventh.minute
        let twelfth = natalChart!.natal.houseCusps.twelfth.minute
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    
    private func getHouseNames() -> [String] {
        
        let first = natalChart!.natal.houseCusps.first.sign.keyName
        let second = natalChart!.natal.houseCusps.second.sign.keyName
        let third = natalChart!.natal.houseCusps.third.sign.keyName
        let fourth = natalChart!.natal.houseCusps.fourth.sign.keyName
        let fifth = natalChart!.natal.houseCusps.fifth.sign.keyName
        let sixth = natalChart!.natal.houseCusps.sixth.sign.keyName
        let seventh = natalChart!.natal.houseCusps.seventh.sign.keyName
        let eighth = natalChart!.natal.houseCusps.eighth.sign.keyName
        let ninth = natalChart!.natal.houseCusps.ninth.sign.keyName
        let tenth = natalChart!.natal.houseCusps.tenth.sign.keyName
        let eleventh = natalChart!.natal.houseCusps.eleventh.sign.keyName
        let twelfth = natalChart!.natal.houseCusps.twelfth.sign.keyName
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    
    private func getHouses2() -> [CGFloat] {
        let houseCusps = getHouses1()
        
        var houseDistances: [CGFloat] = []
        
        for i in 0..<houseCusps.count {
            let nextIndex = (i + 1) % houseCusps.count
            let distance = (houseCusps[nextIndex] - houseCusps[i] + 360).truncatingRemainder(dividingBy: 360)
            houseDistances.append(distance)
        }
        
        return houseDistances
    }
    
    
    private func drawPlanetSymbols(context: CGContext) {
        let planetSymbols: [(planet: CelestialObject, imageName: String)] = [
            (.planet(.sun), "sun"),
            (.planet(.moon), "moon"),
            (.planet(.mercury), "mercury"),
            (.planet(.venus), "venus"),
            (.planet(.mars), "mars"),
            (.planet(.jupiter), "jupiter"),
            (.planet(.saturn), "saturn"),
            (.planet(.uranus), "uranus"),
            (.planet(.neptune), "neptune"),
            (.planet(.pluto), "pluto"),
            (.lunarNode(.meanSouthNode), "s.node")
          
        ]
        
        let planetDegree: [(planet: CelestialObject, degree: String)] = [
            (.planet(.sun), "\(Int(natalChart!.natal.sun.degree))°"),
            (.planet(.moon), "\(Int(natalChart!.natal.moon.degree))°"),
            (.planet(.mercury), "\(Int(natalChart!.natal.mercury.degree))°"),
            (.planet(.venus), "\(Int(natalChart!.natal.venus.degree))°"),
            (.planet(.mars), "\(Int(natalChart!.natal.mars.degree))°"),
            (.planet(.jupiter), "\(Int(natalChart!.natal.jupiter.degree))°"),
            (.planet(.saturn), "\(Int(natalChart!.natal.saturn.degree))°"),
            (.planet(.uranus), "\(Int(natalChart!.natal.uranus.degree))°"),
            (.planet(.neptune), "\(Int(natalChart!.natal.neptune.degree))°"),
            (.planet(.pluto), "\(Int(natalChart!.natal.pluto.degree))°"),
            (.lunarNode(.meanSouthNode), "\(Int(natalChart!.natal.southNode.degree))°")
          
        ]
        
        let planetSignSymbols: [(planet: CelestialObject, imageName: String)] = [
            (.planet(.sun), natalChart!.natal.sun.sign.keyName),
            (.planet(.moon), natalChart!.natal.moon.sign.keyName),
            (.planet(.mercury), natalChart!.natal.mercury.sign.keyName),
            (.planet(.venus), natalChart!.natal.venus.sign.keyName),
            (.planet(.mars), natalChart!.natal.mars.sign.keyName),
            (.planet(.jupiter), natalChart!.natal.jupiter.sign.keyName),
            (.planet(.saturn), natalChart!.natal.saturn.sign.keyName),
            (.planet(.uranus), natalChart!.natal.uranus.sign.keyName),
            (.planet(.neptune), natalChart!.natal.neptune.sign.keyName),
            (.planet(.pluto), natalChart!.natal.pluto.sign.keyName),
            (.lunarNode(.meanSouthNode), natalChart!.natal.southNode.sign.keyName)
            
        ]
        
        
        let planetMinute: [(planet: CelestialObject, minute: String)] = [
            (.planet(.sun), "\(Int(natalChart!.natal.sun.minute))°"),
            (.planet(.moon), "\(Int(natalChart!.natal.moon.minute))°"),
            (.planet(.mercury), "\(Int(natalChart!.natal.mercury.minute))°"),
            (.planet(.venus), "\(Int(natalChart!.natal.venus.minute))°"),
            (.planet(.mars), "\(Int(natalChart!.natal.mars.minute))°"),
            (.planet(.jupiter), "\(Int(natalChart!.natal.jupiter.minute))°"),
            (.planet(.saturn), "\(Int(natalChart!.natal.saturn.minute))°"),
            (.planet(.uranus), "\(Int(natalChart!.natal.uranus.minute))°"),
            (.planet(.neptune), "\(Int(natalChart!.natal.neptune.minute))°"),
            (.planet(.pluto), "\(Int(natalChart!.natal.pluto.minute))°"),
            (.lunarNode(.meanSouthNode), "\(Int(natalChart!.natal.southNode.minute))°")
        
        ]
        
        
        let sortedPlanetSymbols = planetSymbols.sorted { (symbol1, symbol2) -> Bool in
            if let position1 = planetPositions[symbol1.planet], let position2 = planetPositions[symbol2.planet] {
                return position1 < position2
            }
            return false
        }
        
        let sortedPlanetDegree = planetDegree.sorted { (degree1, degree2) -> Bool in
            if let position1 = planetPositions[degree1.planet], let position2 = planetPositions[degree2.planet] {
                return position1 < position2
            }
            return false
        }

        let sortedPlanetSignSymbol = planetSignSymbols.sorted { (sign1, sign2) -> Bool in
            if let position1 = planetPositions[sign1.planet], let position2 = planetPositions[sign2.planet] {
                return position1 < position2
            }
            return false
        }

        let sortedPlanetMinute = planetMinute.sorted { (minute1, minute2) -> Bool in
            if let position1 = planetPositions[minute1.planet], let position2 = planetPositions[minute2.planet] {
                return position1 < position2
            }
            return false
        }

        
        let minSymbolDistance: CGFloat = 20 // Adjust this value to change the minimum distance
        var lastSymbolCenter: CGPoint? = nil
        var lastCelestialObject: CelestialObject? = nil
        
        for (_, (celestialObject, imageName)) in sortedPlanetSymbols.enumerated() {
            guard let position = planetPositions[celestialObject] else { continue }
            let angle = 2 * .pi - (position * .pi / 180) + .pi
            let radius = min(bounds.width, bounds.height) * 0.31 - 18
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            var centerX = center.x + cos(angle) * radius
            var centerY = center.y + sin(angle) * radius
            
            if let lastCenter = lastSymbolCenter, let lastPosition = lastCelestialObject.flatMap({ planetPositions[$0] }) {
                let distance = hypot(centerX - lastCenter.x, centerY - lastCenter.y)
                
                if distance < minSymbolDistance {
                    if position > lastPosition {
                        let angleAdjustment = -minSymbolDistance / radius
                        let adjustedAngle = angle + angleAdjustment
                        centerX = center.x + cos(adjustedAngle) * radius
                        centerY = center.y + sin(adjustedAngle) * radius
                    } else {
                        let angleAdjustment = minSymbolDistance / radius
                        let adjustedAngle = angle + angleAdjustment
                        centerX = center.x + cos(adjustedAngle) * radius
                        centerY = center.y + sin(adjustedAngle) * radius
                    }
                    
                    
                }
            }
            
            lastSymbolCenter = CGPoint(x: centerX, y: centerY)
            lastCelestialObject = celestialObject
            
            
            
            let symbolSize = min(bounds.width, bounds.height) / 25
            let symbolRect = CGRect(x: centerX - symbolSize / 2, y: centerY - symbolSize / 2, width: symbolSize, height: symbolSize)
            
            for (_, (celestialObject, degree)) in sortedPlanetDegree.enumerated() {
                guard let position = planetPositions[celestialObject] else { continue }

                let degreeLabel = UILabel()
                degreeLabel.textColor = .white
                degreeLabel.textAlignment = .center
                degreeLabel.text = degree
                degreeLabel.font = UIFont.systemFont(ofSize: 10)
                degreeLabel.sizeToFit()
                degreeLabel.textColor = .white
                let degreeLabelRadius =  min(bounds.width, bounds.height) * 0.30 - 32

                let degreeLabelAngle = 2 * .pi - (position * .pi / 180) + .pi
                let degreeLabelX = center.x + cos(degreeLabelAngle) * degreeLabelRadius
                let degreeLabelY = center.y + sin(degreeLabelAngle) * degreeLabelRadius
                degreeLabel.center = CGPoint(x: degreeLabelX, y: degreeLabelY)
                addSubview(degreeLabel)
                
            }

            for (_, (celestialObject, imageName)) in sortedPlanetSignSymbol.enumerated() {
                guard let position = planetPositions[celestialObject] else { continue }
                let angle = 2 * .pi - (position * .pi / 180) + .pi
                let radius = min(bounds.width, bounds.height) * 0.30 - 49
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let centerX = center.x + cos(angle) * radius
                let centerY = center.y + sin(angle) * radius
                
                let symbolSize = min(bounds.width, bounds.height) / 40
                let symbolImageView = UIImageView(image: UIImage(named: imageName))
                symbolImageView.contentMode = .scaleAspectFit
                symbolImageView.frame = CGRect(x: 0, y: 0, width: symbolSize, height: symbolSize)
                symbolImageView.center = CGPoint(x: centerX, y: centerY - symbolSize / 2 )
                addSubview(symbolImageView)
            }

            for (_, (celestialObject, minute)) in sortedPlanetMinute.enumerated() {
                guard let position = planetPositions[celestialObject] else { continue }

                // Add the planet minute label
                let minuteLabel = UILabel()
                minuteLabel.textColor = .white
                minuteLabel.textAlignment = .center
                minuteLabel.text = minute // Generate a random minute value
                minuteLabel.font = UIFont.systemFont(ofSize: 8)
                minuteLabel.sizeToFit()
                
                let minuteLabelRadius = min(bounds.width, bounds.height) * 0.34 - 62
                let minuteLabelAngle = 2 * .pi - (position * .pi / 180) + .pi
                let minuteLabelX = center.x + cos(minuteLabelAngle) * minuteLabelRadius
                let minuteLabelY = center.y + sin(minuteLabelAngle) * minuteLabelRadius
                
                minuteLabel.center = CGPoint(x: minuteLabelX, y: minuteLabelY)
//                addSubview(minuteLabel)
            }

            
            if let image = UIImage(named: imageName) {
                image.draw(in: symbolRect)

            
            }
        }
    }
    

private func drawTransitPlanetSymbols(context: CGContext) {
    let planetSymbols: [(planet: CelestialObject, imageName: String)] = [
        (.planet(.sun), "sun"),
        (.planet(.moon), "moon"),
        (.planet(.mercury), "mercury"),
        (.planet(.venus), "venus"),
        (.planet(.mars), "mars"),
        (.planet(.jupiter), "jupiter"),
        (.planet(.saturn), "saturn"),
        (.planet(.uranus), "uranus"),
        (.planet(.neptune), "neptune"),
        (.planet(.pluto), "pluto"),
        (.lunarNode(.meanSouthNode), "s.node")
      
    ]
    
    let planetDegree: [(planet: CelestialObject, degree: String)] = [
        (.planet(.sun), "\(Int(selectedChart!.natal.sun.degree))°"),
        (.planet(.moon), "\(Int(selectedChart!.natal.moon.degree))°"),
        (.planet(.mercury), "\(Int(selectedChart!.natal.mercury.degree))°"),
        (.planet(.venus), "\(Int(selectedChart!.natal.venus.degree))°"),
        (.planet(.mars), "\(Int(selectedChart!.natal.mars.degree))°"),
        (.planet(.jupiter), "\(Int(selectedChart!.natal.jupiter.degree))°"),
        (.planet(.saturn), "\(Int(selectedChart!.natal.saturn.degree))°"),
        (.planet(.uranus), "\(Int(selectedChart!.natal.uranus.degree))°"),
        (.planet(.neptune), "\(Int(selectedChart!.natal.neptune.degree))°"),
        (.planet(.pluto), "\(Int(selectedChart!.natal.pluto.degree))°"),
        (.lunarNode(.meanSouthNode), "\(Int(selectedChart!.natal.southNode.degree))°")
      
    ]
    
    let planetSignSymbols: [(planet: CelestialObject, imageName: String)] = [
        (.planet(.sun), selectedChart!.natal.sun.sign.keyName),
        (.planet(.moon), selectedChart!.natal.moon.sign.keyName),
        (.planet(.mercury), selectedChart!.natal.mercury.sign.keyName),
        (.planet(.venus), selectedChart!.natal.venus.sign.keyName),
        (.planet(.mars), selectedChart!.natal.mars.sign.keyName),
        (.planet(.jupiter), selectedChart!.natal.jupiter.sign.keyName),
        (.planet(.saturn), selectedChart!.natal.saturn.sign.keyName),
        (.planet(.uranus), selectedChart!.natal.uranus.sign.keyName),
        (.planet(.neptune), selectedChart!.natal.neptune.sign.keyName),
        (.planet(.pluto), selectedChart!.natal.pluto.sign.keyName),
        (.lunarNode(.meanSouthNode), selectedChart!.natal.southNode.sign.keyName)
        
    ]
    
    
    let planetMinute: [(planet: CelestialObject, minute: String)] = [
        (.planet(.sun), "\(Int(selectedChart!.natal.sun.minute))°"),
        (.planet(.moon), "\(Int(selectedChart!.natal.moon.minute))°"),
        (.planet(.mercury), "\(Int(selectedChart!.natal.mercury.minute))°"),
        (.planet(.venus), "\(Int(selectedChart!.natal.venus.minute))°"),
        (.planet(.mars), "\(Int(selectedChart!.natal.mars.minute))°"),
        (.planet(.jupiter), "\(Int(selectedChart!.natal.jupiter.minute))°"),
        (.planet(.saturn), "\(Int(selectedChart!.natal.saturn.minute))°"),
        (.planet(.uranus), "\(Int(selectedChart!.natal.uranus.minute))°"),
        (.planet(.neptune), "\(Int(selectedChart!.natal.neptune.minute))°"),
        (.planet(.pluto), "\(Int(selectedChart!.natal.pluto.minute))°"),
        (.lunarNode(.meanSouthNode), "\(Int(selectedChart!.natal.southNode.minute))°")
    
    ]
    
    
    let sortedPlanetSymbols = planetSymbols.sorted { (symbol1, symbol2) -> Bool in
        if let position1 = synastryPlanetPositions[symbol1.planet], let position2 = synastryPlanetPositions[symbol2.planet] {
            return position1 < position2
        }
        return false
    }
    
    let sortedPlanetDegree = planetDegree.sorted { (degree1, degree2) -> Bool in
        if let position1 = synastryPlanetPositions[degree1.planet], let position2 = synastryPlanetPositions[degree2.planet] {
            return position1 < position2
        }
        return false
    }

    let sortedPlanetSignSymbol = planetSignSymbols.sorted { (sign1, sign2) -> Bool in
        if let position1 = synastryPlanetPositions[sign1.planet], let position2 = synastryPlanetPositions[sign2.planet] {
            return position1 < position2
        }
        return false
    }

    let sortedPlanetMinute = planetMinute.sorted { (minute1, minute2) -> Bool in
        if let position1 = synastryPlanetPositions[minute1.planet], let position2 = synastryPlanetPositions[minute2.planet] {
            return position1 < position2
        }
        return false
    }

    
    let minSymbolDistance: CGFloat = 20 // Adjust this value to change the minimum distance
    var lastSymbolCenter: CGPoint? = nil
    var lastCelestialObject: CelestialObject? = nil
    
    for (_, (celestialObject, imageName)) in sortedPlanetSymbols.enumerated() {
        guard let position = synastryPlanetPositions[celestialObject] else { continue }
        let angle = 2 * .pi - (position * .pi / 180) + .pi
        let radius = min(bounds.width, bounds.height) * 0.45 - 15
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var centerX = center.x + cos(angle) * radius
        var centerY = center.y + sin(angle) * radius
        
        if let lastCenter = lastSymbolCenter, let lastPosition = lastCelestialObject.flatMap({ synastryPlanetPositions[$0] }) {
            let distance = hypot(centerX - lastCenter.x, centerY - lastCenter.y)
            
            if distance < minSymbolDistance {
                if position > lastPosition {
                    let angleAdjustment = -minSymbolDistance / radius
                    let adjustedAngle = angle + angleAdjustment
                    centerX = center.x + cos(adjustedAngle) * radius
                    centerY = center.y + sin(adjustedAngle) * radius
                } else {
                    let angleAdjustment = minSymbolDistance / radius
                    let adjustedAngle = angle + angleAdjustment
                    centerX = center.x + cos(adjustedAngle) * radius
                    centerY = center.y + sin(adjustedAngle) * radius
                }
                
                
            }
        }
        
        lastSymbolCenter = CGPoint(x: centerX, y: centerY)
        lastCelestialObject = celestialObject
        
        
        
        let symbolSize = min(bounds.width, bounds.height) / 30
        let symbolRect = CGRect(x: centerX - symbolSize / 2, y: centerY - symbolSize / 2, width: symbolSize, height: symbolSize)
        
        for (_, (celestialObject, degree)) in sortedPlanetDegree.enumerated() {
            guard let position = synastryPlanetPositions[celestialObject] else { continue }

            let degreeLabel = UILabel()
            degreeLabel.textColor = .white
            degreeLabel.textAlignment = .center
            degreeLabel.text = degree
            degreeLabel.font = UIFont.systemFont(ofSize: 9)
            degreeLabel.sizeToFit()
            degreeLabel.textColor = .white
            let degreeLabelRadius =  min(bounds.width, bounds.height) * 0.45 - 32

            let degreeLabelAngle = 2 * .pi - (position * .pi / 180) + .pi
            let degreeLabelX = center.x + cos(degreeLabelAngle) * degreeLabelRadius
            let degreeLabelY = center.y + sin(degreeLabelAngle) * degreeLabelRadius
            degreeLabel.center = CGPoint(x: degreeLabelX, y: degreeLabelY)
            addSubview(degreeLabel)
            
        }

        for (_, (celestialObject, imageName)) in sortedPlanetSignSymbol.enumerated() {
            guard let position = synastryPlanetPositions[celestialObject] else { continue }
            let angle = 2 * .pi - (position * .pi / 180) + .pi
            let radius = min(bounds.width, bounds.height) * 0.45 - 49
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let centerX = center.x + cos(angle) * radius
            let centerY = center.y + sin(angle) * radius
            
            let symbolSize = min(bounds.width, bounds.height) / 40
            let symbolImageView = UIImageView(image: UIImage(named: imageName))
            symbolImageView.contentMode = .scaleAspectFit
            symbolImageView.frame = CGRect(x: 0, y: 0, width: symbolSize, height: symbolSize)
            symbolImageView.center = CGPoint(x: centerX, y: centerY - symbolSize / 2 )
                addSubview(symbolImageView)
        }

        for (_, (celestialObject, minute)) in sortedPlanetMinute.enumerated() {
            guard let position = synastryPlanetPositions[celestialObject] else { continue }

            // Add the planet minute label
            let minuteLabel = UILabel()
            minuteLabel.textColor = .white
            minuteLabel.textAlignment = .center
            minuteLabel.text = minute // Generate a random minute value
            minuteLabel.font = UIFont.systemFont(ofSize: 8)
            minuteLabel.sizeToFit()
            
            let minuteLabelRadius = min(bounds.width, bounds.height) * 0.45 - 69
            let minuteLabelAngle = 2 * .pi - (position * .pi / 180) + .pi
            let minuteLabelX = center.x + cos(minuteLabelAngle) * minuteLabelRadius
            let minuteLabelY = center.y + sin(minuteLabelAngle) * minuteLabelRadius
            
            minuteLabel.center = CGPoint(x: minuteLabelX, y: minuteLabelY)
//                addSubview(minuteLabel)
        }

        
        if let image = UIImage(named: imageName) {
            image.draw(in: symbolRect)

        
        }
    }
}


    func calculateNonOverlappingPosition(celestialObject: CelestialObject, position: CGFloat, radius: CGFloat, lastSymbolCenter: inout CGPoint?, lastCelestialObject: inout CelestialObject?, minSymbolDistance: CGFloat) -> CGPoint {
        let angle = 2 * .pi - (position * .pi / 180) + .pi
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var centerX = center.x + cos(angle) * radius
        var centerY = center.y + sin(angle) * radius
        
        if let lastCenter = lastSymbolCenter, let lastPosition = lastCelestialObject.flatMap({ planetPositions[$0] }) {
            let distance = hypot(centerX - lastCenter.x, centerY - lastCenter.y)
            
            if distance < minSymbolDistance {
                if position > lastPosition {
                    let angleAdjustment = -minSymbolDistance / radius
                    let adjustedAngle = angle + angleAdjustment
                    centerX = center.x + cos(adjustedAngle) * radius
                    centerY = center.y + sin(adjustedAngle) * radius
                } else {
                    let angleAdjustment = minSymbolDistance / radius
                    let adjustedAngle = angle + angleAdjustment
                    centerX = center.x + cos(adjustedAngle) * radius
                    centerY = center.y + sin(adjustedAngle) * radius
                }
            }
        }
        
        lastSymbolCenter = CGPoint(x: centerX, y: centerY)
        lastCelestialObject = celestialObject
        
        return CGPoint(x: centerX, y: centerY)
    }

    
    func updatePlanetPositions(newPositions: [CelestialObject: CGFloat]) {
        planetPositions = newPositions
        setNeedsDisplay()
    }
    
    func updateBirthChart() {
        let ascendantOffset = getHouses1()[0]
        
        let planetPositions: [CelestialObject: CGFloat] = [
            .planet(.sun): getPlanets()[0] - ascendantOffset,
            .planet(.moon): getPlanets()[1] - ascendantOffset,
            .planet(.mercury): getPlanets()[2] - ascendantOffset,
            .planet(.venus): getPlanets()[3] - ascendantOffset,
            .planet(.mars): getPlanets()[4] - ascendantOffset,
            .planet(.jupiter): getPlanets()[5] - ascendantOffset,
            .planet(.saturn): getPlanets()[6] - ascendantOffset,
            .planet(.uranus): getPlanets()[7] - ascendantOffset,
            .planet(.neptune): getPlanets()[8] - ascendantOffset,
            .planet(.pluto): getPlanets()[9] - ascendantOffset,
            .lunarNode(.meanSouthNode): getPlanets()[10] - ascendantOffset
        ]
        updatePlanetPositions(newPositions: planetPositions)
    }
    
    
    private func getPlanets() -> [CGFloat] {
        let sunPosition = natalChart!.natal.sun.value
        let moonPosition = natalChart!.natal.moon.value
        let mercuryPosition = natalChart!.natal.mercury.value
        let venusPosition = natalChart!.natal.venus.value
        let marsPosition = natalChart!.natal.mars.value
        let jupiterPosition = natalChart!.natal.jupiter.value
        let saturnPosition = natalChart!.natal.saturn.value
        let uranusPosition = natalChart!.natal.uranus.value
        let neptunePosition = natalChart!.natal.neptune.value
        let plutoPosition = natalChart!.natal.pluto.value
//        let northNodePosition = selectedChart!.natal.northNode.value
        let southNodePosition = natalChart!.natal.southNode.value
        
        return [
            sunPosition,
            moonPosition,
            mercuryPosition,
            venusPosition,
            marsPosition,
            jupiterPosition,
            saturnPosition,
            uranusPosition,
            neptunePosition,
            plutoPosition,
//            northNodePosition,
            southNodePosition
        ]
    }
    

func updateSynastryPlanetPositions(newTransitPositions: [CelestialObject: CGFloat]) {
    synastryPlanetPositions = newTransitPositions
    setNeedsDisplay()
}

func updateSynastryChart() {
    let ascendantOffset = getHouses1()[0]
    
    let planetPositions: [CelestialObject: CGFloat] = [
        .planet(.sun): getSynastryPlanets()[0] - ascendantOffset,
        .planet(.moon): getSynastryPlanets()[1] - ascendantOffset,
        .planet(.mercury): getSynastryPlanets()[2] - ascendantOffset,
        .planet(.venus): getSynastryPlanets()[3] - ascendantOffset,
        .planet(.mars): getSynastryPlanets()[4] - ascendantOffset,
        .planet(.jupiter): getSynastryPlanets()[5] - ascendantOffset,
        .planet(.saturn): getSynastryPlanets()[6] - ascendantOffset,
        .planet(.uranus): getSynastryPlanets()[7] - ascendantOffset,
        .planet(.neptune): getSynastryPlanets()[8] - ascendantOffset,
        .planet(.pluto): getSynastryPlanets()[9] - ascendantOffset,
            .lunarNode(.meanSouthNode): getPlanets()[10] - ascendantOffset
    ]
    updateSynastryPlanetPositions(newTransitPositions: planetPositions)
}


private func getSynastryPlanets() -> [CGFloat] {
    let sunPosition = selectedChart!.natal.sun.value
    let moonPosition = selectedChart!.natal.moon.value
    let mercuryPosition = selectedChart!.natal.mercury.value
    let venusPosition = selectedChart!.natal.venus.value
    let marsPosition = selectedChart!.natal.mars.value
    let jupiterPosition = selectedChart!.natal.jupiter.value
    let saturnPosition = selectedChart!.natal.saturn.value
    let uranusPosition = selectedChart!.natal.uranus.value
    let neptunePosition = selectedChart!.natal.neptune.value
    let plutoPosition = selectedChart!.natal.pluto.value
//        let northNodePosition = selectedChart!.natal.northNode.value
        let southNodePosition = selectedChart!.natal.southNode.value
    
    return [
        sunPosition,
        moonPosition,
        mercuryPosition,
        venusPosition,
        marsPosition,
        jupiterPosition,
        saturnPosition,
        uranusPosition,
        neptunePosition,
        plutoPosition,
//            northNodePosition,
           southNodePosition
    ]
}
    
    

}
