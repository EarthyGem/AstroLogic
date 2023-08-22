//
//  ListViewController.swift
//  TableviewPassData
//
//  Created by Afraz Siddiqui on 8/29/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
import SwiftEphemeris
import UIKit

class DeacanatesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chartCake: ChartCake?
    var chart: Chart?
    var birthChartView: BirthChartView!
    var strongestPlanet: String!
    var natalDecanates: [String] = []

    // ... Rest of your code ...
    
    func getPlanetOrder(strongestPlanet: String) -> [String] {
        var order: [String] = []
        let defaultOrder = ["sun", "moon", "ascendant", "mercury"]
        
        // Add the strongest planet to the order list
        order.append(strongestPlanet.lowercased())
        
        // Add the rest of the planets to the order list, excluding the strongest planet
        for planet in defaultOrder {
            if planet != strongestPlanet.lowercased() {
                order.append(planet)
            }
        }
        
        return order
    }

  

    func getNatalPositions() -> [String] {
        var positions: [String] = []
        
        // Get the order of the planets
        let planetOrder = getPlanetOrder(strongestPlanet: strongestPlanet)
        
        // Iterate over the planet order
        for planet in planetOrder {
            // Get the decanates for the current planet
            var decanates: String?
            switch planet {
            case "sun":
                decanates = chartCake!.natal.sun.decanates.formatted
            case "moon":
                decanates = chartCake!.natal.moon.decanates.formatted
            case "ascendant":
                decanates = chartCake!.natal.ascendant.decanates.formatted
            case "mercury":
                decanates = chartCake!.natal.mercury.decanates.formatted
            default:
                decanates = getDecanates(for: planet)
            }
            
            // Add the decanates to the positions array
            if let decanates = decanates {
                positions.append(decanates)
            }
        }
        
        return positions
    }
        

       
    func getDecanatesKeyword() -> [String] {
        var keywords: [String] = []
        
        // Get the order of the planets
        let planetOrder = getPlanetOrder(strongestPlanet: strongestPlanet)
        
        // Iterate over the planet order
        for planet in planetOrder {
            // Get the keyword for the current planet
            var keyword: String?
            switch planet {
            case "sun":
                keyword = chartCake!.natal.sun.decanates.keyWord
            case "moon":
                keyword = chartCake!.natal.moon.decanates.keyWord
            case "ascendant":
                keyword = chartCake!.natal.ascendant.decanates.keyWord
            case "mercury":
                keyword = chartCake!.natal.mercury.decanates.keyWord
            default:
                if let decanate = getDecanates(for: planet) {
                    keyword = getKeyword(for: decanate)
                }
            }
            
            // Add the keyword to the keywords array
            if let keyword = keyword {
                keywords.append(keyword)
            }
        }
        
        return keywords
    }
    
    func getDecanatesText() -> [String] {
        var texts: [String] = []
        
        // Get the order of the planets
        let planetOrder = getPlanetOrder(strongestPlanet: strongestPlanet)
        
        // Iterate over the planet order
        for planet in planetOrder {
            // Get the text for the current planet
            var text: String?
            switch planet {
            case "sun":
                text = chartCake!.natal.sun.decanates.spiritualText
            case "moon":
                text = chartCake!.natal.moon.decanates.spiritualText
            case "ascendant":
                text = chartCake!.natal.houseCusps.ascendent.decanates.spiritualText
            case "mercury":
                text = chartCake!.natal.mercury.decanates.spiritualText
            default:
                if let decanate = getDecanates(for: planet) {
                    text = getText(for: decanate)
                }
            }
            
            // Add the text to the texts array
            if let text = text {
                texts.append(text)
            }
        }
        
        return texts
    }

    
    func getDecanates(for planet: String) -> String? {
        switch planet {
        case "Sun":
            return chartCake!.natal.sun.decanates.formatted
        case "Moon":
            return chartCake!.natal.moon.decanates.formatted
        case "Mercury":
            return chartCake!.natal.mercury.decanates.formatted
        case "Venus":
            return chartCake!.natal.venus.decanates.formatted
        case "Mars":
            return chartCake!.natal.mars.decanates.formatted
        case "Jupiter":
            return chartCake!.natal.jupiter.decanates.formatted
        case "Saturn":
            return chartCake!.natal.saturn.decanates.formatted
        case "Uranus":
            return chartCake!.natal.uranus.decanates.formatted
        case "Neptune":
            return chartCake!.natal.neptune.decanates.formatted
        case "Pluto":
            return chartCake!.natal.pluto.decanates.formatted
        case "Ascendant":
            return chartCake!.natal.houseCusps.ascendent.decanates.formatted
        default:
            return nil
        }
    }

    func getKeyword(for planet: String) -> String? {
    
        
        switch planet {
   
        case "Sun":
            return chartCake!.natal.sun.decanates.keyWord
        case "Moon":
            return chartCake!.natal.moon.decanates.keyWord
        case "Mercury":
            return chartCake!.natal.mercury.decanates.keyWord
        case "Venus":
            return chartCake!.natal.venus.decanates.keyWord
        case "Mars":
            return chartCake!.natal.mars.decanates.keyWord
        case "Jupiter":
            return chartCake!.natal.jupiter.decanates.keyWord
        case "Saturn":
            return chartCake!.natal.saturn.decanates.keyWord
        case "Uranus":
            return chartCake!.natal.uranus.decanates.keyWord
        case "Neptune":
            return chartCake!.natal.neptune.decanates.keyWord
        case "Pluto":
            return chartCake!.natal.pluto.decanates.keyWord
        case "Ascendant":
            return chartCake!.natal.houseCusps.ascendent.decanates.keyWord
        default:
            return nil
        }
    }

    func getText(for planet: String) -> String? {
    
        
        switch planet {
   
        case "Sun":
            return chartCake!.natal.sun.decanates.spiritualText
        case "Moon":
            return chartCake!.natal.moon.decanates.spiritualText
        case "Mercury":
            return chartCake!.natal.mercury.decanates.spiritualText
        case "Venus":
            return chartCake!.natal.venus.decanates.spiritualText
        case "Mars":
            return chartCake!.natal.mars.decanates.spiritualText
        case "Jupiter":
            return chartCake!.natal.jupiter.decanates.spiritualText
        case "Saturn":
            return chartCake!.natal.saturn.decanates.spiritualText
        case "Uranus":
            return chartCake!.natal.uranus.decanates.spiritualText
        case "Neptune":
            return chartCake!.natal.neptune.decanates.spiritualText
        case "Pluto":
            return chartCake!.natal.pluto.decanates.spiritualText
        case "Ascendant":
            return chartCake!.natal.houseCusps.ascendent.decanates.formatted
        default:
            return nil
        }
    }

    
var planetGlyphs = ["sun","moon","","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto"]
    var segueIdentifiers = ["1","2","3","4","5","6","7","8","9","10","11","12"]

var mySunText = ""
    var myMoonText = ""
    var myAscText = ""
    var myMercuryText = ""
    var myVenusText = ""
    var myMarsText = ""
    var myJupiterText = ""
    var mySaturnText = ""
    var myUranusText = ""
    var myNeptuneText = ""
    var myPlutoText = ""
    var mySunText1 = ""
    var mySunText2 = ""
    var mySunText3 = ""
    var mySunText4 = ""

    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCellDeacnates.self, forCellReuseIdentifier: CustomTableViewCellDeacnates.identifier)
        return table
    }()

    private let planets: [String]

    // Init

    init(planets: [String]) {
        self.planets = planets
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .black
        let screenWidth = UIScreen.main.bounds.width
        let birthChartView = BirthChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!)
        print("StrongestPlanet: \(String(describing: strongestPlanet))")
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)
        
        view.addSubview(birthChartView)
        view.addSubview(tableView)
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight: CGFloat = view.bounds.height - 550 // Adjust the value according to your needs
           tableView.frame = CGRect(x: 10, y: 550, width: 380, height: tableViewHeight)
     
        
    }




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getPlanetOrder(strongestPlanet: strongestPlanet).count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCellDeacnates.identifier, for: indexPath) as? CustomTableViewCellDeacnates else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: "\(getPlanetOrder(strongestPlanet: strongestPlanet)[indexPath.row])", planetImageImageName: "\(getPlanetOrder(strongestPlanet: strongestPlanet)[indexPath.row])", signTextText: getNatalPositions()[indexPath.row], planetTextText: "\(getDecanatesKeyword()[indexPath.row])", headerTextText: "\(getDecanatesText()[indexPath.row])" )
        

        
         return cell
         
         
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print(planets[indexPath.row])
        

     
//        [MovingSunViewController(),MovingMoonController(),MovingAscendantController(),MovingMercuryController(),MovingVenusController(),MovingMarsController(),MovingJupiterController(),MovingSaturnController(),MovingUranusController(),MovingNeptuneController(),MovingPlutoController()]
       
//
//        let vc = MovingPlanetVCs[indexPath.row]
//        present(UINavigationController(rootViewController: vc), animated: true)
//
        
     
}

}

