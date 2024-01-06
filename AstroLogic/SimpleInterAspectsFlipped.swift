//
//  ViewController.swift
//  Transits
//
//  Created by Errick Williams on 15/18/22.
//

import UIKit
import SwiftEphemeris

class FlippedSimpleInteraspectsViewController: UIViewController {

    //
    //  ViewController.swift
    //  Transits
    //
    //  Created by Errick Williams on 15/18/22.
    //
    var otherChart: ChartCake?
    var chartCake: ChartCake?

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
    var aspect: AspectType!
    var targetBody: Coordinate!
    var name: String!
    var otherName: String!

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

             sunAspects = chartCake!.synastryFilterAndFormat(by: Planet.sun.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             moonAspects = chartCake!.synastryFilterAndFormat(by: Planet.moon.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             mercuryAspects = chartCake!.synastryFilterAndFormat(by: Planet.mercury.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             venusAspects = chartCake!.synastryFilterAndFormat(by: Planet.venus.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             marsAspects = chartCake!.synastryFilterAndFormat(by: Planet.mars.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             jupiterAspects = chartCake!.synastryFilterAndFormat(by: Planet.jupiter.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             saturnAspects = chartCake!.synastryFilterAndFormat(by: Planet.saturn.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             uranusAspects = chartCake!.synastryFilterAndFormat(by: Planet.uranus.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             neptuneAspects = chartCake!.synastryFilterAndFormat(by: Planet.neptune.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             plutoAspects = chartCake!.synastryFilterAndFormat(by: Planet.pluto.celestialObject, chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies,chart1Name: name!, chart2Name: otherName!, aspectTuples: chartCake!.interchartAspectScores(chart1: (otherChart!.natal.rickysBodies), chart2: chartCake!.natal.rickysBodies), filterChart2: false)
             
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

             view.backgroundColor = .black


         }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "\(name!)'s Urges", style: .plain, target: nil, action: nil)
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

             scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)

               // Assuming topTransitImage needs to be inside the scrollView
               topTransitImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)
               scrollView.addSubview(topTransitImage)
             scrollView.backgroundColor = .clear
             view.addSubview(scrollView)

             topTransitImage.image = UIImage(named: "clouds")
             topTransitImage.image?.withTintColor(UIColor.yellow)

             topTransitImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)
             view.addSubview(topTransitImage)


             sunScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
             scrollView.addSubview(sunScrollView)

             sunTableView.backgroundColor = .orange
             moonTableView.backgroundColor = .green
            mercuryTableView.backgroundColor = .purple
             venusTableView.backgroundColor = .yellow
            marsTableView.backgroundColor = .red
            jupiterTableView.backgroundColor = .systemGroupedBackground
             saturnTableView.backgroundColor = .blue
             uranusTableView.backgroundColor = .white
            neptuneTableView.backgroundColor = .gray
             plutoTableView.backgroundColor = .systemPink


             scrollView.contentSize = CGSize(width: view.frame.width, height: 6000)
             scrollView.contentSize = CGSize(width: view.frame.width, height: 6000)
             sunTableView.contentSize.height = CGFloat(sunAspects.count * 90)

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
            moonScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

             scrollView.addSubview(mercuryScrollView)
             mercuryScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

             scrollView.addSubview(venusScrollView)
             venusScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

             scrollView.addSubview(marsScrollView)
             marsScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

             scrollView.addSubview(jupiterScrollView)
             jupiterScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

             scrollView.addSubview(saturnScrollView)
             saturnScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

             scrollView.addSubview(uranusScrollView)
             uranusScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

             scrollView.addSubview(neptuneScrollView)
             neptuneScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

             scrollView.addSubview(plutoScrollView)
             plutoScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)


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
             sunText.text = "The Soverign  - \(name!)'s Power Urges"
             sunText.font = .systemFont(ofSize: 16)
             sunText.textColor = .white

              sunScrollView.addSubview(sunText)

             let moonText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             moonText.text = "The Nurturer - \(name!)'s Domestic Urges"
             moonText.font = .systemFont(ofSize: 16)
             moonText.textColor = .white

              moonScrollView.addSubview(moonText)

             let mercuryText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             mercuryText.text = "The Messenger - \(name!)'s Intellectual Urges"
             mercuryText.font = .systemFont(ofSize: 16)
             mercuryText.textColor = .white

              mercuryScrollView.addSubview(mercuryText)

             let venusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             venusText.text = "The Lover - \(name!)'s Social Urges"
             venusText.font = .systemFont(ofSize: 16)
             venusText.textColor = .white

              venusScrollView.addSubview(venusText)

             let marsText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             marsText.text = "The Warrior - \(name!)'s Aggressive Urges"
             marsText.font = .systemFont(ofSize: 16)
             marsText.textColor = .white

              marsScrollView.addSubview(marsText)

             let jupiterText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             jupiterText.text = "The Explorer - \(name!)'s Religious Urges"
             jupiterText.font = .systemFont(ofSize: 16)
             jupiterText.textColor = .white

              jupiterScrollView.addSubview(jupiterText)

             let saturnText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             saturnText.text = "The Stategist - \(name!)'s Saftey Urges"
             saturnText.font = .systemFont(ofSize: 16)
             saturnText.textColor = .white

              saturnScrollView.addSubview(saturnText)

             let uranusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             uranusText.text = "The Renegade - \(name!)'s Individualistic Urges"
             uranusText.font = .systemFont(ofSize: 16)
             uranusText.textColor = .white

              uranusScrollView.addSubview(uranusText)

             let neptuneText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             neptuneText.text = "The Dreamer - \(name!)'s Utopian Urges"
             neptuneText.font = .systemFont(ofSize: 16)
             neptuneText.textColor = .white

              neptuneScrollView.addSubview(neptuneText)

             let plutoText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
             plutoText.text = "The Transformer - \(name!)'s Urge to Transcend"
             plutoText.font = .systemFont(ofSize: 16)
             plutoText.textColor = .white

              plutoScrollView.addSubview(plutoText)

             let transitIntro = UILabel(frame: CGRect(x: 5, y: 30, width: scrollView.frame.width - 10, height: 200))
             transitIntro.text = "No matter how different two people might be, if we put them both in the pressure cooker and close the lid, they’ll work out a pattern of relation. It may be joyful. It may be mutually destructive. But a pattern will appear—and no matter who they are, that pattern can be analyzed through a study of the interplay between the planets in one birthchart impact upon the planets in the other chart. Astrologers call these interactions Interaspects"
             
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


    }

    extension FlippedSimpleInteraspectsViewController: UITableViewDataSource, UITableViewDelegate {
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
            tableView.deselectRow(at: indexPath, animated: true)



            // Extract the necessary data from the selected aspect
            let userAName = name ?? "User A"
            let userBName = otherName ?? "User B"
            let planetA = aspect.celestialAspect?.body1.body.keyName ?? ""
            let planetB = aspect.celestialAspect?.body2.body.keyName ?? ""
            let aspectType = aspect.celestialAspect?.keyword ?? ""
            let aspectTypeCap = aspect.celestialAspect?.Keyword ?? ""
            let aspectKind = aspect.celestialAspect?.kind

            // Instantiate and set up the InteraspectInterpretationViewController
            let interpretationVC = InteraspectInterpretationViewController()
            interpretationVC.userAName = userAName
            interpretationVC.userBName = userBName
            interpretationVC.planetA = planetA
            interpretationVC.planetB = planetB
            interpretationVC.aspect = aspectType
            interpretationVC.aspectCap = aspectTypeCap
            interpretationVC.kind = aspectKind
            // Present or push the view controller
            navigationController?.pushViewController(interpretationVC, animated: true)
        }

    }
