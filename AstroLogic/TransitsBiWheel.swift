import UIKit
import SwiftEphemeris


class TransitBiWheelChartView: UIView {
    var chartCake: ChartCake!
    var chart: Chart!
//    var transitChart: ChartCake!
//
    var planetPositions: [CelestialObject: CGFloat] = [:]
    var transitPlanetPositions: [CelestialObject: CGFloat] = [:]



    init(frame: CGRect, chartCake: ChartCake) {
            self.chartCake = chartCake

            super.init(frame: frame)
            setupGestureRecognizers()
            updateChart()
        updateTransitChart()
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
            context.setLineWidth(0.3)
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
        let houseDistances = getHouses2()
        let houseCuspSignNames = getHouseNames()

        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.3)
        context.setLineCap(.round)
        context.setLineJoin(.round)


        var accumulatedAngle: CGFloat = 0

        for index in 0..<12 {
            let angle = 2 * .pi - ((accumulatedAngle + houseDistances[index] ) * .pi / 180) + .pi
            let startX = center.x + cos(angle) * (0.21 * radius)
            let startY = center.y + sin(angle) * (0.21 * radius)

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
            print("House \(index + 1): Degree \(Int(houseDegrees[index]))°, Minute \(Int(houseMinutes[index]))'")





            // Add the planet number label
            let houseNumberLabel = UILabel()
            houseNumberLabel.textColor = .white
            houseNumberLabel.textAlignment = .center
            houseNumberLabel.text = "\((index + 1) % 12 + 1)"
            houseNumberLabel.font = UIFont.systemFont(ofSize: 10)
            houseNumberLabel.sizeToFit()
            let labelRadius = (0.21 + 0.28) / 2 * radius
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

            houseDegreeLabel.font = UIFont.systemFont(ofSize: 10)
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

            houseMinuteLabel.font = UIFont.systemFont(ofSize: 8)
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


    private func drawTransitZodiacCircle(context: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.34
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(0.3)
        context.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        context.strokePath()


    }



        private func getHouses1() -> [CGFloat] {

            let first = chartCake!.natal.houseCusps.first.value
            let second = chartCake!.natal.houseCusps.second.value
            let third = chartCake!.natal.houseCusps.third.value
            let fourth = chartCake!.natal.houseCusps.fourth.value
            let fifth = chartCake!.natal.houseCusps.fifth.value
            let sixth = chartCake!.natal.houseCusps.sixth.value
            let seventh = chartCake!.natal.houseCusps.seventh.value
            let eighth = chartCake!.natal.houseCusps.eighth.value
            let ninth = chartCake!.natal.houseCusps.ninth.value
            let tenth = chartCake!.natal.houseCusps.tenth.value
            let eleventh = chartCake!.natal.houseCusps.eleventh.value
            let twelfth = chartCake!.natal.houseCusps.twelfth.value

            return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
        }

        private func getHousesDegree() -> [CGFloat] {

            let first = chartCake!.natal.houseCusps.first.degree
            let second = chartCake!.natal.houseCusps.second.degree
            let third = chartCake!.natal.houseCusps.third.degree
            let fourth = chartCake!.natal.houseCusps.fourth.degree
            let fifth = chartCake!.natal.houseCusps.fifth.degree
            let sixth = chartCake!.natal.houseCusps.sixth.degree
            let seventh = chartCake!.natal.houseCusps.seventh.degree
            let eighth = chartCake!.natal.houseCusps.eighth.degree
            let ninth = chartCake!.natal.houseCusps.ninth.degree
            let tenth = chartCake!.natal.houseCusps.tenth.degree
            let eleventh = chartCake!.natal.houseCusps.eleventh.degree
            let twelfth = chartCake!.natal.houseCusps.twelfth.degree

            return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
        }


        private func getHousesMinute() -> [CGFloat] {

            let first = chartCake!.natal.houseCusps.first.minute
            let second = chartCake!.natal.houseCusps.second.minute
            let third = chartCake!.natal.houseCusps.third.minute
            let fourth = chartCake!.natal.houseCusps.fourth.minute
            let fifth = chartCake!.natal.houseCusps.fifth.minute
            let sixth = chartCake!.natal.houseCusps.sixth.minute
            let seventh = chartCake!.natal.houseCusps.seventh.minute
            let eighth = chartCake!.natal.houseCusps.eighth.minute
            let ninth = chartCake!.natal.houseCusps.ninth.minute
            let tenth = chartCake!.natal.houseCusps.tenth.minute
            let eleventh = chartCake!.natal.houseCusps.eleventh.minute
            let twelfth = chartCake!.natal.houseCusps.twelfth.minute

            return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
        }


        private func getHouseNames() -> [String] {

            let first = chartCake!.natal.houseCusps.first.sign.keyName
            let second = chartCake!.natal.houseCusps.second.sign.keyName
            let third = chartCake!.natal.houseCusps.third.sign.keyName
            let fourth = chartCake!.natal.houseCusps.fourth.sign.keyName
            let fifth = chartCake!.natal.houseCusps.fifth.sign.keyName
            let sixth = chartCake!.natal.houseCusps.sixth.sign.keyName
            let seventh = chartCake!.natal.houseCusps.seventh.sign.keyName
            let eighth = chartCake!.natal.houseCusps.eighth.sign.keyName
            let ninth = chartCake!.natal.houseCusps.ninth.sign.keyName
            let tenth = chartCake!.natal.houseCusps.tenth.sign.keyName
            let eleventh = chartCake!.natal.houseCusps.eleventh.sign.keyName
            let twelfth = chartCake!.natal.houseCusps.twelfth.sign.keyName

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
                (.planet(.sun), "\(Int(chartCake!.natal.sun.degree))°"),
                (.planet(.moon), "\(Int(chartCake!.natal.moon.degree))°"),
                (.planet(.mercury), "\(Int(chartCake!.natal.mercury.degree))°"),
                (.planet(.venus), "\(Int(chartCake!.natal.venus.degree))°"),
                (.planet(.mars), "\(Int(chartCake!.natal.mars.degree))°"),
                (.planet(.jupiter), "\(Int(chartCake!.natal.jupiter.degree))°"),
                (.planet(.saturn), "\(Int(chartCake!.natal.saturn.degree))°"),
                (.planet(.uranus), "\(Int(chartCake!.natal.uranus.degree))°"),
                (.planet(.neptune), "\(Int(chartCake!.natal.neptune.degree))°"),
                (.planet(.pluto), "\(Int(chartCake!.natal.pluto.degree))°"),
                (.lunarNode(.meanSouthNode), "\(Int(chartCake!.natal.southNode.degree))°")

            ]

            let planetSignSymbols: [(planet: CelestialObject, imageName: String)] = [
                (.planet(.sun), chartCake!.natal.sun.sign.keyName),
                (.planet(.moon), chartCake!.natal.moon.sign.keyName),
                (.planet(.mercury), chartCake!.natal.mercury.sign.keyName),
                (.planet(.venus), chartCake!.natal.venus.sign.keyName),
                (.planet(.mars), chartCake!.natal.mars.sign.keyName),
                (.planet(.jupiter), chartCake!.natal.jupiter.sign.keyName),
                (.planet(.saturn), chartCake!.natal.saturn.sign.keyName),
                (.planet(.uranus), chartCake!.natal.uranus.sign.keyName),
                (.planet(.neptune), chartCake!.natal.neptune.sign.keyName),
                (.planet(.pluto), chartCake!.natal.pluto.sign.keyName),
                (.lunarNode(.meanSouthNode), chartCake!.natal.southNode.sign.keyName)

            ]


            let planetMinute: [(planet: CelestialObject, minute: String)] = [
                (.planet(.sun), "\(Int(chartCake!.natal.sun.minute))°"),
                (.planet(.moon), "\(Int(chartCake!.natal.moon.minute))°"),
                (.planet(.mercury), "\(Int(chartCake!.natal.mercury.minute))°"),
                (.planet(.venus), "\(Int(chartCake!.natal.venus.minute))°"),
                (.planet(.mars), "\(Int(chartCake!.natal.mars.minute))°"),
                (.planet(.jupiter), "\(Int(chartCake!.natal.jupiter.minute))°"),
                (.planet(.saturn), "\(Int(chartCake!.natal.saturn.minute))°"),
                (.planet(.uranus), "\(Int(chartCake!.natal.uranus.minute))°"),
                (.planet(.neptune), "\(Int(chartCake!.natal.neptune.minute))°"),
                (.planet(.pluto), "\(Int(chartCake!.natal.pluto.minute))°"),
                (.lunarNode(.meanSouthNode), "\(Int(chartCake!.natal.southNode.minute))°")

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
                let radius = min(bounds.width, bounds.height) * 0.35 - 18
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

                let degreeLabelRadius = min(bounds.width, bounds.height) * 0.34 - 32
                var lastDegreeLabelCenter: CGPoint? = nil
                var lastDegreeLabelCelestialObject: CelestialObject? = nil
                let minLabelDistance: CGFloat = 20
                for (_, (celestialObject, degree)) in sortedPlanetDegree.enumerated() {
                    guard let position = planetPositions[celestialObject] else { continue }

                    let degreeLabel = UILabel()
                    degreeLabel.textColor = .white
                    degreeLabel.textAlignment = .center
                    degreeLabel.text = degree
                    degreeLabel.font = UIFont.systemFont(ofSize: 9)
                    degreeLabel.sizeToFit()

                    let degreeLabelCenter = calculateNonOverlappingPosition(celestialObject: celestialObject, position: position, radius: degreeLabelRadius, lastSymbolCenter: &lastDegreeLabelCenter, lastCelestialObject: &lastDegreeLabelCelestialObject, minSymbolDistance: minLabelDistance)
                    degreeLabel.center = degreeLabelCenter
                    addSubview(degreeLabel)
                }



                let signSymbolLabelRadius = min(bounds.width, bounds.height) * 0.34 - 49
                var lastSignSymbolLabelCenter: CGPoint? = nil
                var lastSignSymbolLabelCelestialObject: CelestialObject? = nil

                for (_, (celestialObject, imageName)) in sortedPlanetSignSymbol.enumerated() {
                    guard let position = planetPositions[celestialObject] else { continue }
                    let angle = 2 * .pi - (position * .pi / 180) + .pi
                    let radius = min(bounds.width, bounds.height) * 0.34 - 49
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


                let minuteLabelRadius = min(bounds.width, bounds.height) * 0.34 - 62
                var lastMinuteLabelCenter: CGPoint? = nil
                var lastMinuteLabelCelestialObject: CelestialObject? = nil

                for (_, (celestialObject, minute)) in sortedPlanetMinute.enumerated() {
                    guard let position = planetPositions[celestialObject] else { continue }

                    let minuteLabel = UILabel()
                    minuteLabel.textColor = .white
                    minuteLabel.textAlignment = .center
                    minuteLabel.text = minute
                    minuteLabel.font = UIFont.systemFont(ofSize: 6)
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
            (.planet(.sun), "\(Int(chartCake!.transits.sun.degree))°"),
            (.planet(.moon), "\(Int(chartCake!.transits.moon.degree))°"),
            (.planet(.mercury), "\(Int(chartCake!.transits.mercury.degree))°"),
            (.planet(.venus), "\(Int(chartCake!.transits.venus.degree))°"),
            (.planet(.mars), "\(Int(chartCake!.transits.mars.degree))°"),
            (.planet(.jupiter), "\(Int(chartCake!.transits.jupiter.degree))°"),
            (.planet(.saturn), "\(Int(chartCake!.transits.saturn.degree))°"),
            (.planet(.uranus), "\(Int(chartCake!.transits.uranus.degree))°"),
            (.planet(.neptune), "\(Int(chartCake!.transits.neptune.degree))°"),
            (.planet(.pluto), "\(Int(chartCake!.transits.pluto.degree))°"),
            (.lunarNode(.meanSouthNode), "\(Int(chartCake!.transits.southNode.degree))°")

        ]

        let planetSignSymbols: [(planet: CelestialObject, imageName: String)] = [
            (.planet(.sun), chartCake!.transits.sun.sign.keyName),
            (.planet(.moon), chartCake!.transits.moon.sign.keyName),
            (.planet(.mercury), chartCake!.transits.mercury.sign.keyName),
            (.planet(.venus), chartCake!.transits.venus.sign.keyName),
            (.planet(.mars), chartCake!.transits.mars.sign.keyName),
            (.planet(.jupiter), chartCake!.transits.jupiter.sign.keyName),
            (.planet(.saturn), chartCake!.transits.saturn.sign.keyName),
            (.planet(.uranus), chartCake!.transits.uranus.sign.keyName),
            (.planet(.neptune), chartCake!.transits.neptune.sign.keyName),
            (.planet(.pluto), chartCake!.transits.pluto.sign.keyName),
            (.lunarNode(.meanSouthNode), chartCake!.transits.southNode.sign.keyName)

        ]


        let planetMinute: [(planet: CelestialObject, minute: String)] = [
            (.planet(.sun), "\(Int(chartCake!.transits.sun.minute))°"),
            (.planet(.moon), "\(Int(chartCake!.transits.moon.minute))°"),
            (.planet(.mercury), "\(Int(chartCake!.transits.mercury.minute))°"),
            (.planet(.venus), "\(Int(chartCake!.transits.venus.minute))°"),
            (.planet(.mars), "\(Int(chartCake!.transits.mars.minute))°"),
            (.planet(.jupiter), "\(Int(chartCake!.transits.jupiter.minute))°"),
            (.planet(.saturn), "\(Int(chartCake!.transits.saturn.minute))°"),
            (.planet(.uranus), "\(Int(chartCake!.transits.uranus.minute))°"),
            (.planet(.neptune), "\(Int(chartCake!.transits.neptune.minute))°"),
            (.planet(.pluto), "\(Int(chartCake!.transits.pluto.minute))°"),
            (.lunarNode(.meanSouthNode), "\(Int(chartCake!.transits.southNode.minute))°")

        ]


        let sortedPlanetSymbols = planetSymbols.sorted { (symbol1, symbol2) -> Bool in
            if let position1 = transitPlanetPositions[symbol1.planet], let position2 = transitPlanetPositions[symbol2.planet] {
                return position1 < position2
            }
            return false
        }

        let sortedPlanetDegree = planetDegree.sorted { (degree1, degree2) -> Bool in
            if let position1 = transitPlanetPositions[degree1.planet], let position2 = transitPlanetPositions[degree2.planet] {
                return position1 < position2
            }
            return false
        }

        let sortedPlanetSignSymbol = planetSignSymbols.sorted { (sign1, sign2) -> Bool in
            if let position1 = transitPlanetPositions[sign1.planet], let position2 = transitPlanetPositions[sign2.planet] {
                return position1 < position2
            }
            return false
        }

        let sortedPlanetMinute = planetMinute.sorted { (minute1, minute2) -> Bool in
            if let position1 = transitPlanetPositions[minute1.planet], let position2 = transitPlanetPositions[minute2.planet] {
                return position1 < position2
            }
            return false
        }


        let minSymbolDistance: CGFloat = 0 // Adjust this value to change the minimum distance
        var lastSymbolCenter: CGPoint? = nil
        var lastCelestialObject: CelestialObject? = nil

        for (_, (celestialObject, imageName)) in sortedPlanetSymbols.enumerated() {
            guard let position = transitPlanetPositions[celestialObject] else { continue }
            let angle = 2 * .pi - (position * .pi / 180) + .pi
            let radius = min(bounds.width, bounds.height) * 0.45 - 15
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            var centerX = center.x + cos(angle) * radius
            var centerY = center.y + sin(angle) * radius

            if let lastCenter = lastSymbolCenter, let lastPosition = lastCelestialObject.flatMap({ transitPlanetPositions[$0] }) {
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
                guard let position = transitPlanetPositions[celestialObject] else { continue }

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
                guard let position = transitPlanetPositions[celestialObject] else { continue }
                let angle = 2 * .pi - (position * .pi / 180) + .pi
                let radius = min(bounds.width, bounds.height) * 0.45 - 61
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let centerX = center.x + cos(angle) * radius
                let centerY = center.y + sin(angle) * radius

                let symbolSize = min(bounds.width, bounds.height) / 40
                let symbolImageView = UIImageView(image: UIImage(named: imageName))
                symbolImageView.contentMode = .scaleAspectFit
                symbolImageView.frame = CGRect(x: 0, y: 0, width: symbolSize, height: symbolSize)
                symbolImageView.center = CGPoint(x: centerX, y: centerY - symbolSize / 2 )
//                addSubview(symbolImageView)
            }

            for (_, (celestialObject, minute)) in sortedPlanetMinute.enumerated() {
                guard let position = transitPlanetPositions[celestialObject] else { continue }

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

    func transitCalculateNonOverlappingPosition(celestialObject: CelestialObject, position: CGFloat, radius: CGFloat, lastSymbolCenter: inout CGPoint?, lastCelestialObject: inout CelestialObject?, minSymbolDistance: CGFloat) -> CGPoint {
        let angle = 2 * .pi - (position * .pi / 180) + .pi
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var centerX = center.x + cos(angle) * radius
        var centerY = center.y + sin(angle) * radius

        if let lastCenter = lastSymbolCenter, let lastPosition = lastCelestialObject.flatMap({ transitPlanetPositions[$0] }) {
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

        func updateChart() {
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
            let sunPosition = chartCake!.natal.sun.value
            let moonPosition = chartCake!.natal.moon.value
            let mercuryPosition = chartCake!.natal.mercury.value
            let venusPosition = chartCake!.natal.venus.value
            let marsPosition = chartCake!.natal.mars.value
            let jupiterPosition = chartCake!.natal.jupiter.value
            let saturnPosition = chartCake!.natal.saturn.value
            let uranusPosition = chartCake!.natal.uranus.value
            let neptunePosition = chartCake!.natal.neptune.value
            let plutoPosition = chartCake!.natal.pluto.value
    //        let northNodePosition = chartCake!.natal.northNode.value
           let southNodePosition = chartCake!.natal.southNode.value

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


    func updateTransitPlanetPositions(newTransitPositions: [CelestialObject: CGFloat]) {
        transitPlanetPositions = newTransitPositions
        setNeedsDisplay()
    }

    func updateTransitChart() {
        let ascendantOffset = getHouses1()[0]

        let planetPositions: [CelestialObject: CGFloat] = [
            .planet(.sun): getTransitPlanets()[0] - ascendantOffset,
            .planet(.moon): getTransitPlanets()[1] - ascendantOffset,
            .planet(.mercury): getTransitPlanets()[2] - ascendantOffset,
            .planet(.venus): getTransitPlanets()[3] - ascendantOffset,
            .planet(.mars): getTransitPlanets()[4] - ascendantOffset,
            .planet(.jupiter): getTransitPlanets()[5] - ascendantOffset,
            .planet(.saturn): getTransitPlanets()[6] - ascendantOffset,
            .planet(.uranus): getTransitPlanets()[7] - ascendantOffset,
            .planet(.neptune): getTransitPlanets()[8] - ascendantOffset,
            .planet(.pluto): getTransitPlanets()[9] - ascendantOffset,
            .lunarNode(.meanSouthNode): getPlanets()[10] - ascendantOffset
        ]
        updateTransitPlanetPositions(newTransitPositions: planetPositions)
    }


    private func getTransitPlanets() -> [CGFloat] {
        let sunPosition = chartCake!.transits.sun.value
        let moonPosition = chartCake!.transits.moon.value
        let mercuryPosition = chartCake!.transits.mercury.value
        let venusPosition = chartCake!.transits.venus.value
        let marsPosition = chartCake!.transits.mars.value
        let jupiterPosition = chartCake!.transits.jupiter.value
        let saturnPosition = chartCake!.transits.saturn.value
        let uranusPosition = chartCake!.transits.uranus.value
        let neptunePosition = chartCake!.transits.neptune.value
        let plutoPosition = chartCake!.transits.pluto.value
//        let northNodePosition = chart!.northNode.value
        let southNodePosition = chartCake!.transits.southNode.value

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
