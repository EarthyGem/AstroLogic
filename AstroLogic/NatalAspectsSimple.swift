//
//  ViewController.swift
//  Transits
//
//  Created by Errick Williams on 15/18/22.
//

struct AspectKey: Hashable {
    let body1: CelestialObject
    let body2: CelestialObject
  
}

struct NatalAspectContent {
    let aspectKey: AspectKey
    let generalDescription: String
    let strengths: String
    let challenges: String
    let advice: String
}

import UIKit
import SwiftEphemeris

class SimpleNatalAspectsViewController: UIViewController {



     var chartCake: ChartCake?
     var selectedDate: Date?
    var sunAspects: [String] = []
    var moonAspects: [String] = []
    var mercuryAspects: [String] = []
    var venusAspects: [String] = []
    var marsAspects: [String] = []
    var jupiterAspects: [String] = []
    var saturnAspects: [String] = []
    var uranusAspects: [String] = []
    var neptuneAspects: [String] = []
    var plutoAspects: [String] = []
    
    var sunAspects2: [CelestialAspect] = []
    var moonAspects2: [CelestialAspect] = []
    var mercuryAspects2: [CelestialAspect] = []
    var venusAspects2: [CelestialAspect] = []
    var marsAspects2: [CelestialAspect] = []
    var jupiterAspects2: [CelestialAspect] = []
    var saturnAspects2: [CelestialAspect] = []
    var uranusAspects2: [CelestialAspect] = []
    var neptuneAspects2: [CelestialAspect] = []
    var plutoAspects2: [CelestialAspect] = []
    var aspectDictionary: [AspectKey: NatalAspectContent] = [:]


     private let scrollView: UIScrollView = {
         let scrollView = UIScrollView()

         return scrollView
     }()




     private let sunScrollView: UIView = {
         let sunScrollView = UIView()

         return sunScrollView
     }()

     private let moonScrollView: UIView = {
         let moonScrollView = UIView()

         return moonScrollView
     }()

     private let mercuryScrollView: UIView = {
         let mercuryScrollView = UIView()

         return mercuryScrollView
     }()
     private let venusScrollView: UIView = {
         let venusScrollView = UIView()

         return venusScrollView
     }()
     private let marsScrollView: UIView = {
         let marsScrollView = UIView()

         return marsScrollView
     }()
     private let jupiterScrollView: UIView = {
         let jupiterScrollView = UIView()

         return jupiterScrollView
     }()
     private let saturnScrollView: UIView = {
         let saturnScrollView = UIView()

         return saturnScrollView
     }()
     private let uranusScrollView: UIView = {
         let uranusScrollView = UIView()

         return uranusScrollView
     }()
     private let neptuneScrollView: UIView = {
         let neptuneScrollView = UIView()

         return neptuneScrollView
     }()
     private let plutoScrollView: UIView = {
         let plutoScrollView = UIView()

         return plutoScrollView
     }()

     private let sunTableView: UITableView = {
         let sunTableView = UITableView()

             sunTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)



         return sunTableView
     }()

     private let ascTableView: UITableView = {
         let ascTableView = UITableView()

         ascTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)



         return ascTableView
     }()

     private let moonTableView: UITableView = {
         let moonTableView = UITableView()
         moonTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)


         return moonTableView
     }()

     private let mercuryTableView: UITableView = {
         let mercuryTableView = UITableView()

         mercuryTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)
         return mercuryTableView
     }()

     private let venusTableView: UITableView = {
         let venusTableView = UITableView()
         venusTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)

         return venusTableView
     }()

     private let marsTableView: UITableView = {
         let marsTableView = UITableView()
         marsTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)

         return marsTableView
     }()

     private let jupiterTableView: UITableView = {
         let jupiterTableView = UITableView()
         jupiterTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)

         return jupiterTableView
     }()

     private let saturnTableView: UITableView = {
         let saturnTableView = UITableView()

         saturnTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)
         return saturnTableView
     }()

     private let uranusTableView: UITableView = {
         let uranusTableView = UITableView()
         uranusTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)

         return uranusTableView
     }()
     private let neptuneTableView: UITableView = {
         let neptuneTableView = UITableView()

         neptuneTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)
         return neptuneTableView
     }()
     private let plutoTableView: UITableView = {
         let plutoTableView = UITableView()

         plutoTableView.register(NewAspectsCustomTableViewCell.self, forCellReuseIdentifier: NewAspectsCustomTableViewCell.identifier)
         return plutoTableView
     }()

     private let sunSignGlyph: UIImageView = {
         let sunSignGlyph = UIImageView()


         return sunSignGlyph

     }()
     private let moonSignGlyph: UIImageView = {
         let moonSignGlyph = UIImageView()


         return moonSignGlyph

     }()
     private let mercurySignGlyph: UIImageView = {
         let mercurySignGlyph = UIImageView()


         return mercurySignGlyph

     }()
     private let venusSignGlyph: UIImageView = {
         let venusSignGlyph = UIImageView()


         return venusSignGlyph

     }()
     private let marsSignGlyph: UIImageView = {
         let marsSignGlyph = UIImageView()


         return marsSignGlyph

     }()
     private let jupiterSignGlyph: UIImageView = {
         let jupiterSignGlyph = UIImageView()


         return jupiterSignGlyph

     }()
     private let saturnSignGlyph: UIImageView = {
         let saturnSignGlyph = UIImageView()


         return saturnSignGlyph

     }()
     private let uranusSignGlyph: UIImageView = {
         let uranusSignGlyph = UIImageView()


         return uranusSignGlyph

     }()
     private let neptuneSignGlyph: UIImageView = {
         let neptuneSignGlyph = UIImageView()


         return neptuneSignGlyph

     }()
     private let plutoSignGlyph: UIImageView = {
         let plutoSignGlyph = UIImageView()


         return plutoSignGlyph

     }()

     private let topTransitImage: UIImageView = {
         let topTransitImage = UIImageView()


         return topTransitImage

     }()
 //         public let transitIntro: UILabel = {
 //            let transitIntro = UILabel()
 //
 //            return transitIntro
 //
 //
 //    }()

     var SelectedIndex = -1
     var isCollapsed = false



     override func viewDidLoad() {
         super.viewDidLoad()


         sunAspects = chartCake!.filterAndFormat(by: Planet.sun.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         moonAspects = chartCake!.filterAndFormat(by: Planet.moon.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         mercuryAspects = chartCake!.filterAndFormat(by: Planet.mercury.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         venusAspects = chartCake!.filterAndFormat(by: Planet.venus.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         marsAspects = chartCake!.filterAndFormat(by: Planet.mars.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         jupiterAspects = chartCake!.filterAndFormat(by: Planet.jupiter.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         saturnAspects = chartCake!.filterAndFormat(by: Planet.saturn.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         uranusAspects = chartCake!.filterAndFormat(by: Planet.uranus.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         neptuneAspects = chartCake!.filterAndFormat(by: Planet.neptune.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         plutoAspects = chartCake!.filterAndFormat(by: Planet.pluto.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         
         sunAspects2 = chartCake!.filterAndFormat2(by: Planet.sun.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         moonAspects2 = chartCake!.filterAndFormat2(by: Planet.moon.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         mercuryAspects2 = chartCake!.filterAndFormat2(by: Planet.mercury.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         venusAspects2 = chartCake!.filterAndFormat2(by: Planet.venus.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         marsAspects2 = chartCake!.filterAndFormat2(by: Planet.mars.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         jupiterAspects2 = chartCake!.filterAndFormat2(by: Planet.jupiter.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         saturnAspects2 = chartCake!.filterAndFormat2(by: Planet.saturn.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         uranusAspects2 = chartCake!.filterAndFormat2(by: Planet.uranus.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         neptuneAspects2 = chartCake!.filterAndFormat2(by: Planet.neptune.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)
         plutoAspects2 = chartCake!.filterAndFormat2(by: Planet.pluto.celestialObject, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true)


         sunTableView.dataSource = self
         sunTableView.delegate = self
        moonTableView.dataSource = self
         moonTableView.delegate = self
         mercuryTableView.dataSource = self
         mercuryTableView.delegate = self
         venusTableView.dataSource = self
         venusTableView.delegate = self
         marsTableView.dataSource = self
         marsTableView.delegate = self
         jupiterTableView.dataSource = self
         jupiterTableView.delegate = self
         saturnTableView.dataSource = self
         saturnTableView.delegate = self
         uranusTableView.dataSource = self
         uranusTableView.delegate = self
         neptuneTableView.dataSource = self
         neptuneTableView.delegate = self
         plutoTableView.dataSource = self
         plutoTableView.delegate = self
 //        ascTableView.dataSource = self
 //        ascTableView.delegate = self
         if let tabBar = self.tabBarController?.tabBar {
             tabBar.isTranslucent = false
             tabBar.barTintColor = .black // Sets the background color to black
         }
         view.backgroundColor = .black
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More Aspects", style: .plain, target: self, action: #selector(moreAspectsButtonTapped))

     }

     override func viewDidAppear(_ animated: Bool) {
         sunTableView.frame = CGRect(x: sunTableView.frame.origin.x, y: sunTableView.frame.origin.y , width: sunTableView.frame.size.width, height: sunTableView.contentSize.height)

         moonTableView.frame = CGRect(x: moonTableView.frame.origin.x, y: moonTableView.frame.origin.y , width: moonTableView.frame.size.width, height: moonTableView.contentSize.height)

         mercuryTableView.frame = CGRect(x: mercuryTableView.frame.origin.x, y: mercuryTableView.frame.origin.y , width: mercuryTableView.frame.size.width, height: mercuryTableView.contentSize.height)

         venusTableView.frame = CGRect(x: venusTableView.frame.origin.x, y: venusTableView.frame.origin.y, width: venusTableView.frame.size.width, height: venusTableView.contentSize.height)

         marsTableView.frame = CGRect(x: marsTableView.frame.origin.x, y: marsTableView.frame.origin.y , width: marsTableView.frame.size.width, height: marsTableView.contentSize.height)

         jupiterTableView.frame = CGRect(x: jupiterTableView.frame.origin.x, y: jupiterTableView.frame.origin.y , width: jupiterTableView.frame.size.width, height: jupiterTableView.contentSize.height)

         saturnTableView.frame = CGRect(x: saturnTableView.frame.origin.x, y: saturnTableView.frame.origin.y , width: saturnTableView.frame.size.width, height: saturnTableView.contentSize.height)

         uranusTableView.frame = CGRect(x: uranusTableView.frame.origin.x, y: uranusTableView.frame.origin.y , width: uranusTableView.frame.size.width, height: uranusTableView.contentSize.height)

        neptuneTableView.frame = CGRect(x: neptuneTableView.frame.origin.x, y: neptuneTableView.frame.origin.y , width: neptuneTableView.frame.size.width, height: neptuneTableView.contentSize.height)

         plutoTableView.frame = CGRect(x: plutoTableView.frame.origin.x, y: plutoTableView.frame.origin.y , width: plutoTableView.frame.size.width, height: plutoTableView.contentSize.height)

         ascTableView.frame = CGRect(x: ascTableView.frame.origin.x, y: ascTableView.frame.origin.y , width: ascTableView.frame.size.width, height: ascTableView.contentSize.height)
     }
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()

         scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 20)
         scrollView.backgroundColor = .clear
         view.addSubview(scrollView)

         topTransitImage.image = UIImage(named: "clouds")
         topTransitImage.image?.withTintColor(UIColor.yellow)

         topTransitImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)
         view.addSubview(topTransitImage)

         // adding date label


         sunScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
         scrollView.addSubview(sunScrollView)
 //        sunScrollView.contentSize = CGSize(width: 300, height: 200)

 //        sunTableView.backgroundColor = .orange
         moonTableView.backgroundColor = .green

        mercuryTableView.backgroundColor = .purple

         venusTableView.backgroundColor = .yellow
        marsTableView.backgroundColor = .red
        jupiterTableView.backgroundColor = .systemGroupedBackground
         saturnTableView.backgroundColor = .blue
         uranusTableView.backgroundColor = .white
        neptuneTableView.backgroundColor = .gray
         plutoTableView.backgroundColor = .systemPink

 //      view.frame = CGRect(x: 0, y: 0, width: 400, height: 6000)

         var totalHeight: CGFloat = 0
         let tableViews = [sunTableView, moonTableView, mercuryTableView, venusTableView, marsTableView, jupiterTableView, saturnTableView, uranusTableView, neptuneTableView, plutoTableView]
         for tableView in tableViews {
             for planet in chartCake!.natal.planets {
                 let height = CGFloat(chartCake!.filterAndFormat(by: planet.body, aspectsScores: chartCake!.allCelestialAspectScoresbyAspect(), includeParallel: true).count * 90)
                 tableView.contentSize.height = height
                 totalHeight += height
             }
         }
         scrollView.contentSize = CGSize(width: view.frame.width, height: totalHeight)
         sunTableView.contentSize.height = CGFloat(sunAspects.count * 90)
 //        sunTableView.contentSize = CGSize(width: view.frame.width, height: numbers)
         moonTableView.contentSize.height = CGFloat(moonAspects.count * 90)
         mercuryTableView.contentSize.height = CGFloat(mercuryAspects.count * 90)
         venusTableView.contentSize.height = CGFloat(venusAspects.count * 90)
         marsTableView.contentSize.height = CGFloat(marsAspects.count * 90)
         jupiterTableView.contentSize.height = CGFloat(jupiterAspects.count * 90)
         saturnTableView.contentSize.height = CGFloat(saturnAspects.count * 90)
         uranusTableView.contentSize.height = CGFloat(uranusAspects.count * 90)
         neptuneTableView.contentSize.height = CGFloat(neptuneAspects.count * 90)
         plutoTableView.contentSize.height = CGFloat(plutoAspects.count * 90)


         scrollView.addSubview(moonScrollView)
 //        moonScrollView.contentSize = CGSize(width: 300, height: 200)
        moonScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

         scrollView.addSubview(mercuryScrollView)
 //        mercuryScrollView.contentSize = CGSize(width: 300, height: 200)
         mercuryScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

         scrollView.addSubview(venusScrollView)
 //        venusScrollView.contentSize = CGSize(width: 300, height: 200)
         venusScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

         scrollView.addSubview(marsScrollView)
 //        marsScrollView.contentSize = CGSize(width: 300, height: 200)
         marsScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

         scrollView.addSubview(jupiterScrollView)
 //        jupiterScrollView.contentSize = CGSize(width: 300, height: 200)
         jupiterScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

         scrollView.addSubview(saturnScrollView)
 //        saturnScrollView.contentSize = CGSize(width: 300, height: 200)
         saturnScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

         scrollView.addSubview(uranusScrollView)
 //        uranusScrollView.contentSize = CGSize(width: 300, height: 200)
         uranusScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

         scrollView.addSubview(neptuneScrollView)
 //        neptuneScrollView.contentSize = CGSize(width: 300, height: 200)
         neptuneScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

         scrollView.addSubview(plutoScrollView)
 //        plutoScrollView.contentSize = CGSize(width: 300, height: 200)
         plutoScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

 //        sunScrollView.addSubview(plutoTableView)
         // Do any additional setup after loading the view.


 //        sunScrollView.frame = CGRect(x: 10, y: 150, width: view.frame.size.width - 20, height: view.frame.size.height - 20)
 //


         sunSignGlyph.image = UIImage(named: "sun")
         sunSignGlyph.image?.withTintColor(UIColor.yellow)

         sunSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         sunScrollView.addSubview(sunSignGlyph)
         sunSignGlyph.backgroundColor = .clear


         moonSignGlyph.image = UIImage(named: "moon")
         moonSignGlyph.image?.withTintColor(UIColor.yellow)

         moonSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         moonScrollView.addSubview(moonSignGlyph)
         moonSignGlyph.backgroundColor = .clear


         mercurySignGlyph.image = UIImage(named: "mercury")
         mercurySignGlyph.image?.withTintColor(UIColor.yellow)

         mercurySignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         mercuryScrollView.addSubview(mercurySignGlyph)
         mercurySignGlyph.backgroundColor = .clear


         venusSignGlyph.image = UIImage(named: "venus")
         venusSignGlyph.image?.withTintColor(UIColor.yellow)

         venusSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         venusScrollView.addSubview(venusSignGlyph)
         venusSignGlyph.backgroundColor = .clear


         marsSignGlyph.image = UIImage(named: "mars")
         marsSignGlyph.image?.withTintColor(UIColor.yellow)

         marsSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         marsScrollView.addSubview(marsSignGlyph)
         marsSignGlyph.backgroundColor = .clear


         jupiterSignGlyph.image = UIImage(named: "jupiter")
         jupiterSignGlyph.image?.withTintColor(UIColor.yellow)

         jupiterSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         jupiterScrollView.addSubview(jupiterSignGlyph)
         jupiterSignGlyph.backgroundColor = .clear


         saturnSignGlyph.image = UIImage(named: "saturn")
         saturnSignGlyph.image?.withTintColor(UIColor.yellow)

         saturnSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         saturnScrollView.addSubview(saturnSignGlyph)
         saturnSignGlyph.backgroundColor = .clear


         uranusSignGlyph.image = UIImage(named: "uranus")
         uranusSignGlyph.image?.withTintColor(UIColor.yellow)

         uranusSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         uranusScrollView.addSubview(uranusSignGlyph)
         uranusSignGlyph.backgroundColor = .clear


         neptuneSignGlyph.image = UIImage(named: "neptune")
         neptuneSignGlyph.image?.withTintColor(UIColor.yellow)

         neptuneSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         neptuneScrollView.addSubview(neptuneSignGlyph)
         neptuneSignGlyph.backgroundColor = .clear


         plutoSignGlyph.image = UIImage(named: "pluto")
         plutoSignGlyph.image?.withTintColor(UIColor.yellow)

         plutoSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

         plutoScrollView.addSubview(plutoSignGlyph)
         plutoSignGlyph.backgroundColor = .clear





         sunScrollView.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: sunTableView.contentSize.height + 40)

         sunTableView.frame = CGRect(x: 10, y: 35, width: sunScrollView.frame.size.width , height: sunTableView.contentSize.height)

         sunScrollView.addSubview(sunTableView)


         moonScrollView.frame = CGRect(x: 0, y: sunScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: moonTableView.contentSize.height + 40)
         moonTableView.frame = CGRect(x: 10, y: 35, width: moonScrollView.frame.size.width , height: moonScrollView.frame.size.height - 60)

         moonScrollView.addSubview(moonTableView)




         mercuryScrollView.frame = CGRect(x: 0, y: moonScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: mercuryTableView.contentSize.height + 40)
         mercuryScrollView.addSubview(mercuryTableView)



         venusScrollView.frame = CGRect(x: 0, y: mercuryScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: venusTableView.contentSize.height + 40)
         venusScrollView.addSubview(venusTableView)

         marsScrollView.frame = CGRect(x: 0, y: venusScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: marsTableView.contentSize.height + 40)
         marsScrollView.addSubview(marsTableView)

         jupiterScrollView.frame = CGRect(x: 0, y: marsScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: jupiterTableView.contentSize.height + 40)
         jupiterScrollView.addSubview(jupiterTableView)

         saturnScrollView.frame = CGRect(x: 0, y: jupiterScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: saturnTableView.contentSize.height + 40)
         saturnScrollView.addSubview(saturnTableView)

         uranusScrollView.frame = CGRect(x: 0, y: saturnScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: uranusTableView.contentSize.height + 40)
         uranusScrollView.addSubview(uranusTableView)

         neptuneScrollView.frame = CGRect(x: 0, y: uranusScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: neptuneTableView.contentSize.height + 40)
         neptuneScrollView.addSubview(neptuneTableView)

         plutoScrollView.frame = CGRect(x: 0, y: neptuneScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: plutoTableView.contentSize.height + 40)
         plutoScrollView.addSubview(plutoTableView)
 //


         mercuryTableView.frame = CGRect(x: 10, y: 35, width: mercuryScrollView.frame.size.width , height: mercuryScrollView.frame.size.height - 60)

         venusTableView.frame = CGRect(x: 10, y: 35, width: venusScrollView.frame.size.width , height: venusScrollView.frame.size.height - 60)

         marsTableView.frame = CGRect(x: 10, y: 35, width: marsScrollView.frame.size.width , height: marsScrollView.frame.size.height - 60)

         jupiterTableView.frame = CGRect(x: 10, y: 35, width: jupiterScrollView.frame.size.width , height: jupiterScrollView.frame.size.height - 60)

         saturnTableView.frame = CGRect(x: 10, y: 35, width: saturnScrollView.frame.size.width , height: saturnScrollView.frame.size.height - 60)

         uranusTableView.frame = CGRect(x: 10, y: 35, width: uranusScrollView.frame.size.width , height: uranusScrollView.frame.size.height - 20)
         neptuneTableView.frame = CGRect(x: 10, y: 35, width: neptuneScrollView.frame.size.width , height: neptuneScrollView.frame.size.height - 60)
         plutoTableView.frame = CGRect(x: 10, y: 35, width: plutoScrollView.frame.size.width , height: plutoScrollView.frame.size.height - 60)


         let sunText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         sunText.text = "Sun - Power Urges"
         sunText.font = .systemFont(ofSize: 16)
         sunText.textColor = .white

          sunScrollView.addSubview(sunText)

         let moonText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         moonText.text = "Moon - Domestic Urges"
         moonText.font = .systemFont(ofSize: 16)
         moonText.textColor = .white

          moonScrollView.addSubview(moonText)

         let mercuryText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         mercuryText.text = "Mercury - Intellectual Urges"
         mercuryText.font = .systemFont(ofSize: 16)
         mercuryText.textColor = .white

          mercuryScrollView.addSubview(mercuryText)

         let venusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         venusText.text = "Venus - Social Urges"
         venusText.font = .systemFont(ofSize: 16)
         venusText.textColor = .white

          venusScrollView.addSubview(venusText)

         let marsText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         marsText.text = "Mars - Aggressive Urges"
         marsText.font = .systemFont(ofSize: 16)
         marsText.textColor = .white

          marsScrollView.addSubview(marsText)

         let jupiterText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         jupiterText.text = "Jupiter - Religious Urges"
         jupiterText.font = .systemFont(ofSize: 16)
         jupiterText.textColor = .white

          jupiterScrollView.addSubview(jupiterText)

         let saturnText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         saturnText.text = "Saturn - Saftey Urges"
         saturnText.font = .systemFont(ofSize: 16)
         saturnText.textColor = .white

          saturnScrollView.addSubview(saturnText)

         let uranusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         uranusText.text = "Uranus - Individualistic Urges"
         uranusText.font = .systemFont(ofSize: 16)
         uranusText.textColor = .white

          uranusScrollView.addSubview(uranusText)

         let neptuneText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         neptuneText.text = "Neptune - Utopian Urges"
         neptuneText.font = .systemFont(ofSize: 16)
         neptuneText.textColor = .white

          neptuneScrollView.addSubview(neptuneText)

         let plutoText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
         plutoText.text = "Pluto - Universal Welfare Urges"
         plutoText.font = .systemFont(ofSize: 16)
         plutoText.textColor = .white

          plutoScrollView.addSubview(plutoText)
         let transitIntro = UILabel(frame: CGRect(x: 5, y: 30, width: scrollView.frame.width - 10, height: 200))
         transitIntro.text = "The natal chart shows, by the aspects between the planets, the extent to which experiences of one type have been associated with experiences of other types; and the extent to which these associations will tend towards harmony or discord."
         transitIntro.font = .systemFont(ofSize: 13)
         transitIntro.textColor = .white

         transitIntro.numberOfLines = 4
         transitIntro.textAlignment = .center


          scrollView.addSubview(transitIntro)
 //
 //
     }

     @objc func navigateToTimeChangeVC() {
         let timeChangeVC = TransitAspectsTimeChangeViewController()
         self.navigationController?.pushViewController(timeChangeVC, animated: true)
     }

    @objc func moreAspectsButtonTapped() {
        let flipSynastryVC = NatalAspectsViewController()
        flipSynastryVC.chartCake = self.chartCake
        flipSynastryVC.selectedDate = self.selectedDate
        self.navigationController?.pushViewController(flipSynastryVC, animated: true)
    }


}

extension SimpleNatalAspectsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


        if(tableView == sunTableView) {

            return sunAspects.count
    }
        else if(tableView == moonTableView){
            return moonAspects.count
        }


            else if(tableView == mercuryTableView){

                return mercuryAspects.count
            }
            else if(tableView == venusTableView){

                return venusAspects.count
                }
        else if(tableView == marsTableView){

            return marsAspects.count
                    }
        else if(tableView == jupiterTableView){

            return jupiterAspects.count
                        }
        else if(tableView == saturnTableView){

            return saturnAspects.count
                            }
        else if(tableView == uranusTableView){

            return uranusAspects.count
                                }
        else if(tableView == neptuneTableView){

            return neptuneAspects.count
                                    }
        else {

            return plutoAspects.count



    }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(tableView == sunTableView) {


            guard let cell = sunTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }



            cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: sunAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )

//                    cell.dropDownText(transit1: "lKSACFhouEFHQVBIYEVBilvywbviy", transit2: "kabevovBNOVWIBWvo;wrbva", transit3: "qek.BVFbeqvV", transit4: "ALENVFoe;wvno;Vojw", myTableCell: sunScrollView)
////
//                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: MajorMoonAspects2()[indexPath.row], firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: transitSunAspects[indexPath.row],firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )

           return cell

    }
        else if(tableView == moonTableView){

            guard let cell = moonTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }


            cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: moonAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )

           return cell

        }





        else if(tableView == mercuryTableView){


            guard let cell = mercuryTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }




              cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: mercuryAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )

           return cell

        }
            else if(tableView == venusTableView){


                guard let cell = venusTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                   return UITableViewCell()
               }





                cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: venusAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )

               return cell



                }
        else if(tableView == marsTableView){


            guard let cell = marsTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }





            cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: marsAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )

           return cell

                    }
        else if(tableView == jupiterTableView){


            guard let cell = jupiterTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }





              cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: jupiterAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )


           return cell

                        }
        else if(tableView == saturnTableView){


            guard let cell = saturnTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }

//                    var transitSaturnAspects = [plutoSaturn]


              cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: saturnAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )

           return cell

                            }
        else if(tableView == uranusTableView){


            guard let cell = uranusTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }




              cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: uranusAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )


           return cell

                                }
        else if(tableView == neptuneTableView){


            guard let cell = neptuneTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }


              cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: neptuneAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )


           return cell

                                    }
        else {


            guard let cell = plutoTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

               return UITableViewCell()
           }




            cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: plutoAspects[indexPath.row], firstPlanetTextText: "",firstAspectHeaderTextText: "",secondAspectHeaderTextText: " " )


           return cell



    }
    }




    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedAspect: CelestialAspect?
        print("Did select row at \(indexPath)")
        print("Navigation controller: \(navigationController)")

        
        // Determine which table view is being interacted with and set the selectedAspect
        switch tableView {
        case sunTableView:
            selectedAspect = sunAspects2[indexPath.row]
        case moonTableView:
            selectedAspect = moonAspects2[indexPath.row]
        case mercuryTableView:
            selectedAspect = mercuryAspects2[indexPath.row]
        case venusTableView:
            selectedAspect = venusAspects2[indexPath.row]
        case marsTableView:
            selectedAspect = marsAspects2[indexPath.row]
        case jupiterTableView:
            selectedAspect = jupiterAspects2[indexPath.row]
        case saturnTableView:
            selectedAspect = saturnAspects2[indexPath.row]
        case uranusTableView:
            selectedAspect = uranusAspects2[indexPath.row]
        case neptuneTableView:
            selectedAspect = neptuneAspects2[indexPath.row]
        case plutoTableView:
            selectedAspect = plutoAspects2[indexPath.row]
        default:
            // Handle unexpected table view, if necessary
            break
        }

        if let aspect = selectedAspect {
              let detailVC = NatalAspectDetailViewController()
              let key = AspectKey(body1: aspect.body1.body, body2: aspect.body2.body)
              if let aspectContent = aspectDictionary[key] {
                  detailVC.aspectContent = aspectContent
                  navigationController?.pushViewController(detailVC, animated: true)
              }
          }
      }
}
