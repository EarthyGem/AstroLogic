//import SwiftEphemeris
//import UIKit
//
//class AspectsViewController: UIViewController {
//    private let chart: Chart
//    private let selectedDate: Date
//
//    init(chart: chart, selectedDate: Date) {
//        self.chart = chart
//        self.selectedDate = selectedDate
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//        let screenWidth = UIScreen.main.bounds.width
//        let aspectarianView = AspectarianView(frame: CGRect(x: 5, y: 200, width: screenWidth - 50, height: screenWidth - 50), chart: chart, selectedDate: selectedDate)
//        view.addSubview(aspectarianView)
//
//        let aspects = getAllNatalAspects(birthChart: chart, date: selectedDate)
//        printAspectSymbols(aspects: aspects)
//    }
//
//    func printAspectSymbols(aspects: [AstroAspect]) {
//        for aspect in aspects {
//            if let symbol = aspect.symbol {
//             //   print("\(aspect.planet1.formatted) \(symbol) \(aspect.planet2.formatted) with an orb of \(aspect.orb)")
//            }
//        }
//    }
//}
//
