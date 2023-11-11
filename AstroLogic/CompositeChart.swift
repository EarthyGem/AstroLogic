import UIKit
import SwiftEphemeris


class CompositeBirthChartView: UIView {
    var planetPositions: [CelestialObject: CGFloat] = [:]
    var chart: Chart?
  
    init(frame: CGRect, chart: Chart) {
        self.chart = chart
        super.init(frame: frame)
        setupGestureRecognizers()
        updateBirthChart()
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
        print(getHousesDegree())
        print(getHouseNames())
        
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

    
    private func drawHouseLines(context: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.45
        let houseDegrees = getHousesDegree()
        let houseMinutes = getHousesMinute()
        let houseDistances = getHouses2()
        let houseCuspSignNames = getHouseNames()

        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.3)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        
//        let houseDistances[index] : CGFloat = 30
        var accumulatedAngle: CGFloat = 0
     
        
        for index in 0..<12 {
            let angle = 2 * .pi - ((accumulatedAngle + houseDistances[index] ) * .pi / 180) + .pi
            let startX = center.x + cos(angle) * (0.34 * radius)
            let startY = center.y + sin(angle) * (0.34 * radius)
            
            // Line doesn't intersect with the innermost circle, draw full line
            let endX = center.x + cos(angle) * radius
            let endY = center.y + sin(angle) * radius
                
            context.move(to: CGPoint(x: startX, y: startY))
            context.addLine(to: CGPoint(x: endX, y: endY))
            context.strokePath()
            let houseDegree = houseDegrees[(index + 1) % 12]
            let houseMinute = houseMinutes[(index + 1) % 12]
           
      
                let glyphLabelAngleOffset: CGFloat = 0.0
           
        
            let degreeLabelAngleOffset: CGFloat
                let minuteLabelAngleOffset: CGFloat

                let adjustedIndex = (index + 1) % 12

                if index == 11 { // House 1
                    degreeLabelAngleOffset = 0.11
                    minuteLabelAngleOffset = -0.08
                } else if adjustedIndex < 6 { // Houses 2-6
                    degreeLabelAngleOffset = 0.11
                    minuteLabelAngleOffset = -0.08
                } else { // Houses 7-12
                    degreeLabelAngleOffset = -0.08
                    minuteLabelAngleOffset = 0.08
                }

          
            // Add the planet number label
            // Add the planet number label
            let houseNumberLabel = UILabel()
            houseNumberLabel.textColor = .white
            houseNumberLabel.textAlignment = .center
            houseNumberLabel.text = "\((index + 1) % 12 + 1)"
            houseNumberLabel.font = UIFont.systemFont(ofSize: adjustedFontSize(for: 10))
        

            houseNumberLabel.sizeToFit()
            let labelRadius = (0.34 + 0.41) / 2 * radius
            let labelAngle = angle - houseDistances[index]  / 2 * .pi / 180
            let labelX = center.x + cos(labelAngle) * labelRadius - houseNumberLabel.bounds.width / 2
            let labelY = center.y + sin(labelAngle) * labelRadius - houseNumberLabel.bounds.height / 2
            houseNumberLabel.frame.origin = CGPoint(x: labelX, y: labelY)
            addSubview(houseNumberLabel)
            
            
            // Add the house degree label
            let houseDegreeLabel = UILabel()
            houseDegreeLabel.textColor = .white
            houseDegreeLabel.textAlignment = .center
            houseDegreeLabel.text = "\(Int(houseDegree))°"

            houseDegreeLabel.font = UIFont.systemFont(ofSize: adjustedFontSize(for: 10))

            houseDegreeLabel.sizeToFit()
            let labelRadius1 = 1.07 * radius
            let labelAngle1 = 2 * .pi - ((accumulatedAngle + houseDistances[index] ) * .pi / 180) + .pi + degreeLabelAngleOffset
            let labelX1 = center.x + cos(labelAngle1) * labelRadius1 - houseDegreeLabel.bounds.width / 2
            let labelY1 = center.y + sin(labelAngle1) * labelRadius1 - houseDegreeLabel.bounds.height / 2
            houseDegreeLabel.frame.origin = CGPoint(x: labelX1, y: labelY1)
            addSubview(houseDegreeLabel)

            let signName = houseCuspSignNames[(index + 1) % 12]

            // Directly fetch the name for this cusp from the array

               guard let image = UIImage(named: signName) else { continue }
            print("House \(index + 1) : Degree \(Int(houseDegree))°, Minute \(Int(houseMinute))', Sign Index: \(signName)")

            let imageSize = min(bounds.width, bounds.height) / 30
            let labelRadius2 = 1.07 * radius // Keep the same radius as the degree and minute labels
            let labelAngle2 = 2 * .pi - ((accumulatedAngle + houseDistances[index] ) * .pi / 180) + .pi + glyphLabelAngleOffset
            let labelX2 = center.x + cos(labelAngle2) * labelRadius2 - imageSize / 2
            let labelY2 = center.y + sin(labelAngle2) * labelRadius2 - imageSize / 2
            let imageRect = CGRect(x: labelX2, y: labelY2, width: imageSize, height: imageSize)
            image.draw(in: imageRect)

            
            // Add the house minute label
            let houseMinuteLabel = UILabel()
            houseMinuteLabel.textColor = .white
            houseMinuteLabel.textAlignment = .center
            houseMinuteLabel.text = "\(Int(houseMinute))'"

            houseMinuteLabel.font = UIFont.systemFont(ofSize: adjustedFontSize(for: 8))

            houseMinuteLabel.sizeToFit()
            let labelRadius3 = 1.07 * radius
            let labelAngle3 = 2 * .pi - ((accumulatedAngle + houseDistances[index] ) * .pi / 180) + .pi + minuteLabelAngleOffset
            let labelX3 = center.x + cos(labelAngle3) * labelRadius3 - houseMinuteLabel.bounds.width / 2
            let labelY3 = center.y + sin(labelAngle3) * labelRadius3 - houseMinuteLabel.bounds.height / 2
            houseMinuteLabel.frame.origin = CGPoint(x: labelX3, y: labelY3)
            addSubview(houseMinuteLabel)
            
            accumulatedAngle += houseDistances[index]
        }
    }

    func zodiacSign(for degree: CGFloat) -> Int {
        let adjustedDegree = degree.truncatingRemainder(dividingBy: 360)
        return Int(adjustedDegree / 30)
    }
    
    func adjustedFontSize(for size: CGFloat) -> CGFloat {
        let screenBounds = UIScreen.main.bounds
        let adjustmentFactor = screenBounds.width / 375  // 375 is the width of the iPhone 6/7/8
        return size * adjustmentFactor
    }


    private func drawPlanetSymbols(context: CGContext) {
        
        _ = CGPoint(x: bounds.midX, y: bounds.midY)
        _ = min(bounds.width, bounds.height) * 0.45
        let _: CGFloat = 30
        
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
            (.planet(.sun), "\(Int(chart!.sun.degree))°"),
            (.planet(.moon), "\(Int(chart!.moon.degree))°"),
            (.planet(.mercury), "\(Int(chart!.mercury.degree))°"),
            (.planet(.venus), "\(Int(chart!.venus.degree))°"),
            (.planet(.mars), "\(Int(chart!.mars.degree))°"),
            (.planet(.jupiter), "\(Int(chart!.jupiter.degree))°"),
            (.planet(.saturn), "\(Int(chart!.saturn.degree))°"),
            (.planet(.uranus), "\(Int(chart!.uranus.degree))°"),
            (.planet(.neptune), "\(Int(chart!.neptune.degree))°"),
            (.planet(.pluto), "\(Int(chart!.pluto.degree))°"),
            (.lunarNode(.meanSouthNode), "\(Int(chart!.southNode.degree))°")
          
        ]
    
        let planetSignSymbols: [(planet: CelestialObject, imageName: String)] = [
            (.planet(.sun), chart!.sun.sign.keyName),
            (.planet(.moon), chart!.moon.sign.keyName),
            (.planet(.mercury), chart!.mercury.sign.keyName),
            (.planet(.venus), chart!.venus.sign.keyName),
            (.planet(.mars), chart!.mars.sign.keyName),
            (.planet(.jupiter), chart!.jupiter.sign.keyName),
            (.planet(.saturn), chart!.saturn.sign.keyName),
            (.planet(.uranus), chart!.uranus.sign.keyName),
            (.planet(.neptune), chart!.neptune.sign.keyName),
            (.planet(.pluto), chart!.pluto.sign.keyName),
            (.lunarNode(.meanSouthNode), chart!.southNode.sign.keyName)
            
        ]
        
        
        let planetMinute: [(planet: CelestialObject, minute: String)] = [
            (.planet(.sun), "\(Int(chart!.sun.minute))°"),
            (.planet(.moon), "\(Int(chart!.moon.minute))°"),
            (.planet(.mercury), "\(Int(chart!.mercury.minute))°"),
            (.planet(.venus), "\(Int(chart!.venus.minute))°"),
            (.planet(.mars), "\(Int(chart!.mars.minute))°"),
            (.planet(.jupiter), "\(Int(chart!.jupiter.minute))°"),
            (.planet(.saturn), "\(Int(chart!.saturn.minute))°"),
            (.planet(.uranus), "\(Int(chart!.uranus.minute))°"),
            (.planet(.neptune), "\(Int(chart!.neptune.minute))°"),
            (.planet(.pluto), "\(Int(chart!.pluto.minute))°"),
            (.lunarNode(.meanSouthNode), "\(Int(chart!.southNode.minute))°")
        
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

        
        let minSymbolDistance: CGFloat = 10 // Adjust this value to change the minimum distance
        var lastSymbolCenter: CGPoint? = nil
        var lastCelestialObject: CelestialObject? = nil
        
        for (_, (celestialObject, imageName)) in sortedPlanetSymbols.enumerated() {
            guard let position = planetPositions[celestialObject] else { continue }
            let angle = 2 * .pi - (position * .pi / 180) + .pi
            let radius = min(bounds.width, bounds.height) * 0.45 - 20
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
            
            
            
            let symbolSize = min(bounds.width, bounds.height) / 30
            let symbolRect = CGRect(x: centerX - symbolSize / 2, y: centerY - symbolSize / 2, width: symbolSize, height: symbolSize)
            
            let degreeLabelRadius = min(bounds.width, bounds.height) * 0.45 - 42
            var lastDegreeLabelCenter: CGPoint? = nil
            var lastDegreeLabelCelestialObject: CelestialObject? = nil
            let minLabelDistance: CGFloat = 20
            for (_, (celestialObject, degree)) in sortedPlanetDegree.enumerated() {
                guard let position = planetPositions[celestialObject] else { continue }

                let degreeLabel = UILabel()
                degreeLabel.textColor = .white
                degreeLabel.textAlignment = .center
                degreeLabel.text = degree
                degreeLabel.font = UIFont.systemFont(ofSize: adjustedFontSize(for: 9))

                degreeLabel.sizeToFit()

                let degreeLabelCenter = calculateNonOverlappingPosition(celestialObject: celestialObject, position: position, radius: degreeLabelRadius, lastSymbolCenter: &lastDegreeLabelCenter, lastCelestialObject: &lastDegreeLabelCelestialObject, minSymbolDistance: minLabelDistance)
                degreeLabel.center = degreeLabelCenter
                addSubview(degreeLabel)
            }

            

            let signSymbolLabelRadius = min(bounds.width, bounds.height) * 0.45 - 59
            var lastSignSymbolLabelCenter: CGPoint? = nil
            var lastSignSymbolLabelCelestialObject: CelestialObject? = nil

            for (_, (celestialObject, imageName)) in sortedPlanetSignSymbol.enumerated() {
                guard let position = planetPositions[celestialObject] else { continue }
                let angle = 2 * .pi - (position * .pi / 180) + .pi
                let radius = min(bounds.width, bounds.height) * 0.45 - 61
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                _ = center.x + cos(angle) * radius
                _ = center.y + sin(angle) * radius

                let symbolSize = min(bounds.width, bounds.height) / 40
                let symbolImageView = UIImageView(image: UIImage(named: imageName))
                symbolImageView.contentMode = .scaleAspectFit

                let symbolLabelCenter = calculateNonOverlappingPosition(celestialObject: celestialObject, position: position, radius: signSymbolLabelRadius, lastSymbolCenter: &lastSignSymbolLabelCenter, lastCelestialObject: &lastSignSymbolLabelCelestialObject, minSymbolDistance: minLabelDistance)
                symbolImageView.frame = CGRect(x: symbolLabelCenter.x - symbolSize / 2, y: symbolLabelCenter.y - symbolSize / 2, width: symbolSize, height: symbolSize)
                addSubview(symbolImageView)
            }

            
            let minuteLabelRadius = min(bounds.width, bounds.height) * 0.45 - 74
            var lastMinuteLabelCenter: CGPoint? = nil
            var lastMinuteLabelCelestialObject: CelestialObject? = nil

            for (_, (celestialObject, minute)) in sortedPlanetMinute.enumerated() {
                guard let position = planetPositions[celestialObject] else { continue }

                let minuteLabel = UILabel()
                minuteLabel.textColor = .white
                minuteLabel.textAlignment = .center
                minuteLabel.text = minute
                minuteLabel.font = UIFont.systemFont(ofSize: adjustedFontSize(for: 6))

                minuteLabel.sizeToFit()

                let minuteLabelCenter = calculateNonOverlappingPosition(celestialObject: celestialObject, position: position, radius: minuteLabelRadius, lastSymbolCenter: &lastMinuteLabelCenter, lastCelestialObject: &lastMinuteLabelCelestialObject, minSymbolDistance: minLabelDistance)
                minuteLabel.center = minuteLabelCenter
                addSubview(minuteLabel)
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
        let sunPosition = chart!.sun.value
        let moonPosition = chart!.moon.value
        let mercuryPosition = chart!.mercury.value
        let venusPosition = chart!.venus.value
        let marsPosition = chart!.mars.value
        let jupiterPosition = chart!.jupiter.value
        let saturnPosition = chart!.saturn.value
        let uranusPosition = chart!.uranus.value
        let neptunePosition = chart!.neptune.value
        let plutoPosition = chart!.pluto.value
//        let northNodePosition = chart!.northNode.value
     let southNodePosition = chart!.southNode.value
        
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
    
    private func getHouses1() -> [CGFloat] {
        
        let first = chart!.houseCusps.first.value
        let second = chart!.houseCusps.second.value
        let third = chart!.houseCusps.third.value
        let fourth = chart!.houseCusps.fourth.value
        let fifth = chart!.houseCusps.fifth.value
        let sixth = chart!.houseCusps.sixth.value
        let seventh = chart!.houseCusps.seventh.value
        let eighth = chart!.houseCusps.eighth.value
        let ninth = chart!.houseCusps.ninth.value
        let tenth = chart!.houseCusps.tenth.value
        let eleventh = chart!.houseCusps.eleventh.value
        let twelfth = chart!.houseCusps.twelfth.value
        print("House cusps: \(first), \(second), \(third), \(fourth), \(fifth), \(sixth), \(seventh), \(eighth), \(ninth), \(tenth), \(eleventh), \(twelfth)")

        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    private func getHousesDegree() -> [CGFloat] {
    
        let first = chart!.houseCusps.first.degree
        let second = chart!.houseCusps.second.degree
        let third = chart!.houseCusps.third.degree
        let fourth = chart!.houseCusps.fourth.degree
        let fifth = chart!.houseCusps.fifth.degree
        let sixth = chart!.houseCusps.sixth.degree
        let seventh = chart!.houseCusps.seventh.degree
        let eighth = chart!.houseCusps.eighth.degree
        let ninth = chart!.houseCusps.ninth.degree
        let tenth = chart!.houseCusps.tenth.degree
        let eleventh = chart!.houseCusps.eleventh.degree
        let twelfth = chart!.houseCusps.twelfth.degree
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    
    private func getHousesMinute() -> [CGFloat] {
        
        let first = chart!.houseCusps.first.minute
        let second = chart!.houseCusps.second.minute
        let third = chart!.houseCusps.third.minute
        let fourth = chart!.houseCusps.fourth.minute
        let fifth = chart!.houseCusps.fifth.minute
        let sixth = chart!.houseCusps.sixth.minute
        let seventh = chart!.houseCusps.seventh.minute
        let eighth = chart!.houseCusps.eighth.minute
        let ninth = chart!.houseCusps.ninth.minute
        let tenth = chart!.houseCusps.tenth.minute
        let eleventh = chart!.houseCusps.eleventh.minute
        let twelfth = chart!.houseCusps.twelfth.minute
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    
    private func getHouseNames() -> [String] {
        
        let first = chart!.houseCusps.first.sign.keyName
        let second = chart!.houseCusps.second.sign.keyName
        let third = chart!.houseCusps.third.sign.keyName
        let fourth = chart!.houseCusps.fourth.sign.keyName
        let fifth = chart!.houseCusps.fifth.sign.keyName
        let sixth = chart!.houseCusps.sixth.sign.keyName
        let seventh = chart!.houseCusps.seventh.sign.keyName
        let eighth = chart!.houseCusps.eighth.sign.keyName
        let ninth = chart!.houseCusps.ninth.sign.keyName
        let tenth = chart!.houseCusps.tenth.sign.keyName
        let eleventh = chart!.houseCusps.eleventh.sign.keyName
        let twelfth = chart!.houseCusps.twelfth.sign.keyName
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    
    
    private func getHouses2() -> [CGFloat] {
        let houseCusps = getHouses1()
        print("House cusps: \(houseCusps)")

        var houseDistances: [CGFloat] = []
        
        for i in 0..<houseCusps.count {
            let nextIndex = (i + 1) % houseCusps.count
            let distance = (houseCusps[nextIndex] - houseCusps[i] + 360).truncatingRemainder(dividingBy: 360)
            houseDistances.append(distance)
            print("House \(i + 1) to \(nextIndex + 1) distance: \(distance)")

        }
        
        return houseDistances
    }
    
    
    
    

}
