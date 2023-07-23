//
//  TransitAspectedPlanetsViewController.swift
//  MVP
//
//  Created by Errick Williams on 10/19/22.
//

import UIKit

class MPAspectsViewController: UIViewController {
   
    var Ricky = "Ricky"
    
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
        
        topTransitImage.frame = CGRect(x: 0, y: 40, width: view.frame.width, height: 350)
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
        sunTableView.contentSize.height = CGFloat(0 * 90)
//        sunTableView.contentSize = CGSize(width: view.frame.width, height: numbers)
       moonTableView.contentSize.height = CGFloat(0 * 90)
        mercuryTableView.contentSize.height = CGFloat(0 * 90)
        venusTableView.contentSize.height = CGFloat(0 * 90)
        marsTableView.contentSize.height = CGFloat(0 * 90)
        jupiterTableView.contentSize.height = CGFloat(0 * 90)
        saturnTableView.contentSize.height = CGFloat(0 * 90)
        uranusTableView.contentSize.height = CGFloat(0 * 90)
        neptuneTableView.contentSize.height = CGFloat(0 * 90)
        plutoTableView.contentSize.height = CGFloat(0 * 90)
        
        
        
        
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
        sunText.text = "Sun"
        sunText.font = .systemFont(ofSize: 16)
        sunText.textColor = .white
       
         sunScrollView.addSubview(sunText)
        
        let moonText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        moonText.text = "Moon"
        moonText.font = .systemFont(ofSize: 16)
        moonText.textColor = .white
       
         moonScrollView.addSubview(moonText)
        
        let mercuryText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        mercuryText.text = "Mercury"
        mercuryText.font = .systemFont(ofSize: 16)
        mercuryText.textColor = .white
       
         mercuryScrollView.addSubview(mercuryText)
        
        let venusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        venusText.text = "Venus"
        venusText.font = .systemFont(ofSize: 16)
        venusText.textColor = .white
       
         venusScrollView.addSubview(venusText)
        
        let marsText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        marsText.text = "Mars"
        marsText.font = .systemFont(ofSize: 16)
        marsText.textColor = .white
       
         marsScrollView.addSubview(marsText)
        
        let jupiterText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        jupiterText.text = "Jupiter"
        jupiterText.font = .systemFont(ofSize: 16)
        jupiterText.textColor = .white
       
         jupiterScrollView.addSubview(jupiterText)
        
        let saturnText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        saturnText.text = "Saturn"
        saturnText.font = .systemFont(ofSize: 16)
        saturnText.textColor = .white
       
         saturnScrollView.addSubview(saturnText)
        
        let uranusText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        uranusText.text = "Uranus"
        uranusText.font = .systemFont(ofSize: 16)
        uranusText.textColor = .white
       
         uranusScrollView.addSubview(uranusText)
        
        let neptuneText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        neptuneText.text = "Neptune"
        neptuneText.font = .systemFont(ofSize: 16)
        neptuneText.textColor = .white
       
         neptuneScrollView.addSubview(neptuneText)
        
        let plutoText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
        plutoText.text = "Pluto"
        plutoText.font = .systemFont(ofSize: 16)
        plutoText.textColor = .white
       
         plutoScrollView.addSubview(plutoText)
        
        let transitIntro = UILabel(frame: CGRect(x: 5, y: 30, width: scrollView.frame.width - 10, height: 200))
        transitIntro.text = "Week by week, inner forces of nature, represented by the moving planets put parts of you in the spotlight and let other parts of you take a break. Tune into your Astrology Inner weather report"
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
               
                
                if(tableView == sunTableView) {

                    return 0
            }
                else if(tableView == moonTableView){
                    return 0
                }
                
                
                    else if(tableView == mercuryTableView){

                        return 0
                    }
                    else if(tableView == venusTableView){

                            return 0
                        }
                else if(tableView == marsTableView){

                                return 0
                            }
                else if(tableView == jupiterTableView){

                                    return 0
                                }
                else if(tableView == saturnTableView){

                                        return 0
                                    }
                else if(tableView == uranusTableView){

                                            return 0
                                        }
                else if(tableView == neptuneTableView){

                                                return 0
                                            }
                else {

                                                    return 0



            }
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                if(tableView == sunTableView) {

                    
                    guard let cell = sunTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }

                 
                  
                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                    
//                    cell.dropDownText(transit1: "lKSACFhouEFHQVBIYEVBilvywbviy", transit2: "kabevovBNOVWIBWvo;wrbva", transit3: "qek.BVFbeqvV", transit4: "ALENVFoe;wvno;Vojw", myTableCell: sunScrollView)
////
//                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: MajorMoonAspects2()[indexPath.row], firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "", firstPlanetTextText: transitSunAspects[indexPath.row],firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
            }
                else if(tableView == moonTableView){
                    
                    guard let cell = moonTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }
                 

                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                }
                
                
            
                

                else if(tableView == mercuryTableView){

                    
                    guard let cell = mercuryTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }
                 
                    
    
                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   return cell
                   
                }
                    else if(tableView == venusTableView){

                        
                        guard let cell = venusTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                           return UITableViewCell()
                       }

                   
                   
                        
                        cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                       return cell
                       
                    
                       
                        }
                else if(tableView == marsTableView){

                    
                    guard let cell = marsTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }

                    
               

                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                            }
                else if(tableView == jupiterTableView){

                    
                    guard let cell = jupiterTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }

                 
         

                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                                }
                else if(tableView == saturnTableView){

                    
                    guard let cell = saturnTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }

//                    var transitSaturnAspects = [plutoSaturn]
      
                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   return cell
                   
                                    }
                else if(tableView == uranusTableView){

                    
                    guard let cell = uranusTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }

               
       
                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                                        }
                else if(tableView == neptuneTableView){

                    
                    guard let cell = neptuneTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }

          
                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   
                                            }
                else {

                    
                    guard let cell = plutoTableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {

                       return UITableViewCell()
                   }

                    

                    cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: "Sep 13, 2022 - Feb 16, 2023", firstPlanetTextText: "",firstAspectHeaderTextText: " ",secondAspectHeaderTextText: " " )
                   
                   return cell
                   


            }
            }
            
               
               
           
           
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               
               
               
               if(tableView == sunTableView) {
                   
                   if self.SelectedIndex == indexPath.row && isCollapsed == true{
                       return 243
                   }else
                   {
                       return 90
                   }

           }
           
               

               else if(tableView == moonTableView){

                   if self.SelectedIndex == indexPath.row && isCollapsed == true{
                       return 243
                   }else
                   {
                       return 90
                   }

           }
                   else if(tableView == mercuryTableView){

                       if self.SelectedIndex == indexPath.row && isCollapsed == true{
                           return 243
                       }else
                       {
                           return 90
                       }

               }
                   else if(tableView == venusTableView){

                       if self.SelectedIndex == indexPath.row && isCollapsed == true{
                           return 243
                       }else
                       {
                           return 90
                       }

               }
               else if(tableView == marsTableView){

                   if self.SelectedIndex == indexPath.row && isCollapsed == true{
                       return 243
                   }else
                   {
                       return 90
                   }

           }
               else if(tableView == jupiterTableView){

                   if self.SelectedIndex == indexPath.row && isCollapsed == true{
                       return 243
                   }else
                   {
                       return 90
                   }

           }
               else if(tableView == saturnTableView){
                   if self.SelectedIndex == indexPath.row && isCollapsed == true{
                       return 243
                   }else
                   {
                       return 90
                   }

           }
               else if(tableView == uranusTableView){

                   if self.SelectedIndex == indexPath.row && isCollapsed == true{
                       return 243
                   }else
                   {
                       return 90
                   }

           }
               else if(tableView == neptuneTableView){

                   if self.SelectedIndex == indexPath.row && isCollapsed == true{
                       return 243
                   }else
                   {
                       return 90
                   }

           }
               else {

                   if self.SelectedIndex == indexPath.row && isCollapsed == true{
                       return 243
                   }else
                   {
                       return 90
                   }

           }
           }
              
           
            
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                
                
                if SelectedIndex == indexPath.row
                {
                    if self.isCollapsed == false
                    {
                        self.isCollapsed = true
                        
                    }else
                    {
                        self.isCollapsed = false
                    }
                } else {
                        self.isCollapsed = true}
                    self.SelectedIndex = indexPath.row
                    sunTableView.reloadRows(at: [indexPath], with: .automatic)

                
                    }
    
    
    
    private func tableView2(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
        if(tableView == mercuryTableView) && SelectedIndex == indexPath.row {
        
     
    
        if self.isCollapsed == false
        {
            self.isCollapsed = true
            
        }else
        {
            self.isCollapsed = false
        }
    } else {
            self.isCollapsed = true
        
    }
        self.SelectedIndex = indexPath.row
        sunTableView.reloadRows(at: [indexPath], with: .automatic)

        
        if(tableView == moonTableView) && SelectedIndex == indexPath.row {
        
     
    
        if self.isCollapsed == false
        {
            self.isCollapsed = true
            
        }else
        {
            self.isCollapsed = false
        }
    } else {
            self.isCollapsed = true
        
    }
        self.SelectedIndex = indexPath.row
        sunTableView.reloadRows(at: [indexPath], with: .automatic)

        
        
    
        }

    
 

    }
    
    
    
                
                
                
                
                
                
//
//                let selectedVC = FirstFirstHousePlanetViewController.self
//                performSegue(withIdentifier: "firstHouse1", sender: selectedVC)

