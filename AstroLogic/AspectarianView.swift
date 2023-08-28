//import UIKit
//import SwiftEphemeris
//
//class AspectarianView: UIView {
//    private let chart: Chart
//  
//  //  private var aspects: [AstroAspect] = []
//
//    let planetNames = ["sun", "moon", "mercury", "venus", "mars", "jupiter", "saturn", "uranus", "neptune", "pluto", "s.node","ascendant", "midheaven", "northnode", "midheaven"]
//
//    init(frame: CGRect, chart: Chart) {
//        self.chart = chart
//     
//        super.init(frame: frame)
////        setupView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//   
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//
//        drawZodiacSquareGrid2(context: context)
//    }
//
////    func printAspectSymbols() {
////          for aspect in aspects {
////              if let symbol = aspect.symbol {
////                  print("Aspect Symbol: \(symbol)")
////              }
////          }
////      }
//      
////  func setupView() {
////      aspects = getAllNatalAspects(birthChart: chart, date: selectedDate)
////          printAspectSymbols() // Print the aspect symbols
////      }
//
//    
//    private func drawZodiacSquareGrid2(context: CGContext) {
//        let side = max(bounds.width, bounds.height) * 0.99
//        let compartmentSide = side / 14
//        let imageSide = compartmentSide * 0.8
//        let offsetX = (bounds.width - side) / 2 + compartmentSide
//        let offsetY = (bounds.height - side) / 2 + compartmentSide
//
//        context.setStrokeColor(UIColor.white.cgColor)
//        context.setLineWidth(0.1)
//
//        for i in 0..<13 {
//            for j in 0..<13 {
//                let originX = offsetX + compartmentSide * CGFloat(i)
//                let originY = offsetY + compartmentSide * CGFloat(j)
//
//                if i == j { // If it's a diagonal cell
//                    context.setFillColor(UIColor.white.withAlphaComponent(0.5).cgColor) // Set the fill color to white with 50% opacity
//                    context.fill(CGRect(x: originX, y: originY, width: compartmentSide, height: compartmentSide)) // Fill the cell with color
//                }
//
//                context.addRect(CGRect(x: originX, y: originY, width: compartmentSide, height: compartmentSide))
//                context.strokePath()
//            }
//        }
//
//        drawGrid(context: context, offsetX: offsetX, offsetY: offsetY, compartmentSide: compartmentSide, imageSide: imageSide)
//    }
//
//    
//
//    private func drawGrid(context: CGContext, offsetX: CGFloat, offsetY: CGFloat, compartmentSide: CGFloat, imageSide: CGFloat) {
//        context.setStrokeColor(UIColor.white.cgColor)
//        context.setLineWidth(0.3)
//
//        for i in 0..<14 { // Adjusted to draw an extra line
//            let x = offsetX + compartmentSide * CGFloat(i)
//            let y = offsetY + compartmentSide * CGFloat(i)
//
//            context.move(to: CGPoint(x: offsetX, y: y))
//            context.addLine(to: CGPoint(x: offsetX + compartmentSide * 14, y: y)) // Adjusted to extend to the extra line
//                
//            context.move(to: CGPoint(x: x, y: offsetY))
//            context.addLine(to: CGPoint(x: x, y: offsetY + compartmentSide * 14)) // Adjusted to extend to the extra line
//        }
//
//        for i in 0..<14 { // Adjusted to include the midheaven
//            if let planetImage = UIImage(named: planetNames[i].lowercased()) {
//                let dx = offsetX + compartmentSide * CGFloat(i) + (compartmentSide - imageSide) / 2
//                let dy = offsetY - compartmentSide + (compartmentSide - imageSide) / 2
//                planetImage.draw(in: CGRect(x: dx, y: dy, width: imageSide, height: imageSide))
//
//                let dx2 = offsetX - compartmentSide + (compartmentSide - imageSide) / 2
//                let dy2 = offsetY + compartmentSide * CGFloat(i) + (compartmentSide - imageSide) / 2
//                planetImage.draw(in: CGRect(x: dx2, y: dy2, width: imageSide, height: imageSide))
//            }
//        }
//    }
//
//}
