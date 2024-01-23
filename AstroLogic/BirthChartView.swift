//
//  BirthChartView.swift
//  AstroLogic2
//

import UIKit
import SwiftEphemeris


class BirthChartView: UIView {
    var planetPositions: [CelestialObject: CGFloat] = [:]
    var chart: Chart?
    var chartCake: ChartCake?
    init(frame: CGRect, chartCake: ChartCake) {
        self.chartCake = chartCake
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
        print(getHousesCuspLongitude())
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
        let houseDistances = getHousesDistances()
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

        guard let chartCake = chartCake else {
            return
        }
        let natal = chartCake.natal

        let planetDegree: [(planet: CelestialObject, degree: String)] = [
            (.planet(.sun), "\(Int(natal.sun.degree))°"),
            (.planet(.moon), "\(Int(natal.moon.degree))°"),
            (.planet(.mercury), "\(Int(natal.mercury.degree))°"),
            (.planet(.venus), "\(Int(natal.venus.degree))°"),
            (.planet(.mars), "\(Int(natal.mars.degree))°"),
            (.planet(.jupiter), "\(Int(natal.jupiter.degree))°"),
            (.planet(.saturn), "\(Int(natal.saturn.degree))°"),
            (.planet(.uranus), "\(Int(natal.uranus.degree))°"),
            (.planet(.neptune), "\(Int(natal.neptune.degree))°"),
            (.planet(.pluto), "\(Int(natal.pluto.degree))°"),
            (.lunarNode(.meanSouthNode), "\(Int(natal.southNode.degree))°")
        ]

        let planetSignSymbols: [(planet: CelestialObject, imageName: String)] = [
            (.planet(.sun), natal.sun.sign.keyName),
            (.planet(.moon), natal.moon.sign.keyName),
            (.planet(.mercury), natal.mercury.sign.keyName),
            (.planet(.venus), natal.venus.sign.keyName),
            (.planet(.mars), natal.mars.sign.keyName),
            (.planet(.jupiter), natal.jupiter.sign.keyName),
            (.planet(.saturn), natal.saturn.sign.keyName),
            (.planet(.uranus), natal.uranus.sign.keyName),
            (.planet(.neptune), natal.neptune.sign.keyName),
            (.planet(.pluto), natal.pluto.sign.keyName),
            (.lunarNode(.meanSouthNode), natal.southNode.sign.keyName)
        ]


        let planetMinute: [(planet: CelestialObject, minute: String)] = [
            (.planet(.sun), "\(Int(natal.sun.minute))°"),
            (.planet(.moon), "\(Int(natal.moon.minute))°"),
            (.planet(.mercury), "\(Int(natal.mercury.minute))°"),
            (.planet(.venus), "\(Int(natal.venus.minute))°"),
            (.planet(.mars), "\(Int(natal.mars.minute))°"),
            (.planet(.jupiter), "\(Int(natal.jupiter.minute))°"),
            (.planet(.saturn), "\(Int(natal.saturn.minute))°"),
            (.planet(.uranus), "\(Int(natal.uranus.minute))°"),
            (.planet(.neptune), "\(Int(natal.neptune.minute))°"),
            (.planet(.pluto), "\(Int(natal.pluto.minute))°"),
            (.lunarNode(.meanSouthNode), "\(Int(natal.southNode.minute))°")
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

        for (index, (celestialObject, imageName)) in sortedPlanetSymbols.enumerated() {
              guard let position = planetPositions[celestialObject] else { continue }
              let angle = 2 * .pi - (position * .pi / 180) + .pi
              let radius = min(bounds.width, bounds.height) * 0.46 - 20 // Adjust the offset for each layer
              let center = CGPoint(x: bounds.midX, y: bounds.midY)
              let symbolCenterX = center.x + cos(angle) * radius
              let symbolCenterY = center.y + sin(angle) * radius

              let symbolSize = min(bounds.width, bounds.height) / 30
              let symbolRect = CGRect(x: symbolCenterX - symbolSize / 2, y: symbolCenterY - symbolSize / 2, width: symbolSize, height: symbolSize)

              if let image = UIImage(named: imageName) {
                  image.draw(in: symbolRect)
              }

              // Draw degrees and minutes text labels next to each symbol, ensuring no overlap
              let degree = sortedPlanetDegree[index].degree
              let minute = sortedPlanetMinute[index].minute
              
              // Draw the degree label
              drawTextLabel(context: context, text: degree, angle: angle, radius: radius - symbolSize, center: center, fontSize: adjustedFontSize(for: 9))

              // Draw the sign symbol
              let signImageName = sortedPlanetSignSymbol[index].imageName
              drawSignSymbol(context: context, imageName: signImageName, angle: angle, radius: radius - symbolSize * 2, center: center)

              // Draw the minute label
              drawTextLabel(context: context, text: minute, angle: angle, radius: radius - symbolSize * 3, center: center, fontSize: adjustedFontSize(for: 6))
          }
      }

      // Helper method to draw text labels at a given angle and radius from the center
      private func drawTextLabel(context: CGContext, text: String, angle: CGFloat, radius: CGFloat, center: CGPoint, fontSize: CGFloat) {
          let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.alignment = .center
          let attributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: fontSize),
              .paragraphStyle: paragraphStyle,
              .foregroundColor: UIColor.white
          ]
          
          let attributedText = NSAttributedString(string: text, attributes: attributes)
          let textSize = attributedText.size()
          let textCenterX = center.x + cos(angle) * radius - textSize.width / 2
          let textCenterY = center.y + sin(angle) * radius - textSize.height / 2
          let textRect = CGRect(x: textCenterX, y: textCenterY, width: textSize.width, height: textSize.height)
          attributedText.draw(in: textRect)
      }
    

      // Helper method to draw sign symbols
      private func drawSignSymbol(context: CGContext, imageName: String, angle: CGFloat, radius: CGFloat, center: CGPoint) {
          if let image = UIImage(named: imageName) {
              let imageSize = min(bounds.width, bounds.height) / 40
              let imageCenterX = center.x + cos(angle) * radius - imageSize / 2
              let imageCenterY = center.y + sin(angle) * radius - imageSize / 2
              let imageRect = CGRect(x: imageCenterX, y: imageCenterY, width: imageSize, height: imageSize)
              image.draw(in: imageRect)
          }
      }

  
    
    
    func updatePlanetPositions(newPositions: [CelestialObject: CGFloat]) {
        planetPositions = newPositions
        setNeedsDisplay()
    }

    func updateBirthChart() {
        let ascendantOffset = getHouses()[0]

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
        guard let chartCake = chartCake else {
            return [CGFloat]()
        }

        let natal = chartCake.natal
        let sunPosition = natal.sun.value
        let moonPosition = natal.moon.value
        let mercuryPosition = natal.mercury.value
        let venusPosition = natal.venus.value
        let marsPosition = natal.mars.value
        let jupiterPosition = natal.jupiter.value
        let saturnPosition = natal.saturn.value
        let uranusPosition = natal.uranus.value
        let neptunePosition = natal.neptune.value
        let plutoPosition = natal.pluto.value
//        let northNodePosition = chartCake!.natal.northNode.value
        let southNodePosition = natal.southNode.value

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
