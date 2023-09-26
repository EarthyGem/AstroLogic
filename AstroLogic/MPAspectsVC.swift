//
//  TransitAspectedPlanetsViewController  .swift
//  MVP
//
//  Created by Errick Williams on 10/19/22.
//

import UIKit
import SwiftEphemeris

class MPAspectsViewController: UIViewController {

    var chart: Chart?
    var chartCake: ChartCake?
    var selectedDate: Date?
    var tableViewToPlanetMap: [UITableView: Planet] = [:]
    
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

        tableViewToPlanetMap = [
            sunTableView: .sun,
            moonTableView: .moon,
            mercuryTableView: .mercury,
            venusTableView: .venus,
            marsTableView: .mars,
            jupiterTableView: .jupiter,
            saturnTableView: .saturn,
            uranusTableView: .uranus,
            neptuneTableView: .neptune,
            plutoTableView: .pluto
        ]
        chartCake?.calculateProgressedHouseStrengths2(progressedBodies: chartCake?.major.planets)
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Less Aspects", style: .plain, target: nil, action: nil)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 20)
        scrollView.backgroundColor = .clear
        view.addSubview(scrollView)
        
        topTransitImage.image = UIImage(named: "clouds")
        topTransitImage.image?.withTintColor(UIColor.yellow)
        
        topTransitImage.frame = CGRect(x: 0, y: 40, width: view.frame.width, height: 350)
        view.addSubview(topTransitImage)
        
        // adding date label
        
        let formatted = selectedDate!.formatted(date: .complete, time: .omitted)
        let todaysDate = UILabel(frame: CGRect(x: 100, y: 170, width: 300, height: 20))
        todaysDate.text = formatted
        todaysDate.font = .systemFont(ofSize: 13)
        todaysDate.textColor = .white
        todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)
        scrollView.addSubview(todaysDate)
        

        
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


        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 4000)
        func setTableContentSize(for celestialBody: String, on tableView: UITableView) {
            guard let chartCake = chartCake else { return }
            let aspectCount = chartCake.constructMajorAspectDictionary2()[celestialBody]?.count ?? 0
            tableView.contentSize.height = CGFloat(aspectCount * 90)
        }

        let celestialBodiesAndTables = [
            ("Sun", sunTableView),
            ("Moon", moonTableView),
            ("Mercury", mercuryTableView),
            ("Venus", venusTableView),
            ("Mars", marsTableView),
            ("Jupiter", jupiterTableView),
            ("Saturn", saturnTableView),
            ("Uranus", uranusTableView),
            ("Neptune", neptuneTableView),
            ("Pluto", plutoTableView)
        ]

        for (body, table) in celestialBodiesAndTables {
            setTableContentSize(for: body, on: table)
        }

        
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
        sunText.text = "Sun - Vitality and Authority"
        sunText.font = .systemFont(ofSize: 12)
        sunText.textColor = .white


        sunScrollView.addSubview(sunText)

        let moonText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        moonText.text = "Moon -  Mental Attitude and Everyday Affairs"
        moonText.font = .systemFont(ofSize: 12)
        moonText.textColor = .white

        moonScrollView.addSubview(moonText)

        let mercuryText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        mercuryText.text = "Mercury - Mental Interests and Learning or Teaching"
        mercuryText.font = .systemFont(ofSize: 12)
        mercuryText.textColor = .white

        mercuryScrollView.addSubview(mercuryText)

        let venusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        venusText.text = "Venus -  The Affections and Social Relations"
        venusText.font = .systemFont(ofSize: 12)
        venusText.textColor = .white

        venusScrollView.addSubview(venusText)

        let marsText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        marsText.text = "Mars - Strife, and Increased Expenditure of Energy"

        marsText.font = .systemFont(ofSize: 12)
        marsText.textColor = .white

        marsScrollView.addSubview(marsText)

        let jupiterText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        jupiterText.text = "Jupiter - Abundance and Optimism"
        jupiterText.font = .systemFont(ofSize: 12)
        jupiterText.textColor = .white

        jupiterScrollView.addSubview(jupiterText)

        let saturnText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        saturnText.text = "Saturn - Work, and Economy or Loss."
        saturnText.font = .systemFont(ofSize: 12)
        saturnText.textColor = .white

        saturnScrollView.addSubview(saturnText)

        let uranusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        uranusText.text = "Uranus - Sudden Events and Radical Changes."
        uranusText.font = .systemFont(ofSize: 12)
        uranusText.textColor = .white

        uranusScrollView.addSubview(uranusText)

        let neptuneText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        neptuneText.text = "Neptune -  The Imagination and Schemes"
        neptuneText.font = .systemFont(ofSize: 12)
        neptuneText.textColor = .white

        neptuneScrollView.addSubview(neptuneText)

        let plutoText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        plutoText.text = "Pluto - Hidden Forces and Coercion or Cooperation"
        plutoText.font = .systemFont(ofSize: 12)
        plutoText.textColor = .white

        plutoScrollView.addSubview(plutoText)
        
        
        let transitIntro = UILabel(frame: CGRect(x: 5, y: 30, width: scrollView.frame.width - 10, height: 200))
        transitIntro.text = "Year by year, inner forces of nature, represented by the major progressed planets put parts of us in the spotlight and let other parts of you take a break. Tune into your long-term Astrology Inner climate report"
        transitIntro.font = .systemFont(ofSize: 13)
        transitIntro.textColor = .white
        
        transitIntro.numberOfLines = 4
        transitIntro.textAlignment = .center


        scrollView.addSubview(transitIntro)
        //
        //
    }


}

extension MPAspectsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let planet = tableViewToPlanetMap[tableView],
              let majorAspects = chartCake?.constructMajorAspectDictionary2()[planet.celestialObject.keyName] else {
            return 0
        }
        return majorAspects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {
            return UITableViewCell()
        }

        if let planet = tableViewToPlanetMap[tableView],
           let majorAspects = chartCake?.constructMajorAspectDictionary2()[planet.celestialObject.keyName] {

            let aspect = majorAspects[indexPath.row]
            let aspectString = aspect.aspectString

            // Get the start and end dates for the aspect
            var edgeDatesString = ""
            if let celestialAspect = aspect.celestialAspect,
               let edges = chartCake?.findEdgesForAspectsFilteredByPlanet(targetPlanet: planet.celestialObject.keyName, aspects: [aspect]) {

                if let edgeDates = edges[celestialAspect] {
                    edgeDatesString = "\(edgeDates?.start) - \(String(describing: edgeDates?.end))"
                }
            }

            cell.configure(aspectingPlanet: "",
                           secondPlanetImageImageName: "",
                           firstSignTextText: "",
                           secondSignTextText: "",
                           secondPlanetTextText: aspectString,
                           firstPlanetTextText: "",
                           firstAspectHeaderTextText: "",
                           secondAspectHeaderTextText: "")
        }


        return cell
    }




    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let planet = tableViewToPlanetMap[tableView],
           let majorAspects = chartCake?.constructMajorAspectDictionary2()[planet.celestialObject.keyName] {

            let selectedAspect = majorAspects[indexPath.row]
            navigateToMinorAspectViewController(with: selectedAspect)
        }
    }

    func navigateToMinorAspectViewController(with majorAspect: AspectType) {
        let minorAspectVC = ProgressionsMatrixViewController() // Or instantiate from storyboard
        minorAspectVC.chartCake = chartCake
        minorAspectVC.majorAspect = majorAspect
        minorAspectVC.minorAspectsData = [
            majorAspect: chartCake!.filterMinors(for: majorAspect)
        ]
        self.navigationController?.pushViewController(minorAspectVC, animated: true)
    }





}
