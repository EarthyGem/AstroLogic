import UIKit
import SwiftEphemeris

struct CompPlanetsData {
    let compositePlanets: [String]
    let compPlanets: [Double]
    let compPlanetsDegree: [Double]
}

class CompositeBirthChartView: UIView {
    var chartCake: ChartCake!
    var otherChart: ChartCake!
    var planetPositions: [CelestialObject: CGFloat] = [:]
    var synastryPlanetPositions: [CelestialObject: CGFloat] = [:]

    init(frame: CGRect, chartCake: ChartCake, otherChart: ChartCake) {
        self.chartCake = chartCake
        self.otherChart = otherChart
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
        calculateAspects()
        
    }
    
    private func drawZodiacCircle(context: CGContext) {
        
    //    print("Calculate Aspects: \(calculateAspects())")
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.45
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.3)
        context.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        context.strokePath()
        
        let innerRadius1 = radius * 0.27
        let innerRadius2 = radius * 0.34
        context.addEllipse(in: CGRect(x: center.x - innerRadius1, y: center.y - innerRadius1, width: innerRadius1 * 2, height: innerRadius1 * 2))
        context.strokePath()
        
        context.addEllipse(in: CGRect(x: center.x - innerRadius2, y: center.y - innerRadius2, width: innerRadius2 * 2, height: innerRadius2 * 2))
        context.strokePath()
    }
    
    private func drawHouseLines(context: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.45
        let houseDegrees = getCompHouseDegrees()
        let houseMinutes = getCompHouseMinutes()
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.3)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        
        let equalHouseAngle: CGFloat = 30
        var accumulatedAngle: CGFloat = 0
        
        for index in 0..<12 {
            let angle = 2 * .pi - ((accumulatedAngle + equalHouseAngle) * .pi / 180) + .pi
            let startX = center.x + cos(angle) * (0.27 * radius)
            let startY = center.y + sin(angle) * (0.27 * radius)
            
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
            let labelRadius = (0.27 + 0.34) / 2 * radius
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
            let imageName = getHouseCuspSign()[signIndex]
            print("House \(index + 1) : Degree \(Int(houseDegree))°, Minute \(Int(houseMinute))', Sign Index: \(imageName)")

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
            (.planet(.sun), "\(Int(getCompPlanets().compPlanetsDegree[0]))°"),
            (.planet(.moon), "\(Int(getCompPlanets().compPlanetsDegree[1]))°"),
            (.planet(.mercury), "\(Int(getCompPlanets().compPlanetsDegree[2]))°"),
            (.planet(.venus), "\(Int(getCompPlanets().compPlanetsDegree[3]))°"),
            (.planet(.mars), "\(Int(getCompPlanets().compPlanetsDegree[4]))°"),
            (.planet(.jupiter), "\(Int(getCompPlanets().compPlanetsDegree[5]))°"),
            (.planet(.saturn), "\(Int(getCompPlanets().compPlanetsDegree[6]))°"),
            (.planet(.uranus), "\(Int(getCompPlanets().compPlanetsDegree[7]))°"),
            (.planet(.neptune), "\(Int(getCompPlanets().compPlanetsDegree[8]))°"),
            (.planet(.pluto), "\(Int(getCompPlanets().compPlanetsDegree[9]))°"),
//            (.lunarNode(.meanSouthNode), "\(Int(chart!.southNode.degree))°")
            
        ]
        
        let planetSignSymbols: [(planet: CelestialObject, imageName: String)] = [
            (.planet(.sun), getCompPlanets().compPlanetsSign[0]),
            (.planet(.moon), getCompPlanets().compPlanetsSign[1]),
            (.planet(.mercury), getCompPlanets().compPlanetsSign[2]),
            (.planet(.venus), getCompPlanets().compPlanetsSign[3]),
            (.planet(.mars), getCompPlanets().compPlanetsSign[4]),
            (.planet(.jupiter), getCompPlanets().compPlanetsSign[5]),
            (.planet(.saturn), getCompPlanets().compPlanetsSign[6]),
            (.planet(.uranus), getCompPlanets().compPlanetsSign[7]),
            (.planet(.neptune), getCompPlanets().compPlanetsSign[8]),
            (.planet(.pluto), getCompPlanets().compPlanetsSign[9]),
            (.lunarNode(.meanSouthNode), getCompPlanets().compPlanetsSign[10]),
            
        ]
        
        
        let planetMinute: [(planet: CelestialObject, minute: String)] = [
            (.planet(.sun), "\(Int(getCompPlanets().compPlanetsMinute[0]))'"),
            (.planet(.moon), "\(Int(getCompPlanets().compPlanetsMinute[1]))'"),
            (.planet(.mercury), "\(Int(getCompPlanets().compPlanetsMinute[2]))'"),
            (.planet(.venus), "\(Int(getCompPlanets().compPlanetsMinute[3]))'"),
            (.planet(.mars), "\(Int(getCompPlanets().compPlanetsMinute[4]))'"),
            (.planet(.jupiter), "\(Int(getCompPlanets().compPlanetsMinute[5]))'"),
            (.planet(.saturn), "\(Int(getCompPlanets().compPlanetsMinute[6]))'"),
            (.planet(.uranus), "\(Int(getCompPlanets().compPlanetsMinute[7]))'"),
            (.planet(.neptune), "\(Int(getCompPlanets().compPlanetsMinute[8]))'"),
            (.planet(.pluto), "\(Int(getCompPlanets().compPlanetsMinute[9]))'"),
//            (.lunarNode(.meanSouthNode), "\(Int(chart!.southNode.minute))°")
            
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
        
        
        let minSymbolDistance: CGFloat = 0 // Adjust this value to change the minimum distance
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
            
            
            
            let symbolSize = min(bounds.width, bounds.height) / 20
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
                degreeLabel.font = UIFont.systemFont(ofSize: 12)
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
                minuteLabel.font = UIFont.systemFont(ofSize: 8)
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
        let sunPosition = getCompPlanetsValue()[0]
        let moonPosition = getCompPlanetsValue()[1]
        let mercuryPosition = getCompPlanetsValue()[2]
        let venusPosition = getCompPlanetsValue()[3]
        let marsPosition = getCompPlanetsValue()[4]
        let jupiterPosition = getCompPlanetsValue()[5]
        let saturnPosition = getCompPlanetsValue()[6]
        let uranusPosition = getCompPlanetsValue()[7]
        let neptunePosition = getCompPlanetsValue()[8]
        let plutoPosition = getCompPlanetsValue()[9]
        let southNodePosition = getCompPlanetsValue()[10]
        
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
            southNodePosition
        ]
    }
    
    
    
    func getCompHouseSigns() -> [String] {
        return calculateCompHouseComponents().0
    }

    func getCompHouseDegrees() -> [Int] {
        return calculateCompHouseComponents().1
    }

    func getCompHouseMinutes() -> [Int] {
        return calculateCompHouseComponents().2
    }

    func getCompHouseSeconds() -> [Int] {
        return calculateCompHouseComponents().3
    }

    private func calculateCompHouseComponents() -> ([String], [Int], [Int], [Int]) {
        guard let chart1 = chartCake else { return ([String](), [Int](), [Int](), [Int]())  }
        guard let chart2 = otherChart else { return ([String](), [Int](), [Int](), [Int]())  }
        
        let cusps = [
            (chart1.houseCusps.ascendent.value, chart2.houseCusps.ascendent.value),
            (chart1.houseCusps.second.value, chart2.houseCusps.second.value),
            (chart1.houseCusps.third.value, chart2.houseCusps.third.value), (chart1.houseCusps.fourth.value, chart2.houseCusps.fourth.value), (chart1.houseCusps.fifth.value, chart2.houseCusps.fifth.value), (chart1.houseCusps.sixth.value, chart2.houseCusps.sixth.value), (chart1.houseCusps.seventh.value, chart2.houseCusps.seventh.value), (chart1.houseCusps.eighth.value, chart2.houseCusps.eighth.value), (chart1.houseCusps.ninth.value, chart2.houseCusps.ninth.value), (chart1.houseCusps.tenth.value, chart2.houseCusps.tenth.value), (chart1.houseCusps.eleventh.value, chart2.houseCusps.eleventh.value), (chart1.houseCusps.twelfth.value, chart2.houseCusps.twelfth.value)
            // Add the rest of your cusps here
        ]

        var signs: [String] = []
        var degrees: [Int] = []
        var minutes: [Int] = []
        var seconds: [Int] = []

        for cusp in cusps {
            let compSign = getCompositePoint(point1: cusp.0, point2: cusp.1)
            let (sign, degree, minute, second) = convertToAstroCoordinates(degree: compSign)
            signs.append(sign)
            degrees.append(degree)
            minutes.append(minute)
            seconds.append(second)
        }

        return (signs, degrees, minutes, seconds)
    }

    
    
    
    func getCompPlanetsValue() -> [Double] {
        guard let chart1 = chartCake else { return [Double]() }
        guard let chart2 = otherChart else { return [Double]() }

        let compSun = getCompositePoint(point1: chart1.natal.sun.value, point2: chart2.natal.sun.value)
        let compMoon = getCompositePoint(point1: chart1.natal.moon.value, point2: chart2.natal.moon.value)
        let compMercury = getCompositePoint(point1: chart1.natal.mercury.value, point2: chart2.natal.mercury.value)
        let compVenus = getCompositePoint(point1: chart1.natal.venus.value, point2: chart2.natal.venus.value)
        let compMars = getCompositePoint(point1: chart1.natal.mars.value, point2: chart2.natal.mars.value)
        let compJupiter = getCompositePoint(point1: chart1.natal.jupiter.value, point2: chart2.natal.jupiter.value)
        let compSaturn = getCompositePoint(point1: chart1.natal.saturn.value, point2: chart2.natal.saturn.value)
        let compUranus = getCompositePoint(point1: chart1.natal.uranus.value, point2: chart2.natal.uranus.value)
        let compNeptune = getCompositePoint(point1: chart1.natal.neptune.value, point2: chart2.natal.neptune.value)
        let compPluto = getCompositePoint(point1: chart1.natal.pluto.value, point2: chart2.natal.pluto.value)
        let compSouthNode = getCompositePoint(point1: chart1.natal.southNode.value, point2: chart2.natal.southNode.value)

        let compPlanetValue = [compSun,
                               compMoon,
                               compMercury,
                               compVenus,
                               compMars,
                               compJupiter,
                               compSaturn,
                               compUranus,
                               compNeptune,
                               compPluto,
                               compSouthNode]
        
        return compPlanetValue
    }
    
    private func getHouses1() -> [CGFloat] {
        guard let chart1 = chartCake else { return [CGFloat]() }
        guard let chart2 = otherChart else { return [CGFloat]() }
        
            let first = getCompositePoint(point1: (chart1.houseCusps.ascendent.value), point2: chart2.houseCusps.ascendent.value)
            
            let second = getCompositePoint(point1: (chart1.houseCusps.second.value), point2: chart2.houseCusps.second.value)
            
            let third = getCompositePoint(point1: (chart1.houseCusps.third.value), point2: chart2.houseCusps.third.value)
            
            let fourth = getCompositePoint(point1: (chart1.houseCusps.fourth.value), point2: chart2.houseCusps.fourth.value)
            
            let fifth = getCompositePoint(point1: (chart1.houseCusps.fifth.value), point2: chart2.houseCusps.fifth.value)
            
            let sixth = getCompositePoint(point1: (chart1.houseCusps.sixth.value), point2: chart2.houseCusps.sixth.value)
            
            let seventh = getCompositePoint(point1: (chart1.houseCusps.seventh.value), point2: chart2.houseCusps.seventh.value)
            
            let eighth = getCompositePoint(point1: (chart1.houseCusps.eighth.value), point2: chart2.houseCusps.eighth.value)
            
            let ninth = getCompositePoint(point1: (chart1.houseCusps.ninth.value), point2: chart2.houseCusps.ninth.value)
            
            let tenth = getCompositePoint(point1: (chart1.houseCusps.tenth.value), point2: chart2.houseCusps.tenth.value)
            
            let eleventh = getCompositePoint(point1: (chart1.houseCusps.eleventh.value), point2: chart2.houseCusps.eleventh.value)
            
            let twelfth = getCompositePoint(point1: (chart1.houseCusps.twelfth.value), point2: chart2.houseCusps.twelfth.value)
        
      //  print("\([first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth])")
        
        
            
            return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
        }
        
    
        func getHousesDegree() -> [Double] {
            guard let chart1 = chartCake else { return [Double]() }
            guard let chart2 = otherChart else { return [Double]() }

            let compFirst = getCompositePoint(point1: (chart1.houseCusps.ascendent.value), point2: chart2.houseCusps.ascendent.value)
            
            let compSecond = getCompositePoint(point1: (chart1.houseCusps.second.value), point2: chart2.houseCusps.second.value)
            
            let compThird = getCompositePoint(point1: (chart1.houseCusps.third.value), point2: chart2.houseCusps.third.value)
            
            let compFourth = getCompositePoint(point1: (chart1.houseCusps.fourth.value), point2: chart2.houseCusps.fourth.value)
            
            let compFifth = getCompositePoint(point1: (chart1.houseCusps.fifth.value), point2: chart2.houseCusps.fifth.value)
            
            let compSixth = getCompositePoint(point1: (chart1.houseCusps.sixth.value), point2: chart2.houseCusps.sixth.value)
            
            let compSeventh = getCompositePoint(point1: (chart1.houseCusps.seventh.value), point2: chart2.houseCusps.seventh.value)
            
            let compEighth = getCompositePoint(point1: (chart1.houseCusps.eighth.value), point2: chart2.houseCusps.eighth.value)
            
            let compNinth = getCompositePoint(point1: (chart1.houseCusps.ninth.value), point2: chart2.houseCusps.ninth.value)
            
            let compTenth = getCompositePoint(point1: (chart1.houseCusps.tenth.value), point2: chart2.houseCusps.tenth.value)
            
            let compEleventh = getCompositePoint(point1: (chart1.houseCusps.eleventh.value), point2: chart2.houseCusps.eleventh.value)
            
            let compTwelfth = getCompositePoint(point1: (chart1.houseCusps.twelfth.value), point2: chart2.houseCusps.twelfth.value)
            
            let compHouseDegree = [compFirst, compSecond, compThird, compFourth, compFifth, compSixth, compSeventh, compEighth, compNinth, compTenth, compEleventh, compTwelfth]
            
            return compHouseDegree
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
    

    
    
    func getCompHouseInfo() -> ([String], [Int], [Int], [Int]) {
        guard let chart1 = chartCake else { return ([String](), [Int](), [Int](), [Int]())  }
        guard let chart2 = otherChart else { return ([String](), [Int](), [Int](), [Int]())  }

        let compFirst = getCompositePoint(point1: (chart1.houseCusps.ascendent.value), point2: chart2.houseCusps.ascendent.value)
        
        let compSecond = getCompositePoint(point1: (chart1.houseCusps.second.value), point2: chart2.houseCusps.second.value)
        
        let compThird = getCompositePoint(point1: (chart1.houseCusps.third.value), point2: chart2.houseCusps.third.value)
        
        let compFourth = getCompositePoint(point1: (chart1.houseCusps.fourth.value), point2: chart2.houseCusps.fourth.value)
        
        let compFifth = getCompositePoint(point1: (chart1.houseCusps.fifth.value), point2: chart2.houseCusps.fifth.value)
        
        let compSixth = getCompositePoint(point1: (chart1.houseCusps.sixth.value), point2: chart2.houseCusps.sixth.value)
        
        let compSeventh = getCompositePoint(point1: (chart1.houseCusps.seventh.value), point2: chart2.houseCusps.seventh.value)
        
        let compEighth = getCompositePoint(point1: (chart1.houseCusps.eighth.value), point2: chart2.houseCusps.eighth.value)
        
        let compNinth = getCompositePoint(point1: (chart1.houseCusps.ninth.value), point2: chart2.houseCusps.ninth.value)
        
        let compTenth = getCompositePoint(point1: (chart1.houseCusps.tenth.value), point2: chart2.houseCusps.tenth.value)
        
        let compEleventh = getCompositePoint(point1: (chart1.houseCusps.eleventh.value), point2: chart2.houseCusps.eleventh.value)
        
        let compTwelfth = getCompositePoint(point1: (chart1.houseCusps.twelfth.value), point2: chart2.houseCusps.twelfth.value)

        var signs: [String] = []
        var degrees: [Int] = []
        var minutes: [Int] = []
        var seconds: [Int] = []

        let compSigns = [compFirst, compSecond, compThird, compFourth, compFifth, compSixth, compSeventh, compEighth, compNinth, compTenth, compEleventh, compTwelfth]

        for compSign in compSigns {
            let (sign, degree, minute, second) = convertToAstroCoordinates(degree: compSign)
            signs.append(sign)
            degrees.append(degree)
            minutes.append(minute)
            seconds.append(second)
        }

        return (signs, degrees, minutes, seconds)
    }
    
    private func getHouseCuspSign() -> [String] {
        
        
        let first = getCompHouseSigns()[0]
        let second = getCompHouseSigns()[1]
        let third = getCompHouseSigns()[2]
        let fourth = getCompHouseSigns()[3]
        let fifth = getCompHouseSigns()[4]
        let sixth = getCompHouseSigns()[5]
        let seventh = getCompHouseSigns()[6]
        let eighth = getCompHouseSigns()[7]
        let ninth = getCompHouseSigns()[8]
        let tenth = getCompHouseSigns()[9]
        let eleventh = getCompHouseSigns()[10]
        let twelfth = getCompHouseSigns()[11]
        
      //  print("Get House Cusps Names \(String(describing: getHouseCuspSign))")
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }
    

    func convertToAstroCoordinates(degree: Double) -> (String, Int, Int, Int) {
        let zodiacSigns = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
        let index = Int(degree / 30)
        let zodiacSign = zodiacSigns[index]
        
        let degreeInSign = degree.truncatingRemainder(dividingBy: 30)
        let degreeInt = Int(degreeInSign)
        
        let minuteFloat = (degreeInSign - Double(degreeInt)) * 60
        let minute = Int(minuteFloat)
        
        let second = Int((minuteFloat - Double(minute)) * 60)
        
        return (zodiacSign, degreeInt, minute, second)
    }

    
    func getCompositePoint(point1: Double, point2: Double) -> Double {
        var composite = (point1 + point2) / 2
        if abs(point1 - point2) > 180 {
            composite += 180
        }
        return composite > 360 ? composite - 360 : composite
    }

//
        
    func getCompPlanets() -> (compositePlanets: [String], compPlanets: [Double], compPlanetsDegree: [Double], compPlanetsSign: [String], compPlanetsMinute: [Double], compPlanetsSecond: [Double]) {
        guard let chart1 = chartCake else { return ([], [], [], [], [], []) }
        guard let chart2 = otherChart else { return ([], [], [], [], [], []) }

        let compSun = getCompositePoint(point1: chart1.natal.sun.longitude, point2: chart2.natal.sun.longitude)
        let compMoon = getCompositePoint(point1: chart1.natal.moon.longitude, point2: chart2.natal.moon.longitude)
        let compMercury = getCompositePoint(point1: chart1.natal.mercury.longitude, point2: chart2.natal.mercury.longitude)
        let compVenus = getCompositePoint(point1: chart1.natal.venus.longitude, point2: chart2.natal.venus.longitude)
        let compMars = getCompositePoint(point1: chart1.natal.mars.longitude, point2: chart2.natal.mars.longitude)
        let compJupiter = getCompositePoint(point1: chart1.natal.jupiter.longitude, point2: chart2.natal.jupiter.longitude)
        let compSaturn = getCompositePoint(point1: chart1.natal.saturn.longitude, point2: chart2.natal.saturn.longitude)
        let compUranus = getCompositePoint(point1: chart1.natal.uranus.longitude, point2: chart2.natal.uranus.longitude)
        let compNeptune = getCompositePoint(point1: chart1.natal.neptune.longitude, point2: chart2.natal.neptune.longitude)
        let compPluto = getCompositePoint(point1: chart1.natal.pluto.longitude, point2: chart2.natal.pluto.longitude)
        let compAsc = getCompositePoint(point1: chart1.houseCusps.ascendent.value, point2: chart2.houseCusps.ascendent.value)
        let compSNode = getCompositePoint(point1: chart1.natal.southNode.longitude, point2: chart2.natal.southNode.longitude)
            
            
        let compSunSign = Zodiac(rawValue: Int(compSun / 30))!.keyName
            
            let compMoonSign = Zodiac(rawValue: Int(compMoon / 30))!.keyName
            let compRisingSign = Zodiac(rawValue: Int(compAsc / 30))!.keyName
            let compMercurySign = Zodiac(rawValue: Int(compMercury / 30))!.keyName
            let compVenusSign = Zodiac(rawValue: Int(compVenus / 30))!.keyName
            let compMarsSign = Zodiac(rawValue: Int(compMars / 30))!.keyName
            let compJupiterSign = Zodiac(rawValue: Int(compJupiter / 30))!.keyName
            let compSaturnSign = Zodiac(rawValue: Int(compSaturn / 30))!.keyName
            
            let compUranusSign = Zodiac(rawValue: Int(compUranus / 30))!.keyName
            let compNeptuneSign = Zodiac(rawValue: Int(compNeptune / 30))!.keyName
            let compPlutoSign = Zodiac(rawValue: Int(compPluto / 30))!.keyName
        let compSNodeSign = Zodiac(rawValue: Int(compSNode / 30))!.keyName
            
            print(compSNodeSign)
            
            let compSunDegree = compSun.truncatingRemainder(dividingBy: 30)
            
            let compMoonDegree = compMoon.truncatingRemainder(dividingBy: 30)
            let compRisingDegree = compAsc.truncatingRemainder(dividingBy: 30)
            let compMercuryDegree = compMercury.truncatingRemainder(dividingBy: 30)
            let compVenusDegree = compVenus.truncatingRemainder(dividingBy: 30)
            let compMarsDegree = compMars.truncatingRemainder(dividingBy: 30)
            let compJupiterDegree = compJupiter.truncatingRemainder(dividingBy: 30)
            let compSaturnDegree = compSaturn.truncatingRemainder(dividingBy: 30)
            
            let compUranusDegree = compUranus.truncatingRemainder(dividingBy: 30)
            let compNeptuneDegree = compNeptune.truncatingRemainder(dividingBy: 30)
            let compPlutoDegree = compPluto.truncatingRemainder(dividingBy: 30)
        let compSNodeDegree = compSNode.truncatingRemainder(dividingBy: 30)
            
            let compSunMinute = compSun.truncatingRemainder(dividingBy: 1) * 60
            let compRisingMinute = compAsc.truncatingRemainder(dividingBy: 1) * 60
            let compMoonMinute = compMoon.truncatingRemainder(dividingBy: 1) * 60
            let compMercuryMinute = compMercury.truncatingRemainder(dividingBy: 1) * 60
            let compVenusMinute = compVenus.truncatingRemainder(dividingBy: 1) * 60
            let compMarsMinute = compMars.truncatingRemainder(dividingBy: 1) * 60
            let compJupiterMinute = compJupiter.truncatingRemainder(dividingBy: 1) * 60
            let compSaturnMinute = compSaturn.truncatingRemainder(dividingBy: 1) * 60
            
            let compUranusMinute = compUranus.truncatingRemainder(dividingBy: 1) * 60
            let compNeptuneMinute = compNeptune.truncatingRemainder(dividingBy: 1) * 60
            let compPlutoMinute = compPluto.truncatingRemainder(dividingBy: 1) * 60
        let compSNodeMinute = compSNode.truncatingRemainder(dividingBy: 1) * 60
            
            let compSunSecond = compSunMinute.truncatingRemainder(dividingBy: 1) * 60
            
            let compMoonSecond = compMoonMinute.truncatingRemainder(dividingBy: 1) * 60
            let compRisingSecond = compRisingMinute.truncatingRemainder(dividingBy: 1) * 60
            let compMercurySecond = compMercuryMinute.truncatingRemainder(dividingBy: 1) * 60
            let compVenusSecond = compVenusMinute.truncatingRemainder(dividingBy: 1) * 60
            let compMarsSecond = compMarsMinute.truncatingRemainder(dividingBy: 1) * 60
            let compJupiterSecond = compJupiterMinute.truncatingRemainder(dividingBy: 1) * 60
            let compSaturnSecond = compSaturnMinute.truncatingRemainder(dividingBy: 1) * 60
            
            let compUranusSecond = compUranusMinute.truncatingRemainder(dividingBy: 1) * 60
            let compNeptuneSecond = compNeptuneMinute.truncatingRemainder(dividingBy: 1) * 60
            let compPlutoSecond = compPlutoMinute.truncatingRemainder(dividingBy: 1) * 60
        let compSNodeSecond = compSNodeMinute.truncatingRemainder(dividingBy: 1) * 60
            
            
            
            //print(compositePlanetsSign)
            
            
            
            
            let compSunFormatted =  "\(Int(compSunDegree)) Degrees " + "\(compSunSign) " + "\(Int(compSunMinute))' " +
            "\(Int(compSunSecond))''"
            let compMoonFormatted = "\(Int(compMoonDegree)) Degrees " + "\(compMoonSign) " + "\(Int(compMoonMinute))' " +
            "\(Int(compMoonSecond))''"
            
            let compRisingFormatted = "\(Int(compRisingDegree)) Degrees " + "\(compRisingSign) " + "\(Int(compRisingMinute))' " +
            "\(Int(compRisingSecond))''"
            let compMercuryFormatted = "\(Int(compMercuryDegree)) Degrees " + "\(compMercurySign) " + "\(Int(compMercuryMinute))' " +
            "\(Int(compMercurySecond))''"
            let compVenusFormatted = "\(Int(compVenusDegree)) Degrees " + "\(compVenusSign) " + "\(Int(compVenusMinute))' " +
            "\(Int(compVenusSecond))''"
            let compMarsFormatted = "\(Int(compMarsDegree)) Degrees " + "\(compMarsSign) " + "\(Int(compMarsMinute))' " +
            "\(Int(compMarsSecond))''"
            let compJupiterFormatted = "\(Int(compJupiterDegree)) Degrees " + "\(compJupiterSign) " + "\(Int(compJupiterMinute))' " +
            "\(Int(compJupiterSecond))''"
            let compSaturnFormatted = "\(Int(compSaturnDegree)) Degrees " + "\(compSaturnSign) " + "\(Int(compSaturnMinute))' " +
            "\(Int(compSaturnSecond))''"
            let compUranusFormatted = "\(Int(compUranusDegree)) Degrees " + "\(compUranusSign) " + "\(Int(compUranusMinute))' " +
            "\(Int(compUranusSecond))''"
            let compNeptuneFormatted = "\(Int(compNeptuneDegree)) Degrees " + "\(compNeptuneSign) " + "\(Int(compNeptuneMinute))' " +
            "\(Int(compNeptuneSecond))''"
            let compPlutoFormatted = "\(Int(compPlutoDegree)) Degrees " + "\(compPlutoSign) " + "\(Int(compPlutoMinute))' " +
            "\(Int(compPlutoSecond))''"

        let compSNodeFormatted = "\(Int(compSNodeDegree)) Degrees " + "\(compSNodeSign) " + "\(Int(compSNodeMinute))' " +
        "\(Int(compSNodeSecond))''"
            
            //        "\(Int(minute))' " +
            //        "\(Int(second))''"
            
            
            let CompositePlanets = [compSunFormatted,compMoonFormatted,compRisingFormatted, compMercuryFormatted,compVenusFormatted,compMarsFormatted,compJupiterFormatted,compSaturnFormatted,compUranusFormatted,compNeptuneFormatted,compPlutoFormatted, compSNodeFormatted]
            
            let compPlanets = [compSun,compMoon,compMercury,compVenus,compMars,compJupiter,compSaturn,compUranus,compNeptune,compPluto,compSNode]
            
            let compPlanetsDegree = [compSunDegree,compMoonDegree
                                     ,compMercuryDegree,compVenusDegree,compMarsDegree,compJupiterDegree,compSaturnDegree,compUranusDegree,compNeptuneDegree,compPlutoDegree,compSNodeDegree]
            
            let compPlanetsMinute = [compSunMinute,compMoonMinute
                                     ,compMercuryMinute,compVenusMinute,compMarsMinute,compJupiterMinute,compSaturnMinute,compUranusMinute,compNeptuneMinute,compPlutoMinute,compSNodeMinute]
            
            
            let compPlanetsSecond = [compSunSecond,compMoonSecond
                                     ,compMercurySecond,compVenusSecond,compMarsSecond,compJupiterSecond,compSaturnSecond,compUranusSecond,compNeptuneSecond,compPlutoSecond,compSNodeSecond]
            
            
            let compPlanetsSign = [compSunSign,compMoonSign,compRisingSign,compMercurySign,compVenusSign,compMarsSign,compJupiterSign,compSaturnSign,compUranusSign,compNeptuneSign,compPlutoSign,compSNodeSign]
            
            return (CompositePlanets, compPlanets, compPlanetsDegree, compPlanetsSign, compPlanetsSecond, compPlanetsMinute)
        }
        
    func calculateAspects() {
        let compPlanetValues = getCompPlanetsValue()

        for index1 in 0..<compPlanetValues.count {
            let planet1 = compPlanetValues[index1]
            
            for index2 in (index1 + 1)..<compPlanetValues.count {
                let planet2 = compPlanetValues[index2]
                
                let aspect = Aspect(a: planet1, b: planet2, orb: 1)
                
                if let aspect = aspect {
                 //    The initialization was successful
                    print("Aspect between planet \(planet1) and planet \(planet2): \(aspect)")
                } else {
                  //   The initialization failed
                    print("Invalid aspect values for planet \(index1) and planet \(index2).")
                }
            }
        }
    }

        
    }

