//
//  AspectByHouses.swift
//  AstroLogic
//
//  Created by Errick Williams on 8/14/23.
//

import Foundation

//
//  TransposedHousesViewController.swift
//  MVP
//
//  Created by Errick Williams on 10/19/22.
//

import UIKit
import SwiftEphemeris

class ProgressedAspectsByHousesVC: UIViewController {
   
var chart: Chart?
    var chartCake: ChartCake?
    
    var sunAspects = [""]
    var moonAspects = [""]
    var mercuryAspects = [""]
    var venusAspects = [""]
    var marsAspects = [""]
    var jupiterAspects = [""]
    var saturnAspects = [""]
    var uranusAspects = [""]
    var neptuneAspects = [""]
    var plutoAspects = [""]
    
  
    

    
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
    
    private let eleventhScrollView: UIView = {
        let eleventhScrollView = UIView()
       
        return eleventhScrollView
    }()
    private let twelfthScrollView: UIView = {
        let twelfthScrollView = UIView()
       
        return twelfthScrollView
    }()
    
    private let firstTableView: UITableView = {
        let firstTableView = UITableView()
      
            firstTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
            
     
        
        return firstTableView
    }()
    
    private let ascTableView: UITableView = {
        let ascTableView = UITableView()
      
        ascTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
            
     
        
        return ascTableView
    }()
    
    private let secondTableView: UITableView = {
        let secondTableView = UITableView()
        secondTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        
        return secondTableView
    }()
    
    private let thirdTableView: UITableView = {
        let thirdTableView = UITableView()
     
        thirdTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return thirdTableView
    }()
    
    private let fourthTableView: UITableView = {
        let fourthTableView = UITableView()
        fourthTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        return fourthTableView
    }()
    
    private let fifthTableView: UITableView = {
        let fifthTableView = UITableView()
        fifthTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        return fifthTableView
    }()
    
    private let sixthTableView: UITableView = {
        let sixthTableView = UITableView()
        sixthTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        return sixthTableView
    }()
    
    private let seventhTableView: UITableView = {
        let seventhTableView = UITableView()
     
        seventhTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return seventhTableView
    }()
    
    private let eighthTableView: UITableView = {
        let eighthTableView = UITableView()
        eighthTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        return eighthTableView
    }()
    private let ninthTableView: UITableView = {
        let ninthTableView = UITableView()
     
        ninthTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return ninthTableView
    }()
    private let tenthTableView: UITableView = {
        let tenthTableView = UITableView()
     
        tenthTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return tenthTableView
    }()
    
    
    private let eleventhTableView: UITableView = {
        let eleventhTableView = UITableView()
     
        eleventhTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return eleventhTableView
    }()
    private let twelfthTableView: UITableView = {
        let twelfthTableView = UITableView()
     
        twelfthTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return twelfthTableView
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
    
    private let eleventhSignGlyph: UIImageView = {
        let eleventhSignGlyph = UIImageView()
        
        
        return eleventhSignGlyph
        
    }()
    private let twelfthSignGlyph: UIImageView = {
        let twelfthSignGlyph = UIImageView()
        
        
        return twelfthSignGlyph
        
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
        firstTableView.dataSource = self
        firstTableView.delegate = self
       secondTableView.dataSource = self
        secondTableView.delegate = self
        thirdTableView.dataSource = self
        thirdTableView.delegate = self
        fourthTableView.dataSource = self
        fourthTableView.delegate = self
        fifthTableView.dataSource = self
        fifthTableView.delegate = self
        sixthTableView.dataSource = self
        sixthTableView.delegate = self
        seventhTableView.dataSource = self
        seventhTableView.delegate = self
        eighthTableView.dataSource = self
        eighthTableView.delegate = self
        ninthTableView.dataSource = self
        ninthTableView.delegate = self
        tenthTableView.dataSource = self
        tenthTableView.delegate = self
//        ascTableView.dataSource = self
//        ascTableView.delegate = self
        eleventhTableView.dataSource = self
        eleventhTableView.delegate = self
        twelfthTableView.dataSource = self
        twelfthTableView.delegate = self
        view.backgroundColor = .black
        
      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firstTableView.frame = CGRect(x: firstTableView.frame.origin.x, y: firstTableView.frame.origin.y , width: firstTableView.frame.size.width, height: firstTableView.contentSize.height)
        
        secondTableView.frame = CGRect(x: secondTableView.frame.origin.x, y: secondTableView.frame.origin.y , width: secondTableView.frame.size.width, height: secondTableView.contentSize.height)
        
        thirdTableView.frame = CGRect(x: thirdTableView.frame.origin.x, y: thirdTableView.frame.origin.y , width: thirdTableView.frame.size.width, height: thirdTableView.contentSize.height)
        
        fourthTableView.frame = CGRect(x: fourthTableView.frame.origin.x, y: fourthTableView.frame.origin.y, width: fourthTableView.frame.size.width, height: fourthTableView.contentSize.height)
        
        fifthTableView.frame = CGRect(x: fifthTableView.frame.origin.x, y: fifthTableView.frame.origin.y , width: fifthTableView.frame.size.width, height: fifthTableView.contentSize.height)
        
        sixthTableView.frame = CGRect(x: sixthTableView.frame.origin.x, y: sixthTableView.frame.origin.y , width: sixthTableView.frame.size.width, height: sixthTableView.contentSize.height)
        
        seventhTableView.frame = CGRect(x: seventhTableView.frame.origin.x, y: seventhTableView.frame.origin.y , width: seventhTableView.frame.size.width, height: seventhTableView.contentSize.height)
        
        eighthTableView.frame = CGRect(x: eighthTableView.frame.origin.x, y: eighthTableView.frame.origin.y , width: eighthTableView.frame.size.width, height: eighthTableView.contentSize.height)
        
       ninthTableView.frame = CGRect(x: ninthTableView.frame.origin.x, y: ninthTableView.frame.origin.y , width: ninthTableView.frame.size.width, height: ninthTableView.contentSize.height)
        
        tenthTableView.frame = CGRect(x: tenthTableView.frame.origin.x, y: tenthTableView.frame.origin.y , width: tenthTableView.frame.size.width, height: tenthTableView.contentSize.height)
        
        eleventhTableView.frame = CGRect(x: eleventhTableView.frame.origin.x, y: eleventhTableView.frame.origin.y , width: eleventhTableView.frame.size.width, height: eleventhTableView.contentSize.height)
         
        twelfthTableView.frame = CGRect(x: twelfthTableView.frame.origin.x, y: twelfthTableView.frame.origin.y , width: twelfthTableView.frame.size.width, height: twelfthTableView.contentSize.height)
        
        
        
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
        
        
        
        sunScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
        scrollView.addSubview(sunScrollView)
//        sunScrollView.contentSize = CGSize(width: 300, height: 200)
        
//        firstTableView.backgroundColor = .orange
        secondTableView.backgroundColor = .green

       thirdTableView.backgroundColor = .purple

        fourthTableView.backgroundColor = .yellow
       fifthTableView.backgroundColor = .red
       sixthTableView.backgroundColor = .systemGroupedBackground
        seventhTableView.backgroundColor = .blue
        eighthTableView.backgroundColor = .white
       ninthTableView.backgroundColor = .gray
        tenthTableView.backgroundColor = .systemPink

//      view.frame = CGRect(x: 0, y: 0, width: 400, height: 6000)
   
   
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 4000)
        let tableViews = [firstTableView, secondTableView, thirdTableView, fourthTableView, fifthTableView, sixthTableView, seventhTableView, eighthTableView, ninthTableView, tenthTableView, eleventhTableView, twelfthTableView]

        for (index, tableView) in tableViews.enumerated() {
            let count = chartCake?.progressedAspectsFilteredByHouseRulers(house: index + 1).count ?? 0
            tableView.contentSize.height = CGFloat(count * 90)
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
    
        scrollView.addSubview(eleventhScrollView)
//        neptuneScrollView.contentSize = CGSize(width: 300, height: 200)
        eleventhScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
        
        scrollView.addSubview(twelfthScrollView)
//        plutoScrollView.contentSize = CGSize(width: 300, height: 200)
        twelfthScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
    
        
        
        
        
        
        
        
//        sunScrollView.addSubview(tenthTableView)
        // Do any additional setup after loading the view.
        
   
//        sunScrollView.frame = CGRect(x: 10, y: 150, width: view.frame.size.width - 20, height: view.frame.size.height - 20)
//
        let mySignCusps = [chart?.houseCusps.first.sign.keyName, chart?.houseCusps.second.sign.keyName, chart?.houseCusps.third.sign.keyName, chart?.houseCusps.fourth.sign.keyName, chart?.houseCusps.fifth.sign.keyName, chart?.houseCusps.sixth.sign.keyName, chart?.houseCusps.seventh.sign.keyName, chart?.houseCusps.eighth.sign.keyName, chart?.houseCusps.ninth.sign.keyName, chart?.houseCusps.tenth.sign.keyName, chart?.houseCusps.eleventh.sign.keyName, chart?.houseCusps.twelfth.sign.keyName ]
        
        sunSignGlyph.image = UIImage(named: mySignCusps[0]!)
        sunSignGlyph.image?.withTintColor(UIColor.yellow)
        
        sunSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        sunScrollView.addSubview(sunSignGlyph)
        sunSignGlyph.backgroundColor = .clear
        
        
        moonSignGlyph.image = UIImage(named: mySignCusps[1]!)
        moonSignGlyph.image?.withTintColor(UIColor.yellow)
        
        moonSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        moonScrollView.addSubview(moonSignGlyph)
        moonSignGlyph.backgroundColor = .clear
        
        
        mercurySignGlyph.image = UIImage(named: mySignCusps[2]!)
        mercurySignGlyph.image?.withTintColor(UIColor.yellow)
        
        mercurySignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        mercuryScrollView.addSubview(mercurySignGlyph)
        mercurySignGlyph.backgroundColor = .clear
        
        
        venusSignGlyph.image = UIImage(named: mySignCusps[3]!)
        venusSignGlyph.image?.withTintColor(UIColor.yellow)
        
        venusSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        venusScrollView.addSubview(venusSignGlyph)
        venusSignGlyph.backgroundColor = .clear
        
        
        marsSignGlyph.image = UIImage(named: mySignCusps[4]!)
        marsSignGlyph.image?.withTintColor(UIColor.yellow)
        
        marsSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        marsScrollView.addSubview(marsSignGlyph)
        marsSignGlyph.backgroundColor = .clear
        
        
        jupiterSignGlyph.image = UIImage(named: mySignCusps[5]!)
        jupiterSignGlyph.image?.withTintColor(UIColor.yellow)
        
        jupiterSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        jupiterScrollView.addSubview(jupiterSignGlyph)
        jupiterSignGlyph.backgroundColor = .clear
        
        
        saturnSignGlyph.image = UIImage(named: mySignCusps[6]!)
        saturnSignGlyph.image?.withTintColor(UIColor.yellow)
        
        saturnSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        saturnScrollView.addSubview(saturnSignGlyph)
        saturnSignGlyph.backgroundColor = .clear
        
        
        uranusSignGlyph.image = UIImage(named: mySignCusps[7]!)
        uranusSignGlyph.image?.withTintColor(UIColor.yellow)
        
        uranusSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        uranusScrollView.addSubview(uranusSignGlyph)
        uranusSignGlyph.backgroundColor = .clear
        
    
        neptuneSignGlyph.image = UIImage(named: mySignCusps[8]!)
        neptuneSignGlyph.image?.withTintColor(UIColor.yellow)
        
        neptuneSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        neptuneScrollView.addSubview(neptuneSignGlyph)
        neptuneSignGlyph.backgroundColor = .clear
        
        
        plutoSignGlyph.image = UIImage(named: mySignCusps[9]!)
        plutoSignGlyph.image?.withTintColor(UIColor.yellow)
        
        plutoSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        plutoScrollView.addSubview(plutoSignGlyph)
        plutoSignGlyph.backgroundColor = .clear
        
     
        
        eleventhSignGlyph.image = UIImage(named: mySignCusps[10]!)
        eleventhSignGlyph.image?.withTintColor(UIColor.yellow)
        
        eleventhSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        eleventhScrollView.addSubview(eleventhSignGlyph)
        eleventhSignGlyph.backgroundColor = .clear
        
        
        twelfthSignGlyph.image = UIImage(named: mySignCusps[11]!)
        twelfthSignGlyph.image?.withTintColor(UIColor.yellow)
        
        twelfthSignGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        
        twelfthScrollView.addSubview(twelfthSignGlyph)
        twelfthSignGlyph.backgroundColor = .clear
        
      
      
        
        sunScrollView.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: firstTableView.contentSize.height + 40)
        
        firstTableView.frame = CGRect(x: 10, y: 35, width: sunScrollView.frame.size.width , height: firstTableView.contentSize.height)

        sunScrollView.addSubview(firstTableView)
        
        
        moonScrollView.frame = CGRect(x: 0, y: sunScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: secondTableView.contentSize.height + 40)
        secondTableView.frame = CGRect(x: 10, y: 35, width: moonScrollView.frame.size.width , height: moonScrollView.frame.size.height - 60)

        moonScrollView.addSubview(secondTableView)
        
        
        
        
        mercuryScrollView.frame = CGRect(x: 0, y: moonScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: thirdTableView.contentSize.height + 40)
        mercuryScrollView.addSubview(thirdTableView)
       
        
        
        venusScrollView.frame = CGRect(x: 0, y: mercuryScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: fourthTableView.contentSize.height + 40)
        venusScrollView.addSubview(fourthTableView)
      
        marsScrollView.frame = CGRect(x: 0, y: venusScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: fifthTableView.contentSize.height + 40)
        marsScrollView.addSubview(fifthTableView)
       
        jupiterScrollView.frame = CGRect(x: 0, y: marsScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: sixthTableView.contentSize.height + 40)
        jupiterScrollView.addSubview(sixthTableView)
       
        saturnScrollView.frame = CGRect(x: 0, y: jupiterScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: seventhTableView.contentSize.height + 40)
        saturnScrollView.addSubview(seventhTableView)
        
        uranusScrollView.frame = CGRect(x: 0, y: saturnScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: eighthTableView.contentSize.height + 40)
        uranusScrollView.addSubview(eighthTableView)
        
        neptuneScrollView.frame = CGRect(x: 0, y: uranusScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: ninthTableView.contentSize.height + 40)
        neptuneScrollView.addSubview(ninthTableView)
       
        plutoScrollView.frame = CGRect(x: 0, y: neptuneScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: tenthTableView.contentSize.height + 40)
        plutoScrollView.addSubview(tenthTableView)
        
        
        eleventhScrollView.frame = CGRect(x: 0, y: plutoScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: eleventhTableView.contentSize.height + 40)
        eleventhScrollView.addSubview(eleventhTableView)
       
        twelfthScrollView.frame = CGRect(x: 0, y: eleventhScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: twelfthTableView.contentSize.height + 40)
        twelfthScrollView.addSubview(twelfthTableView)
//
       
//
       
       
        thirdTableView.frame = CGRect(x: 10, y: 35, width: mercuryScrollView.frame.size.width , height: mercuryScrollView.frame.size.height - 60)

        fourthTableView.frame = CGRect(x: 10, y: 35, width: venusScrollView.frame.size.width , height: venusScrollView.frame.size.height - 60)

        fifthTableView.frame = CGRect(x: 10, y: 35, width: marsScrollView.frame.size.width , height: marsScrollView.frame.size.height - 60)

        sixthTableView.frame = CGRect(x: 10, y: 35, width: jupiterScrollView.frame.size.width , height: jupiterScrollView.frame.size.height - 60)

        seventhTableView.frame = CGRect(x: 10, y: 35, width: saturnScrollView.frame.size.width , height: saturnScrollView.frame.size.height - 60)

        eighthTableView.frame = CGRect(x: 10, y: 35, width: uranusScrollView.frame.size.width , height: uranusScrollView.frame.size.height - 20)
        ninthTableView.frame = CGRect(x: 10, y: 35, width: neptuneScrollView.frame.size.width , height: neptuneScrollView.frame.size.height - 60)
        tenthTableView.frame = CGRect(x: 10, y: 35, width: plutoScrollView.frame.size.width , height: plutoScrollView.frame.size.height - 60)
        
        
        eleventhTableView.frame = CGRect(x: 10, y: 35, width: eleventhScrollView.frame.size.width , height: eleventhScrollView.frame.size.height - 60)
        twelfthTableView.frame = CGRect(x: 10, y: 35, width: twelfthScrollView.frame.size.width , height: twelfthScrollView.frame.size.height - 60)
        
        
        let sunText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        sunText.text = "First House - Personality"
        sunText.font = .systemFont(ofSize: 16)
        sunText.textColor = .white
       
         sunScrollView.addSubview(sunText)
        
        let moonText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        moonText.text = "Second House - Resources"
        moonText.font = .systemFont(ofSize: 16)
        moonText.textColor = .white
       
         moonScrollView.addSubview(moonText)
        
        let mercuryText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        mercuryText.text = "Third House - Finding Your Voice"
        mercuryText.font = .systemFont(ofSize: 16)
        mercuryText.textColor = .white
       
         mercuryScrollView.addSubview(mercuryText)
        
        let venusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        venusText.text = "Fourth House - Home and Family"
        venusText.font = .systemFont(ofSize: 16)
        venusText.textColor = .white
       
         venusScrollView.addSubview(venusText)
        
        let marsText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        marsText.text = "Fifth House - Fun"
        marsText.font = .systemFont(ofSize: 16)
        marsText.textColor = .white
       
         marsScrollView.addSubview(marsText)
        
        let jupiterText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        jupiterText.text = "Sixth House - Skill Development"
        jupiterText.font = .systemFont(ofSize: 16)
        jupiterText.textColor = .white
       
         jupiterScrollView.addSubview(jupiterText)
        
        let saturnText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        saturnText.text = "Seventh House - Partnerships"
        saturnText.font = .systemFont(ofSize: 16)
        saturnText.textColor = .white
       
         saturnScrollView.addSubview(saturnText)
        
        let uranusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        uranusText.text = "Eighth House - The Occult"
        uranusText.font = .systemFont(ofSize: 16)
        uranusText.textColor = .white
       
         uranusScrollView.addSubview(uranusText)
        
        let neptuneText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        neptuneText.text = "Ninth House - Philosophy"
        neptuneText.font = .systemFont(ofSize: 16)
        neptuneText.textColor = .white
       
         neptuneScrollView.addSubview(neptuneText)
        
        let plutoText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        plutoText.text = "Tenth House - Role in the Community"
        plutoText.font = .systemFont(ofSize: 16)
        plutoText.textColor = .white
       
         plutoScrollView.addSubview(plutoText)
        
        let eleventhText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        eleventhText.text = "Eleventh House - Friends"
        eleventhText.font = .systemFont(ofSize: 16)
        eleventhText.textColor = .white
       
         eleventhScrollView.addSubview(eleventhText)
        
        let twelfthText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        twelfthText.text = "Twelfth House - Endings"
        twelfthText.font = .systemFont(ofSize: 16)
        twelfthText.textColor = .white
       
         twelfthScrollView.addSubview(twelfthText)
        
        
        let transitIntro = UILabel(frame: CGRect(x: 5, y: 30, width: scrollView.frame.width - 10, height: 200))
        transitIntro.text = "Houses represent specific fields of activity. They are life’s stages and arenas, the tangible theaters in which identity is made visible through action."
        transitIntro.font = .systemFont(ofSize: 13)
        transitIntro.textColor = .white
        
        transitIntro.numberOfLines = 4
        transitIntro.textAlignment = .center
       
       
         scrollView.addSubview(transitIntro)
//
//
    }


}

extension ProgressedAspectsByHousesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableViews = [firstTableView, secondTableView, thirdTableView, fourthTableView, fifthTableView, sixthTableView, seventhTableView, eighthTableView, ninthTableView, tenthTableView, eleventhTableView, twelfthTableView]
        
        if let index = tableViews.firstIndex(of: tableView) {
            return chartCake?.progressedAspectsFilteredByHouseRulers(house: index + 1).count ?? 0
        }
        
        return 0 // Default return in case tableView is not found
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViews = [firstTableView, secondTableView, thirdTableView, fourthTableView, fifthTableView, sixthTableView, seventhTableView, eighthTableView, ninthTableView, tenthTableView, eleventhTableView, twelfthTableView]
        
        if let index = tableViews.firstIndex(of: tableView) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {
                return UITableViewCell()
            }
            
            if let keyName = chartCake?.progressedAspectsFilteredByHouseRulers(house: index + 1)[indexPath.row].basicAspectString {
                cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: keyName, firstPlanetTextText: "", firstAspectHeaderTextText: " ", secondAspectHeaderTextText: " ")
            }
            
            return cell
        }
        
        return UITableViewCell() // Default cell in case tableView is not found
    }

           
           
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 // returns fixed height for all rows, regardless of the tableView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // remove all the code related to expanding and collapsing
    }
 

    }
    
    
    
