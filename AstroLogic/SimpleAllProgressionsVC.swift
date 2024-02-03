//
//  SimpleTransitAspects.swift
//  AstroLogic
//
//  Created by Errick Williams on 8/23/23.
//

import Foundation
import UIKit
import SwiftEphemeris

enum SectionType: Int, CaseIterable {
   case majors = 0, solarArcs, minors, transits

   var title: String {
       switch self {
       case .majors: return "Majors"
       case .solarArcs: return "Solar Arcs"
       case .minors: return "Minors"
       case .transits: return "Transits"
       }
   }
}
struct PlanetAspectCounts {
    var majors: Int
    var solarArcs: Int
    var minors: Int
    var transits: Int
    var majorsAspects: [String]
    var solarArcsAspects: [String]
    var minorsAspects: [String]
    var transitsAspects: [String]
}



class SimpleAllProgressionsAspectedPlanetsViewController  : UIViewController, KeywordSelectionViewControllerDelegate {
    
    
    
    var chart: Chart?
    var chartCake: ChartCake?
    var selectedDate: Date?
    var planetAspectCountCache: [Planet: PlanetAspectCounts] = [:]
    let houseKeywords: [String: [String]] = [
        "1st House": ["Self", "Appearance", "Beginnings", "Initiative"],
        "2nd House": ["Value", "Material", "Possessions", "Security"],
        "3rd House": ["Communication", "Siblings", "Short Trips", "Learning"],
        "4th House": ["Home", "Family", "Roots", "Security"],
        "5th House": ["Creativity", "Romance", "Pleasure", "Children"],
        "6th House": ["Service", "Health", "Routine", "Duty"],
        "7th House": ["Partnerships", "Marriage", "Contracts", "Open Enemies"],
        "8th House": ["Transformation", "Sexuality", "Shared Resources", "Intimacy"],
        "9th House": ["Beliefs", "Philosophy", "Travel", "Higher Education"],
        "10th House": ["Career", "Reputation", "Status", "Achievement"],
        "11th House": ["Friendship", "Community", "Aspirations", "Groups"],
        "12th House": ["Subconscious", "Hidden Strengths", "Secrets", "Sacrifice"]
    ]
    
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let sunCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let moonCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let mercuryCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let venusCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let marsCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let jupiterCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let saturnCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let uranusCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let neptuneCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let plutoCapsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        return label
    }()
    
    private let sunCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let moonCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let mercuryCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let venusCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let marsCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let jupiterCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let saturnCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let uranusCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let neptuneCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let plutoCapsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let capsuleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7 // Adjust for desired curvature
        view.backgroundColor = .systemBlue // Choose your color
        return view
    }()
    
    private let capsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white // Choose your text color
        
        // Set the font to a bold and italic system font if available
        if let font = UIFont(name: "Helvetica-BoldOblique", size: 10) {
            label.font = font
        } else {
            // Alternatively, set to a default font
            label.font = UIFont.systemFont(ofSize: 9)
        }
        
        return label
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
    let sunButton = createCapsuleButton()
    let moonButton = createCapsuleButton()
    let mercuryButton = createCapsuleButton()
    let venusButton = createCapsuleButton()
    let marsButton = createCapsuleButton()
    let jupiterButton = createCapsuleButton()
    let saturnButton = createCapsuleButton()
    let uranusButton = createCapsuleButton()
    let neptuneButton = createCapsuleButton()
    let plutoButton = createCapsuleButton()
    
    private static func createCapsuleButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 7
        // Additional styling can be added here
        return button
    }
    private func setupButton(_ button: UIButton, title: String, houseCusp: Cusp, containerView: UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        button.setTitle("\(houseCusp.houseString)", for: .normal)
        button.isUserInteractionEnabled = true  // Enable user interaction for the button
        button.titleLabel?.font = UIFont(name: "Helvetica-BoldOblique", size: 10)
        button.addTarget(self, action: #selector(showKeywordSelectionVC(_:)), for: .touchUpInside)
        containerView.addSubview(button)
    }
    
    private func setupPlanetButtons() {
        let capsuleWidth: CGFloat = 60
        let capsuleHeight: CGFloat = 15
        let capsuleX: CGFloat = 60
        let capsuleY: CGFloat = 35
        
        // Sun
        setupButton(sunButton, title: "Sun", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.sun), containerView: sunScrollView, x: capsuleX, y: capsuleY, width: capsuleWidth, height: capsuleHeight)
        
        // Moon
        setupButton(moonButton, title: "Moon", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.moon), containerView: moonScrollView, x: capsuleX, y: capsuleY ,width: capsuleWidth, height: capsuleHeight)
        
        // Mercury
        setupButton(mercuryButton, title: "Mercury", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.mercury), containerView: mercuryScrollView, x: capsuleX, y: capsuleY, width: capsuleWidth, height: capsuleHeight)
        
        // Venus
        setupButton(venusButton, title: "Venus", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.venus), containerView: venusScrollView, x: capsuleX, y: capsuleY , width: capsuleWidth, height: capsuleHeight)
        
        // Mars
        setupButton(marsButton, title: "Mars", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.mars), containerView: marsScrollView, x: capsuleX, y: capsuleY , width: capsuleWidth, height: capsuleHeight)
        
        // Jupiter
        setupButton(jupiterButton, title: "Jupiter", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.jupiter), containerView: jupiterScrollView, x: capsuleX, y: capsuleY, width: capsuleWidth, height: capsuleHeight)
        
        // Saturn
        setupButton(saturnButton, title: "Saturn", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.saturn), containerView: saturnScrollView, x: capsuleX, y: capsuleY , width: capsuleWidth, height: capsuleHeight)
        // Uranus
        setupButton(uranusButton, title: "Uranus", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.uranus), containerView: uranusScrollView, x: capsuleX, y: capsuleY , width: capsuleWidth, height: capsuleHeight)
        // Neptune
        setupButton(neptuneButton, title: "Neptune", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.neptune), containerView: neptuneScrollView, x: capsuleX, y: capsuleY, width: capsuleWidth, height: capsuleHeight)
        // Pluto
        setupButton(plutoButton, title: "Pluto", houseCusp: chartCake!.natal.houseCusps.house(of: chartCake!.natal.pluto), containerView: plutoScrollView, x: capsuleX, y: capsuleY , width: capsuleWidth, height: capsuleHeight)
    }
    
    
    
    
    
    
    @objc func showKeywordSelectionVC(_ sender: UIButton) {
        print("Button tapped!")
        guard let title = sender.title(for: .normal), let house = title.components(separatedBy: " - ").last else { return }
        
        let keywordsVC = KeywordSelectionViewController()
        keywordsVC.keywords = houseKeywords[house] ?? []
        keywordsVC.delegate = self // Make sure you've set the delegate
        present(keywordsVC, animated: true)
    }
    
    
    var SelectedIndex = -1
    var isCollapsed = false
    
    
    func keywordsSelected(_ keywords: [String]) {
        // Handle the selected keywords here
        // For example, you might update a label or process the keywords further
        print("Selected Keywords: \(keywords)")
    }
    
    var currentPlanet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load data here
        currentPlanet = planet(for: sunTableView)
        
        let planetsTableViews = [sunTableView, moonTableView, mercuryTableView, venusTableView, marsTableView, jupiterTableView, saturnTableView, uranusTableView, neptuneTableView, plutoTableView]
        let planetsScrollView = [sunScrollView, moonScrollView, mercuryScrollView, venusScrollView, marsScrollView, jupiterScrollView, saturnScrollView, uranusScrollView, neptuneScrollView, plutoScrollView]
        
        // Iterate over each pair of table view and scroll view
        for index in 0..<planetsTableViews.count {
            let tableView = planetsTableViews[index]
            let scrollView = planetsScrollView[index]
            
            // Calculate the total row count for the current table view
            let totalRowCount = totalRowCountForPlanetTableView(planet: planet(for: tableView)!)
            
            // Only add the table view to the scroll view if it has progressed aspects
            if totalRowCount > 0 {
                scrollView.addSubview(tableView)
            }
        }
        
        
        sunTableView.rowHeight = UITableView.automaticDimension
        sunTableView.estimatedRowHeight = 120
        
        moonTableView.rowHeight = UITableView.automaticDimension
        moonTableView.estimatedRowHeight = 120
        
        mercuryTableView.rowHeight = UITableView.automaticDimension
        mercuryTableView.estimatedRowHeight = 120
        
        venusTableView.rowHeight = UITableView.automaticDimension
        venusTableView.estimatedRowHeight = 120
        
        marsTableView.rowHeight = UITableView.automaticDimension
        marsTableView.estimatedRowHeight = 120
        
        jupiterTableView.rowHeight = UITableView.automaticDimension
        jupiterTableView.estimatedRowHeight = 120
        
        saturnTableView.rowHeight = UITableView.automaticDimension
        saturnTableView.estimatedRowHeight = 120
        
        uranusTableView.rowHeight = UITableView.automaticDimension
        uranusTableView.estimatedRowHeight = 120
        
        neptuneTableView.rowHeight = UITableView.automaticDimension
        neptuneTableView.estimatedRowHeight = 120
        
        plutoTableView.rowHeight = UITableView.automaticDimension
        plutoTableView.estimatedRowHeight = 120
        
        
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
        setupPlanetButtons()
        
        
        
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
        
        
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 20)
        scrollView.backgroundColor = .clear
        view.addSubview(scrollView)
        
        topTransitImage.image = UIImage(named: "clouds")
        topTransitImage.image?.withTintColor(UIColor.yellow)
        
        topTransitImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)
        view.addSubview(topTransitImage)
        
        // adding date label
        
        let formatted = selectedDate?.formatted(date: .complete, time: .omitted)
        let todaysDate = UILabel(frame: CGRect(x: 100, y: 170, width: 300, height: 20))
        todaysDate.text = formatted
        todaysDate.font = .systemFont(ofSize: 13)
        todaysDate.textColor = .white
        todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)
        scrollView.addSubview(todaysDate)
        
        let photoButton = UIButton(frame: CGRect(x: 75, y: 170, width: 20, height: 20))
        photoButton.setImage(UIImage(systemName: "photo.fill"), for: .normal)
        
        photoButton.tintColor = .white // Or whichever color you prefer for the icon
        photoButton.addTarget(self, action: #selector(memoriesButtonTapped), for: .touchUpInside)
        scrollView.addSubview(photoButton)
        
        
        sunScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
        scrollView.addSubview(sunScrollView)
        //        sunScrollView.contentSize = CGSize(width: 300, height: 200)
        
        sunTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        moonTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        
        mercuryTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        
        venusTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        marsTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        jupiterTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        saturnTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        uranusTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        neptuneTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        plutoTableView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        
        view.frame = CGRect(x: 0, y: 0, width: 400, height: 6000)
        
        
        // Then set the contentSize.height for each tableView
        // Assuming you have declared and implemented the totalHeightForTableView(tableView:) function correctly
        sunTableView.contentSize.height = totalHeightForTableView(tableView: sunTableView)
        moonTableView.contentSize.height = totalHeightForTableView(tableView: moonTableView)
        mercuryTableView.contentSize.height = totalHeightForTableView(tableView: mercuryTableView)
        venusTableView.contentSize.height = totalHeightForTableView(tableView: venusTableView)
        marsTableView.contentSize.height = totalHeightForTableView(tableView: marsTableView)
        jupiterTableView.contentSize.height = totalHeightForTableView(tableView: jupiterTableView)
        saturnTableView.contentSize.height = totalHeightForTableView(tableView: saturnTableView)
        uranusTableView.contentSize.height = totalHeightForTableView(tableView: uranusTableView)
        neptuneTableView.contentSize.height = totalHeightForTableView(tableView: neptuneTableView)
        plutoTableView.contentSize.height = totalHeightForTableView(tableView: plutoTableView)
        
        // Similarly, implement methods for other table views (Moon, Mercury, Venus, etc.)
        // Disable scrolling for each table view
        sunTableView.isScrollEnabled = false
        moonTableView.isScrollEnabled = false
        mercuryTableView.isScrollEnabled = false
        venusTableView.isScrollEnabled = false
        marsTableView.isScrollEnabled = false
        jupiterTableView.isScrollEnabled = false
        saturnTableView.isScrollEnabled = false
        uranusTableView.isScrollEnabled = false
        neptuneTableView.isScrollEnabled = false
        plutoTableView.isScrollEnabled = false
        
        // Adjust the frame for each table view
        sunTableView.frame.size.height = sunTableView.contentSize.height
        moonTableView.frame.size.height = moonTableView.contentSize.height
        mercuryTableView.frame.size.height = mercuryTableView.contentSize.height
        venusTableView.frame.size.height = venusTableView.contentSize.height
        marsTableView.frame.size.height = marsTableView.contentSize.height
        jupiterTableView.frame.size.height = jupiterTableView.contentSize.height
        saturnTableView.frame.size.height = saturnTableView.contentSize.height
        uranusTableView.frame.size.height = uranusTableView.contentSize.height
        neptuneTableView.frame.size.height = neptuneTableView.contentSize.height
        plutoTableView.frame.size.height = plutoTableView.contentSize.height
        
        
        sunTableView.contentSize.height = totalHeightForTableView(tableView: sunTableView)
        sunTableView.isScrollEnabled = false
        sunTableView.frame.size.height = sunTableView.contentSize.height
        
        moonTableView.contentSize.height = totalHeightForTableView(tableView: moonTableView)
        moonTableView.isScrollEnabled = false
        moonTableView.frame.size.height = moonTableView.contentSize.height
        
        mercuryTableView.contentSize.height = totalHeightForTableView(tableView: mercuryTableView)
        mercuryTableView.isScrollEnabled = false
        mercuryTableView.frame.size.height = mercuryTableView.contentSize.height
        
        
        venusTableView.contentSize.height = totalHeightForTableView(tableView: venusTableView)
        venusTableView.isScrollEnabled = false
        venusTableView.frame.size.height = venusTableView.contentSize.height
        
        marsTableView.contentSize.height = totalHeightForTableView(tableView: marsTableView)
        marsTableView.isScrollEnabled = false
        marsTableView.frame.size.height = marsTableView.contentSize.height
        
        print("Setting jupiterTableView contentSize.height to: \(totalHeightForTableView(tableView: jupiterTableView))")
        jupiterTableView.contentSize.height = totalHeightForTableView(tableView: jupiterTableView)
        jupiterTableView.isScrollEnabled = false
        jupiterTableView.frame.size.height = jupiterTableView.contentSize.height
        
        print("Setting saturnTableView contentSize.height to: \(totalHeightForTableView(tableView: saturnTableView))")
        saturnTableView.contentSize.height = totalHeightForTableView(tableView: saturnTableView)
        saturnTableView.isScrollEnabled = false
        saturnTableView.frame.size.height = saturnTableView.contentSize.height
        
        print("Setting uranusTableView contentSize.height to: \(totalHeightForTableView(tableView: uranusTableView))")
        uranusTableView.contentSize.height = totalHeightForTableView(tableView: uranusTableView)
        uranusTableView.isScrollEnabled = false
        uranusTableView.frame.size.height = uranusTableView.contentSize.height
        
        print("Setting neptuneTableView contentSize.height to: \(totalHeightForTableView(tableView: neptuneTableView))")
        neptuneTableView.contentSize.height = totalHeightForTableView(tableView: neptuneTableView)
        neptuneTableView.isScrollEnabled = false
        neptuneTableView.frame.size.height = neptuneTableView.contentSize.height
        
        print("Setting plutoTableView contentSize.height to: \(totalHeightForTableView(tableView: plutoTableView))")
        plutoTableView.contentSize.height = totalHeightForTableView(tableView: plutoTableView)
        plutoTableView.isScrollEnabled = false
        plutoTableView.frame.size.height = plutoTableView.contentSize.height
        
        // After setting all the table view heights and disabling scroll
        print("All table views' contentSize.height set and scrolling disabled.")
        
        // Calculate the total height for the scroll view content
        let totalScrollViewContentHeight = sunTableView.frame.maxY + moonTableView.frame.height + mercuryTableView.frame.height + venusTableView.frame.height + marsTableView.frame.height + jupiterTableView.frame.height + saturnTableView.frame.height + uranusTableView.frame.height + neptuneTableView.frame.height + plutoTableView.frame.height + 50
        
        print("Total ScrollView Content Height: \(totalScrollViewContentHeight)")
        scrollView.contentSize = CGSize(width: view.frame.width, height: totalScrollViewContentHeight)
        
        
        
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
        
        sunSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        sunScrollView.addSubview(sunSignGlyph)
        sunSignGlyph.backgroundColor = .clear
        
        
        moonSignGlyph.image = UIImage(named: "moon")
        moonSignGlyph.image?.withTintColor(UIColor.yellow)
        
        moonSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        moonScrollView.addSubview(moonSignGlyph)
        moonSignGlyph.backgroundColor = .clear
        
        
        mercurySignGlyph.image = UIImage(named: "mercury")
        mercurySignGlyph.image?.withTintColor(UIColor.yellow)
        
        mercurySignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        mercuryScrollView.addSubview(mercurySignGlyph)
        mercurySignGlyph.backgroundColor = .clear
        
        
        venusSignGlyph.image = UIImage(named: "venus")
        venusSignGlyph.image?.withTintColor(UIColor.yellow)
        
        venusSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        venusScrollView.addSubview(venusSignGlyph)
        venusSignGlyph.backgroundColor = .clear
        
        
        marsSignGlyph.image = UIImage(named: "mars")
        marsSignGlyph.image?.withTintColor(UIColor.yellow)
        
        marsSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        marsScrollView.addSubview(marsSignGlyph)
        marsSignGlyph.backgroundColor = .clear
        
        
        jupiterSignGlyph.image = UIImage(named: "jupiter")
        jupiterSignGlyph.image?.withTintColor(UIColor.yellow)
        
        jupiterSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        jupiterScrollView.addSubview(jupiterSignGlyph)
        jupiterSignGlyph.backgroundColor = .clear
        
        
        saturnSignGlyph.image = UIImage(named: "saturn")
        saturnSignGlyph.image?.withTintColor(UIColor.yellow)
        
        saturnSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        saturnScrollView.addSubview(saturnSignGlyph)
        saturnSignGlyph.backgroundColor = .clear
        
        
        uranusSignGlyph.image = UIImage(named: "uranus")
        uranusSignGlyph.image?.withTintColor(UIColor.yellow)
        
        uranusSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        uranusScrollView.addSubview(uranusSignGlyph)
        uranusSignGlyph.backgroundColor = .clear
        
        
        neptuneSignGlyph.image = UIImage(named: "neptune")
        neptuneSignGlyph.image?.withTintColor(UIColor.yellow)
        
        neptuneSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        neptuneScrollView.addSubview(neptuneSignGlyph)
        neptuneSignGlyph.backgroundColor = .clear
        
        
        plutoSignGlyph.image = UIImage(named: "pluto")
        plutoSignGlyph.image?.withTintColor(UIColor.yellow)
        
        plutoSignGlyph.frame = CGRect(x: 10, y: 10, width: 34, height: 34)
        
        plutoScrollView.addSubview(plutoSignGlyph)
        plutoSignGlyph.backgroundColor = .clear
        
        
        
        
        let spacing: CGFloat = 15 // space between scrollViews
        var yOffset: CGFloat = 200 // initial y-offset for the first scrollView
        
        // Configure the sunTableView and its scrollView
        sunTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: sunTableView.contentSize.height)
        sunScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: sunTableView.frame.height + 40)
        yOffset = sunScrollView.frame.maxY + spacing
        sunScrollView.addSubview(sunTableView)
        
        // Configure the moonTableView and its scrollView
        moonTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: moonTableView.contentSize.height)
        print("moonTableView2: \(moonTableView.contentSize.height)")
        moonScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: moonTableView.frame.height + 40)
        print("moonScrollView: \(moonScrollView.frame.height)")
        yOffset = moonScrollView.frame.maxY + spacing
        moonScrollView.addSubview(moonTableView)
        
        // Configure the mercuryTableView and its scrollView
        mercuryTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: mercuryTableView.contentSize.height)
        mercuryScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: mercuryTableView.frame.height + 40)
        yOffset = mercuryScrollView.frame.maxY + spacing
        mercuryScrollView.addSubview(mercuryTableView)
        
        // Configure the venusTableView and its scrollView
        venusTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: venusTableView.contentSize.height)
        venusScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: venusTableView.frame.height + 40)
        yOffset = venusScrollView.frame.maxY + spacing
        venusScrollView.addSubview(venusTableView)
        
        // Configure the marsTableView and its scrollView
        marsTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: marsTableView.contentSize.height)
        marsScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: marsTableView.frame.height + 40)
        yOffset = marsScrollView.frame.maxY + spacing
        marsScrollView.addSubview(marsTableView)
        
        // Configure the jupiterTableView and its scrollView
        jupiterTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: jupiterTableView.contentSize.height)
        jupiterScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: jupiterTableView.frame.height + 40)
        yOffset = jupiterScrollView.frame.maxY + spacing
        jupiterScrollView.addSubview(jupiterTableView)
        
        // Configure the saturnTableView and its scrollView
        saturnTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: saturnTableView.contentSize.height)
        saturnScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: saturnTableView.frame.height + 40)
        yOffset = saturnScrollView.frame.maxY + spacing
        saturnScrollView.addSubview(saturnTableView)
        
        // Configure the uranusTableView and its scrollView
        uranusTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: uranusTableView.contentSize.height)
        uranusScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: uranusTableView.frame.height + 40)
        yOffset = uranusScrollView.frame.maxY + spacing
        uranusScrollView.addSubview(uranusTableView)
        
        // Configure the neptuneTableView and its scrollView
        neptuneTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: neptuneTableView.contentSize.height)
        neptuneScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: neptuneTableView.frame.height + 40)
        yOffset = neptuneScrollView.frame.maxY + spacing
        neptuneScrollView.addSubview(neptuneTableView)
        
        // Repeat the above steps for the remaining table views...
        
        // For the last tableView, you don't need to update yOffset after setting the frame
        plutoTableView.frame = CGRect(x: 10, y: 35, width: view.frame.size.width - 20, height: plutoTableView.contentSize.height)
        plutoScrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: plutoTableView.frame.height + 40)
        plutoScrollView.addSubview(plutoTableView)
        
        // Finally, set the content size of your scrollView to match the total content
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: yOffset)
        
        
        let capsuleWidth: CGFloat = 60
        let capsuleHeight: CGFloat = 15
        let capsuleX: CGFloat = 60 // For example, 10 points from the right edge
        let capsuleY: CGFloat = 35 // Adjust the Y-coordinate as needed
        
        capsuleView.frame = CGRect(x: capsuleX, y: capsuleY, width: capsuleWidth, height: capsuleHeight)
        capsuleLabel.frame = CGRect(x: capsuleX, y: capsuleY, width: capsuleWidth, height: capsuleHeight)
        let sunText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        sunText.text = "Vitality and Authority \("") \("")"
        sunText.font = .systemFont(ofSize: 17)
        sunText.textColor = .white
        
        sunScrollView.addSubview(sunText)
        
        
        
        
        
        let moonText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        moonText.text = "Shifting Moods and Everyday Affairs \("") \("")"
        moonText.font = .systemFont(ofSize: 17)
        moonText.textColor = .white
        
        moonScrollView.addSubview(moonText)
        
        let mercuryText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        mercuryText.text = "Mental Interests, Learning, Teaching \("") \("")"
        mercuryText.font = .systemFont(ofSize: 17)
        mercuryText.textColor = .white
        
        mercuryScrollView.addSubview(mercuryText)
        
        let venusText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        venusText.text = "Affections and Social Relations \("") \("")"
        venusText.font = .systemFont(ofSize: 17)
        venusText.textColor = .white
        
        venusScrollView.addSubview(venusText)
        
        let marsText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        marsText.text = "Strife, Increased Expenditure of Energy \("") \("")"
        
        marsText.font = .systemFont(ofSize: 17)
        marsText.textColor = .white
        
        marsScrollView.addSubview(marsText)
        
        let jupiterText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        jupiterText.text = "Abundance and Optimism \("") \("")"
        jupiterText.font = .systemFont(ofSize: 17)
        jupiterText.textColor = .white
        
        jupiterScrollView.addSubview(jupiterText)
        
        let saturnText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        saturnText.text = "Work, and Economy or Loss \("") \("")"
        saturnText.font = .systemFont(ofSize: 17)
        saturnText.textColor = .white
        
        saturnScrollView.addSubview(saturnText)
        
        let uranusText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        uranusText.text = "Sudden Events and Radical Changes \("") \("")"
        uranusText.font = .systemFont(ofSize: 17)
        uranusText.textColor = .white
        
        uranusScrollView.addSubview(uranusText)
        
        let neptuneText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        neptuneText.text = "The Imagination and Schemes \("") \("")"
        neptuneText.font = .systemFont(ofSize: 17)
        neptuneText.textColor = .white
        
        neptuneScrollView.addSubview(neptuneText)
        
        let plutoText = UILabel(frame: CGRect(x: 55, y: 10, width: 300, height: 20))
        plutoText.text = "Hidden Forces, Coercion or Cooperation \("") \("")"
        plutoText.font = .systemFont(ofSize: 17)
        plutoText.textColor = .white
        
        plutoScrollView.addSubview(plutoText)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More Aspects", style: .plain, target: self, action: #selector(moreAspectsButtonTapped))
        view.backgroundColor = .black
        
        
    }
    
    @objc func navigateToTimeChangeVC() {
        let timeChangeVC = TransitAspectsTimeChangeViewController()
        self.navigationController?.pushViewController(timeChangeVC, animated: true)
    }
    
    @objc func moreAspectsButtonTapped() {
        let flipSynastryVC = TransitAspectedPlanetsViewController()
        flipSynastryVC.chartCake = self.chartCake
        flipSynastryVC.selectedDate = self.selectedDate
        self.navigationController?.pushViewController(flipSynastryVC, animated: true)
    }
    
    
    
    @objc func memoriesButtonTapped() {
        guard var selectedDate = selectedDate else {
            // Handle case where selectedDate is nil
            return
        }
        
        ImagePickerViewController.fetchPhotos(from: selectedDate) { photoAssets in
            if photoAssets.isEmpty {
                // Show a message to the user that there are no photos from the selected date
                let alert = UIAlertController(title: "No Photos", message: "There are no photos from the selected date.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                // If there are photos, initialize and present the ImagePickerViewController
                let imagePickerVC = ImagePickerViewController()
                imagePickerVC.selectedDate = selectedDate
                imagePickerVC.photoAssets = photoAssets
                self.present(imagePickerVC, animated: true, completion: nil)
            }
        }
    }
    
    func totalRowCountForPlanetTableView(planet: Planet) -> Int {
        // Make sure the cache is updated before attempting to access it
        calculateAndCacheAspectCounts(for: planet)
        guard let counts = planetAspectCountCache[planet] else {
            return 0
        }
        // Now sum up the counts using the cached values
        
        print("counts.major \(counts.majors)")
        print("counts.solarArcs \(counts.solarArcs)")
        print("counts.minors \(counts.minors)")
        print("counts.transits \(counts.transits)")
        return counts.majors + counts.solarArcs + counts.minors + counts.transits
    }
    
    let headerHeight: CGFloat = 50 // Replace 50 with your actual header height
    
    func totalHeightForTableView(tableView: UITableView) -> CGFloat {
        guard let planet = planet(for: tableView) else {
            return 0
        }
        
        // Get the total row count using the updated totalRowCountForPlanetTableView method
        let totalRowCount = totalRowCountForPlanetTableView(planet: planet)
        print("tital row count: \(totalRowCount)")
        let totalRowsHeight = CGFloat(totalRowCount) * 130 // Assuming 130 is the row height
        
        // Calculate the total section count using the numberOfSections method
        let sectionCount = self.numberOfSections(in: tableView)
        
        // Assuming each section has a header, calculate the total headers height
        let totalHeadersHeight = CGFloat(sectionCount) * headerHeight
        
        // The total height of the table is the sum of all rows' height and all headers' height
        let totalHeight = totalRowsHeight + totalHeadersHeight
        
        return totalHeight
    }
    
    func calculateAndCacheAspectCounts(for planet: Planet) {
        // Check if already cached to prevent recalculation
        if let _ = planetAspectCountCache[planet] {
            // If already cached, no need to recalculate
            return
        }
        
        // Fetch and map the aspects to their string representations
        let majorsAspects = chartCake!.progressedSimpleAspectsFiltered(by: planet.celestialObject).map { $0.basicAspectString }
        let solarArcsAspects = chartCake!.solarArcSimpleAspectsFiltered(by: planet.celestialObject).map { $0.basicAspectString }
        let minorsAspects = chartCake!.minorProgressedSimpleAspectsFiltered(by: planet.celestialObject).map { $0.basicAspectString }
        let transitsAspects = chartCake!.transitSimpleAspectsFiltered(by: planet.celestialObject).map { $0.basicAspectString }
        
        // Store the counts and the aspect strings in the cache
        planetAspectCountCache[planet] = PlanetAspectCounts(
            majors: majorsAspects.count,
            solarArcs: solarArcsAspects.count,
            minors: minorsAspects.count,
            transits: transitsAspects.count,
            majorsAspects: majorsAspects,
            solarArcsAspects: solarArcsAspects,
            minorsAspects: minorsAspects,
            transitsAspects: transitsAspects
        )
        
        // After updating the cache, reload the specific table view for this planet on the main thread
        // Reload the specific table view for this planet
          DispatchQueue.main.async { [weak self] in
              switch planet {
              case .sun:
                  self?.sunTableView.reloadData()
              case .moon:
                  self?.moonTableView.reloadData()
              case .mercury:
                  self?.mercuryTableView.reloadData()
              case .venus:
                  self?.venusTableView.reloadData()
              case .mars:
                  self?.marsTableView.reloadData()
              case .jupiter:
                  self?.jupiterTableView.reloadData()
              case .saturn:
                  self?.saturnTableView.reloadData()
              case .uranus:
                  self?.uranusTableView.reloadData()
              case .neptune:
                  self?.neptuneTableView.reloadData()
              case .pluto:
                  self?.plutoTableView.reloadData()
              case .southNode: break
              }
          }

          // Debug information
          print("Aspect counts for \(planet): Majors: \(majorsAspects.count), Solar Arcs: \(solarArcsAspects.count), Minors: \(minorsAspects.count), Transits: \(transitsAspects.count)")
      }
}

extension SimpleAllProgressionsAspectedPlanetsViewController  : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
          guard let planet = planet(for: tableView) else {
              return 0
          }
          calculateAndCacheAspectCounts(for: planet)
          // Filter out sections with zero counts using getAspectCount directly
          return SectionType.allCases.filter { sectionType in
              getAspectCount(for: planet, sectionType: sectionType) > 0
          }.count
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let planet = planet(for: tableView) else {
            return 0
        }
        let sectionTypesWithCounts = SectionType.allCases.filter {
            getAspectCount(for: planet, sectionType: $0) > 0
        }
        if section < sectionTypesWithCounts.count {
            let sectionType = sectionTypesWithCounts[section]
            let count = getAspectCount(for: planet, sectionType: sectionType)
            print("Number of rows in section \(sectionType.title) for \(planet): \(count)")
            return count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let planet = planet(for: tableView) else {
            return 0
        }

        // Get the section type for the current section
        let sectionTypesWithCounts = SectionType.allCases.filter {
            getAspectCount(for: planet, sectionType: $0) > 0
        }

        // Check if the index path's section is valid
        if indexPath.section < sectionTypesWithCounts.count {
            let sectionType = sectionTypesWithCounts[indexPath.section]

            // Check if the row index is within the count of aspects for this section
            return getAspectCount(for: planet, sectionType: sectionType) > indexPath.row ? 90 : 0
        } else {
            // If the section is not valid, return a minimal height or zero
            return 0
        }
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Get the correct sectionType based on the filtered list
        let filteredSections = SectionType.allCases.filter { self.numberOfRowsForPlanet(planet(for: tableView)!, inSection: $0) > 0 }
        let sectionType = filteredSections[section]
        
        return sectionType.title // Assuming each case of SectionType has a 'title' property
    }


 func planet(for tableView: UITableView) -> Planet? {
        if tableView == sunTableView {
            return .sun
        } else if tableView == moonTableView {
            return .moon
        } else if tableView == mercuryTableView {
            return .mercury
        } else if tableView == venusTableView {
            return .venus
        } else if tableView == marsTableView {
            return .mars
        } else if tableView == jupiterTableView {
            return .jupiter
        } else if tableView == saturnTableView {
            return .saturn
        } else if tableView == uranusTableView {
            return .uranus
        } else if tableView == neptuneTableView {
            return .neptune
        } else if tableView == plutoTableView {
            return .pluto
        } else {
            // Return nil or a default value if the table view doesn't match any planet
            return nil
        }
    }

    private func configureCell(for tableView: UITableView, planet: Planet, inSection sectionType: SectionType, at indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewAspectsCustomTableViewCell.identifier, for: indexPath) as? NewAspectsCustomTableViewCell else {
            fatalError("Error: Unable to dequeue NewAspectsCustomTableViewCell.")
        }

        // Get cached data, calculate if not available
        if planetAspectCountCache[planet] == nil {
            calculateAndCacheAspectCounts(for: planet)
            print("Cached data after calculation1: \(planetAspectCountCache)")

        }

        // Now that we're sure we have cached data, let's access it
        guard let cachedData = planetAspectCountCache[planet] else {
            fatalError("Error: No cached data available for planet \(planet).")
        }

        // Debug: Print the cached aspect data for verification
        print("Configuring cell for \(planet): \(cachedData)")

        // Determine the aspect string to configure the cell with
        let aspectString: String? = {
            

            switch sectionType {
            case .majors:
                return indexPath.row < cachedData.majorsAspects.count ? cachedData.majorsAspects[indexPath.row] : nil
            case .solarArcs:
                return indexPath.row < cachedData.solarArcsAspects.count ? cachedData.solarArcsAspects[indexPath.row] : nil
            case .minors:
                return indexPath.row < cachedData.minorsAspects.count ? cachedData.minorsAspects[indexPath.row] : nil
            case .transits:
                print("Attempting to configure cell for Transits. IndexPath.row: \(indexPath.row), Transits count: \(cachedData.transitsAspects.count)")
                return indexPath.row < cachedData.transitsAspects.count ? cachedData.transitsAspects[indexPath.row] : nil
            }
            
        }()

        // Configure the cell if the aspect string exists, otherwise clear the cell
        if let aspectDetail = aspectString {
            print("Retrieved aspect string for configuration: \(String(describing: aspectString))")

            print("Configuring cell for Planet: \(planet), Section: \(sectionType.title), Row: \(indexPath.row) with aspect detail: \(aspectDetail)")
            cell.configure(aspectingPlanet: "", secondPlanetImageImageName: "", firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: aspectDetail, firstPlanetTextText: "", firstAspectHeaderTextText: "", secondAspectHeaderTextText: "")
        } else {
            print("No aspect detail for Planet: \(planet), Section: \(sectionType.title), Row: \(indexPath.row). Clearing cell configuration.")
            cell.clearConfiguration()
        }

        return cell
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt called for section \(indexPath.section), row \(indexPath.row)")
      
        guard let planet = planet(for: tableView), let sectionType = SectionType(rawValue: indexPath.section) else {
               print("Error: Could not find planet or sectionType for table view at indexPath: \(indexPath)")
               return UITableViewCell()
           }
        

        switch tableView {
        case sunTableView:
            return configureCell(for: tableView, planet: .sun, inSection: sectionType, at: indexPath)
        case moonTableView:
            return configureCell(for: tableView, planet: .moon, inSection: sectionType, at: indexPath)
        case mercuryTableView:
            return configureCell(for: tableView, planet: .mercury, inSection: sectionType, at: indexPath)
        case venusTableView:
            return configureCell(for: tableView, planet: .venus, inSection: sectionType, at: indexPath)
        case marsTableView:
            return configureCell(for: tableView, planet: .mars, inSection: sectionType, at: indexPath)
        case jupiterTableView:
            return configureCell(for: tableView, planet: .jupiter, inSection: sectionType, at: indexPath)
        case saturnTableView:
            return configureCell(for: tableView, planet: .saturn, inSection: sectionType, at: indexPath)
        case uranusTableView:
            return configureCell(for: tableView, planet: .uranus, inSection: sectionType, at: indexPath)
        case neptuneTableView:
            return configureCell(for: tableView, planet: .neptune, inSection: sectionType, at: indexPath)
        case plutoTableView:
            return configureCell(for: tableView, planet: .pluto, inSection: sectionType, at: indexPath)
        default:
            return UITableViewCell()
        }
        

        let cell = configureCell(for: tableView, planet: planet, inSection: sectionType, at: indexPath)

          return cell
      }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40)) // Adjust height as needed
        headerView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: -10, width: headerView.bounds.width - 30, height: headerView.bounds.height))
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.textColor = UIColor.white // Set your text color
        headerLabel.font = UIFont.boldSystemFont(ofSize: 14) // Set your font size

        headerView.addSubview(headerLabel)

        return headerView
    }

            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            }

    func getAspectCount(for planet: Planet, sectionType: SectionType) -> Int {
        // Ensure the counts are calculated and cached
        calculateAndCacheAspectCounts(for: planet)
        
        // Retrieve the counts from the cache
        let counts = planetAspectCountCache[planet]!
        switch sectionType {
        case .majors:
            return counts.majors
        case .solarArcs:
            return counts.solarArcs
        case .minors:
            return counts.minors
        case .transits:
            return counts.transits
        }
    }

    


    func numberOfRowsForPlanet(_ planet: Planet, inSection sectionType: SectionType) -> Int {
         let count = getAspectCount(for: planet, sectionType: sectionType)
         return count > 0 ? count : 0
     }

}
