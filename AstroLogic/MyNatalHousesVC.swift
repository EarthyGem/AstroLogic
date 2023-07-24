//
//  TransposedHousesViewController.swift
//  MVP
//
//  Created by Errick Williams on 10/19/22.
//

import UIKit
import SwiftEphemeris

class MyNatalHousesVC: UIViewController {
   
var chart: Chart?
    
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
    
    private let sunTableView: UITableView = {
        let sunTableView = UITableView()
      
            sunTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
            
     
        
        return sunTableView
    }()
    
    private let ascTableView: UITableView = {
        let ascTableView = UITableView()
      
        ascTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
            
     
        
        return ascTableView
    }()
    
    private let moonTableView: UITableView = {
        let moonTableView = UITableView()
        moonTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        
        return moonTableView
    }()
    
    private let mercuryTableView: UITableView = {
        let mercuryTableView = UITableView()
     
        mercuryTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return mercuryTableView
    }()
    
    private let venusTableView: UITableView = {
        let venusTableView = UITableView()
        venusTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        return venusTableView
    }()
    
    private let marsTableView: UITableView = {
        let marsTableView = UITableView()
        marsTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        return marsTableView
    }()
    
    private let jupiterTableView: UITableView = {
        let jupiterTableView = UITableView()
        jupiterTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        return jupiterTableView
    }()
    
    private let saturnTableView: UITableView = {
        let saturnTableView = UITableView()
     
        saturnTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return saturnTableView
    }()
    
    private let uranusTableView: UITableView = {
        let uranusTableView = UITableView()
        uranusTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        
        return uranusTableView
    }()
    private let neptuneTableView: UITableView = {
        let neptuneTableView = UITableView()
     
        neptuneTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return neptuneTableView
    }()
    private let plutoTableView: UITableView = {
        let plutoTableView = UITableView()
     
        plutoTableView.register(HousesCustomTableViewCell.self, forCellReuseIdentifier: HousesCustomTableViewCell.identifier)
        return plutoTableView
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
        eleventhTableView.dataSource = self
        eleventhTableView.delegate = self
        twelfthTableView.dataSource = self
        twelfthTableView.delegate = self
        view.backgroundColor = .black
        
      
        
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
        sunTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 1).count)! * 90)
       moonTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 2).count)! * 90)
        mercuryTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 3).count)! * 90)
        venusTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 4).count)! * 90)
        marsTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 5).count)! * 90)
        jupiterTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 6).count)! * 90)
        saturnTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 7).count)! * 90)
        uranusTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 8).count)! * 90)
        neptuneTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 9).count)! * 90)
        plutoTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 10).count)! * 90)
        eleventhTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 11).count)! * 90)
        twelfthTableView.contentSize.height = CGFloat((chart?.rulingPLanets(for: 12).count)! * 90)
        
        
        
        
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
    
        
        
        
        
        
        
        
//        sunScrollView.addSubview(plutoTableView)
        // Do any additional setup after loading the view.
        
   
//        sunScrollView.frame = CGRect(x: 10, y: 150, width: view.frame.size.width - 20, height: view.frame.size.height - 20)
//
        var mySignCusps = [chart?.houseCusps.first.sign.keyName, chart?.houseCusps.second.sign.keyName, chart?.houseCusps.third.sign.keyName, chart?.houseCusps.fourth.sign.keyName, chart?.houseCusps.fifth.sign.keyName, chart?.houseCusps.sixth.sign.keyName, chart?.houseCusps.seventh.sign.keyName, chart?.houseCusps.eighth.sign.keyName, chart?.houseCusps.ninth.sign.keyName, chart?.houseCusps.tenth.sign.keyName, chart?.houseCusps.eleventh.sign.keyName, chart?.houseCusps.twelfth.sign.keyName ]
        
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
        
        
        eleventhScrollView.frame = CGRect(x: 0, y: plutoScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: eleventhTableView.contentSize.height + 40)
        eleventhScrollView.addSubview(eleventhTableView)
       
        twelfthScrollView.frame = CGRect(x: 0, y: eleventhScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: twelfthTableView.contentSize.height + 40)
        twelfthScrollView.addSubview(twelfthTableView)
//
       
//
       
       
        mercuryTableView.frame = CGRect(x: 10, y: 35, width: mercuryScrollView.frame.size.width , height: mercuryScrollView.frame.size.height - 60)

        venusTableView.frame = CGRect(x: 10, y: 35, width: venusScrollView.frame.size.width , height: venusScrollView.frame.size.height - 60)

        marsTableView.frame = CGRect(x: 10, y: 35, width: marsScrollView.frame.size.width , height: marsScrollView.frame.size.height - 60)

        jupiterTableView.frame = CGRect(x: 10, y: 35, width: jupiterScrollView.frame.size.width , height: jupiterScrollView.frame.size.height - 60)

        saturnTableView.frame = CGRect(x: 10, y: 35, width: saturnScrollView.frame.size.width , height: saturnScrollView.frame.size.height - 60)

        uranusTableView.frame = CGRect(x: 10, y: 35, width: uranusScrollView.frame.size.width , height: uranusScrollView.frame.size.height - 20)
        neptuneTableView.frame = CGRect(x: 10, y: 35, width: neptuneScrollView.frame.size.width , height: neptuneScrollView.frame.size.height - 60)
        plutoTableView.frame = CGRect(x: 10, y: 35, width: plutoScrollView.frame.size.width , height: plutoScrollView.frame.size.height - 60)
        
        
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

extension MyNatalHousesVC: UITableViewDataSource, UITableViewDelegate {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               
                
                if(tableView == sunTableView) {
                    
                    return (chart?.rulingPLanets(for: 1).count)!
                    
                }
                    else if(tableView == moonTableView){
                        return (chart?.rulingPLanets(for: 2).count)!
                        
                    }
                    else if(tableView == mercuryTableView){

                        return (chart?.rulingPLanets(for: 3).count)!
                    }
                    else if(tableView == venusTableView){

                        return (chart?.rulingPLanets(for: 4).count)!
                        }
                else if(tableView == marsTableView){

                    return (chart?.rulingPLanets(for: 5).count)!
                            }
                else if(tableView == jupiterTableView){

                    return (chart?.rulingPLanets(for: 6).count)!
                                }
                else if(tableView == saturnTableView){

                    return (chart?.rulingPLanets(for: 7).count)!
                                    }
                else if(tableView == uranusTableView){

                    return (chart?.rulingPLanets(for: 8).count)!
                                        }
                else if(tableView == neptuneTableView){

                    return (chart?.rulingPLanets(for: 9).count)!
                                            }
                else if(tableView == plutoTableView){

                    return (chart?.rulingPLanets(for: 10).count)!
                                        }
                else if(tableView == eleventhTableView){

                    return (chart?.rulingPLanets(for: 11).count)!
                                            }
                else {

                    return (chart?.rulingPLanets(for: 12).count)!

            }
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                if(tableView == sunTableView) {

                    
                    guard let cell = sunTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }

                 

                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 1)[indexPath.row].keyName)!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                    
    
                   
                   return cell
                   
            }
                else if(tableView == moonTableView){
                    
                    guard let cell = moonTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }
             
                  cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 2)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                }
                
                
            
                

                else if(tableView == mercuryTableView){

                    
                    guard let cell = mercuryTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }
                  
              
                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 3)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   return cell
                   
                }
                    else if(tableView == venusTableView){

                        
                        guard let cell = venusTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                           return UITableViewCell()
                       }

//                        var transitVenusAspects = [mercuryVenus,saturnVenus,uranusVenus]
                   
                        
                          cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 4)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                       return cell
                       
                    
                       
                        }
                else if(tableView == marsTableView){

                    
                    guard let cell = marsTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }

                   
                 

                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 5)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                            }
                else if(tableView == jupiterTableView){

                    
                    guard let cell = jupiterTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }

//                    var transitJupiterAspects = [plutoJupiter]
//                    var transitJupiterGlyph = ["pluto"]
//                    var transitJupiterDurantion = [""]

                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 6)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                                }
                else if(tableView == saturnTableView){

                    
                    guard let cell = saturnTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }

//                    var transitSaturnAspects = [jupiterSaturn]
//                    var transitSaturnGlyph = ["jupiter"]
//                    var transitSaturnDuration = ["jupiter"]
                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 7)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                                    }
                else if(tableView == uranusTableView){

                    
                    guard let cell = uranusTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }

//                    var transitUranusAspects = [marsUranus,neptuneUranus]
//                    var transitUranusGlyph = ["mars","neptune"]
//                    var transitUranusDuration = ["mars","neptune"]

                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 8)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   return cell
                   
                                        }
                else if(tableView == neptuneTableView){

                    
                    guard let cell = neptuneTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }

//                    var transitNeptuneAspects = [sunNeptune,venusNeptune]
//                    var transitNeptuneGlyph = ["sun","venus"]
//                    var transitNeptuneDuration = ["mercury"]


                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 9)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
//
                   return cell
                   
                                            }
                
               else if (tableView == plutoTableView) {

                    
                    guard let cell = plutoTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }

                 
//                    var transitSunAspects = [sunSun,venusSun,jupiterSun]
                 
                   cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 10)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
            }
                
                else if (tableView == eleventhTableView) {

                     
                     guard let cell = eleventhTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                        return UITableViewCell()
                    }

                  
 //                    var transitSunAspects = [sunSun,venusSun,jupiterSun]
                 
                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 11)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )

                    
                    return cell
                    
             }
                 
                
                else {

                    
                    guard let cell = twelfthTableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {

                       return UITableViewCell()
                   }

//                    var transitPlutoAspects = [""]
//                    var transitPlutoGlyph = [""]
//                    var transitPlutoDuration = [""]
//
               cell.configure(aspectingPlanet: "", secondPlanetImageImageName: (chart?.rulingPLanets(for: 12)[indexPath.row].keyName.lowercased())!, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )

                   
                   return cell
                   


            }





            }
            
               
               
           
           
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 // returns fixed height for all rows, regardless of the tableView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // remove all the code related to expanding and collapsing
    }
 

    }
    
    
    
                
                
                
                
                
                
//
//                let selectedVC = FirstFirstHousePlanetViewController.self
//                performSegue(withIdentifier: "firstHouse1", sender: selectedVC)

