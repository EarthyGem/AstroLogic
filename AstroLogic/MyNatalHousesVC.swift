//
//  TransposedHousesViewController.swift
//  MVP
//
//  Created by Errick Williams on 10/19/22.
//

import UIKit
import SwiftEphemeris


enum Section: Int, CaseIterable {
   case inHouse = 0, rulerOfCusp

   var title: String {
       switch self {
       case .inHouse: return "In House"
       case .rulerOfCusp: return "Ruler of Cusp"

       }
   }
}

class MyNatalHousesVC: UIViewController {

    var chartCake: ChartCake?
    var chart: Chart?
    //var chartCake: ChartCake?
    var name: String?
//
    
    var planetsInEachHouse: [Int: [CelestialObject]] = [:]
    var cuspRulersInEachHouse: [Int: [CelestialObject]] = [:]
    var sortedHousesByStrength: [(Int, Double)] = []
    
    var totalStrength: Double {
        return sortedHousesByStrength.map { $0.1 }.reduce(0, +)
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        return scrollView
    }()


    private let firstScrollView: UIView = {
        let firstScrollView = UIView()

        return firstScrollView
    }()

    private let secondScrollView: UIView = {
        let secondScrollView = UIView()

        return secondScrollView
    }()

    private let thirdScrollView: UIView = {
        let thirdScrollView = UIView()

        return thirdScrollView
    }()
    private let fourthScrollView: UIView = {
        let fourthScrollView = UIView()

        return fourthScrollView
    }()
    private let fifthScrollView: UIView = {
        let fifthScrollView = UIView()

        return fifthScrollView
    }()
    private let sixthScrollView: UIView = {
        let sixthScrollView = UIView()

        return sixthScrollView
    }()
    private let seventhScrollView: UIView = {
        let seventhScrollView = UIView()

        return seventhScrollView
    }()
    private let eighthScrollView: UIView = {
        let eighthScrollView = UIView()

        return eighthScrollView
    }()
    private let ninthScrollView: UIView = {
        let ninthScrollView = UIView()

        return ninthScrollView
    }()
    private let tenthScrollView: UIView = {
        let tenthScrollView = UIView()

        return tenthScrollView
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


    private let firstHouseSignGlyph: UIImageView = {
        let firstHouseSignGlyph = UIImageView()


        return firstHouseSignGlyph

    }()
    private let secondHouseSignGlyph: UIImageView = {
        let secondHouseSignGlyph = UIImageView()


        return secondHouseSignGlyph

    }()
    private let thirdHouseSignGlyph: UIImageView = {
        let thirdHouseSignGlyph = UIImageView()


        return thirdHouseSignGlyph

    }()
    private let fourthHouseSignGlyph: UIImageView = {
        let fourthHouseSignGlyph = UIImageView()


        return fourthHouseSignGlyph

    }()
    private let fifthHouseSignGlyph: UIImageView = {
        let fifthHouseSignGlyph = UIImageView()


        return fifthHouseSignGlyph

    }()
    private let sixthHouseSignGlyph: UIImageView = {
        let sixthHouseSignGlyph = UIImageView()


        return sixthHouseSignGlyph

    }()
    private let seventhHouseSignGlyph: UIImageView = {
        let seventhHouseSignGlyph = UIImageView()


        return seventhHouseSignGlyph

    }()
    private let eighthHouseSignGlyph: UIImageView = {
        let eighthHouseSignGlyph = UIImageView()


        return eighthHouseSignGlyph

    }()
    private let ninthHouseSignGlyph: UIImageView = {
        let ninthHouseSignGlyph = UIImageView()


        return ninthHouseSignGlyph

    }()
    private let tenthHouseSignGlyph: UIImageView = {
        let tenthHouseSignGlyph = UIImageView()


        return tenthHouseSignGlyph

    }()

    private let eleventhHouseSignGlyph: UIImageView = {
        let eleventhHouseSignGlyph = UIImageView()


        return eleventhHouseSignGlyph

    }()
    private let twelfthHouseSignGlyph: UIImageView = {
        let twelfthHouseSignGlyph = UIImageView()


        return twelfthHouseSignGlyph

    }()


    private let topTransitImage: UIImageView = {
        let topTransitImage = UIImageView()


        return topTransitImage

    }()

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
        
        if let tabBar = self.tabBarController?.tabBar {
            tabBar.isTranslucent = false
            tabBar.barTintColor = .black // Sets the background color to black
        }
        sortedHousesByStrength = chartCake!.sortedHouseStrengths()
        
        view.backgroundColor = .black
        
        guard let houseCusps = chartCake?.houseCusps, let bodies = chartCake?.natal.planets, !sortedHousesByStrength.isEmpty else {
            return
        }
   

  


        planetsInEachHouse = chartCake?.natalPlanetsInHouses(using: houseCusps, with: bodies) ?? [:]
     cuspRulersInEachHouse = chartCake?.natalCuspRulersInHouses(using: houseCusps) ?? [:]
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           // Set the navigation items specific to this view controller
    
       }

    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Aspects by Houses", style: .plain, target: self, action: #selector(moreAspectsButtonTapped))
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
      //  topTransitImage.image?.withTintColor(UIColor.yellow)

        topTransitImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)
        view.addSubview(topTransitImage)



      
       scrollView.addSubview(firstScrollView)
        //        firstScrollView.contentSize = CGSize(width: 300, height: 200)
        firstTableView.backgroundColor = .clear
        //        firstTableView.backgroundColor = .orange
        firstScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
        secondTableView.backgroundColor = .clear

        thirdTableView.backgroundColor = .clear

        fourthTableView.backgroundColor = .clear
        fifthTableView.backgroundColor = .clear
        sixthTableView.backgroundColor = .clear
        seventhTableView.backgroundColor = .clear
        eighthTableView.backgroundColor = .clear
        ninthTableView.backgroundColor = .clear
        tenthTableView.backgroundColor = .clear
    eleventhTableView.backgroundColor = .clear
        twelfthTableView.backgroundColor = .clear

        //      view.frame = CGRect(x: 0, y: 0, width: 400, height: 6000)
       firstTableView.isScrollEnabled = false
        secondTableView.isScrollEnabled = false
     thirdTableView.isScrollEnabled = false
       fourthTableView.isScrollEnabled = false
        fifthTableView.isScrollEnabled = false
        sixthTableView.isScrollEnabled = false
        seventhTableView.isScrollEnabled = false
        eighthTableView.isScrollEnabled = false
        ninthTableView.isScrollEnabled = false
        tenthTableView.isScrollEnabled = false
        seventhTableView.isScrollEnabled = false
        eleventhTableView.isScrollEnabled = false
        twelfthTableView.isScrollEnabled = false

        scrollView.contentSize = CGSize(width: view.frame.width, height: 4000)
        let tableViews = [firstTableView, secondTableView, thirdTableView, fourthTableView, fifthTableView, sixthTableView, seventhTableView, eighthTableView, ninthTableView, tenthTableView, eleventhTableView, twelfthTableView]

        // Ensure you have the necessary data before proceeding.
        guard let houseCusps = chartCake?.houseCusps, let bodies = chartCake?.natal.planets, !sortedHousesByStrength.isEmpty else {
            return
        }

        let headerHeight: CGFloat = 30 // Adjust this to your header height, if custom

        // Get planets in houses and rulers in houses using the functions.
        let planetsInHouses = chartCake?.natalPlanetsInHouses(using: houseCusps, with: bodies) ?? [:]
        let cuspRulersInHouses = chartCake?.natalCuspRulersInHouses(using: houseCusps) ?? [:]

        for (index, tableView) in tableViews.enumerated() {
            // Use the sorted house number instead of the index directly
            let houseStrengthPair = sortedHousesByStrength[index]
            let houseNumber = houseStrengthPair.0

            // Get the count of planets and rulers in the sorted house
            let planetsCount = planetsInHouses[houseNumber]?.count ?? 0
            let rulersCount = cuspRulersInHouses[houseNumber]?.count ?? 0

            // Each section has its own header, so we multiply the headerHeight by the number of sections (2)
            let totalHeaderHeight = headerHeight * 2

            // Calculate the total height required for all rows and headers in this table view
            let totalHeight = CGFloat(planetsCount + rulersCount) * 90 + totalHeaderHeight

            // Update the height of the table view
            tableView.contentSize.height = totalHeight
        }

        scrollView.addSubview(secondScrollView)
//        secondScrollView.contentSize = CGSize(width: 300, height: 200)
       secondScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(thirdScrollView)
//        thirdScrollView.contentSize = CGSize(width: 300, height: 200)
        thirdScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(fourthScrollView)
//        fourthScrollView.contentSize = CGSize(width: 300, height: 200)
        fourthScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(fifthScrollView)
//        fifthScrollView.contentSize = CGSize(width: 300, height: 200)
        fifthScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(sixthScrollView)
//        sixthScrollView.contentSize = CGSize(width: 300, height: 200)
        sixthScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(seventhScrollView)
//        seventhScrollView.contentSize = CGSize(width: 300, height: 200)
        seventhScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(eighthScrollView)
//        eighthScrollView.contentSize = CGSize(width: 300, height: 200)
        eighthScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(ninthScrollView)
//        ninthScrollView.contentSize = CGSize(width: 300, height: 200)
        ninthScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(tenthScrollView)
//        tenthScrollView.contentSize = CGSize(width: 300, height: 200)
        tenthScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(eleventhScrollView)
//        ninthScrollView.contentSize = CGSize(width: 300, height: 200)
        eleventhScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

        scrollView.addSubview(twelfthScrollView)
//        tenthScrollView.contentSize = CGSize(width: 300, height: 200)
        twelfthScrollView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)








//        firstScrollView.addSubview(tenthTableView)
        // Do any additional setup after loading the view.


//        firstScrollView.frame = CGRect(x: 10, y: 150, width: view.frame.size.width - 20, height: view.frame.size.height - 20)
//
        let mySignCusps = [chartCake?.houseCusps.first.sign.keyName, chartCake?.houseCusps.second.sign.keyName, chartCake?.houseCusps.third.sign.keyName, chartCake?.houseCusps.fourth.sign.keyName, chartCake?.houseCusps.fifth.sign.keyName, chartCake?.houseCusps.sixth.sign.keyName, chartCake?.houseCusps.seventh.sign.keyName, chartCake?.houseCusps.eighth.sign.keyName, chartCake?.houseCusps.ninth.sign.keyName, chartCake?.houseCusps.tenth.sign.keyName, chartCake?.houseCusps.eleventh.sign.keyName, chartCake?.houseCusps.twelfth.sign.keyName ]
       
        let scrollViews = [
            firstScrollView,
            secondScrollView,
            thirdScrollView,
            fourthScrollView,
            fifthScrollView,
            sixthScrollView,
            seventhScrollView,
            eighthScrollView,
            ninthScrollView,
            tenthScrollView,
            eleventhScrollView,
            twelfthScrollView
        ]

        let houseLabelsTexts = [
            "First House - Personality",
            "Second House - Resources",
            "Third House - Finding Your Voice",
            "Fourth House - Home and Family",
            "Fifth House - Fun",
            "Sixth House - Skill Development",
            "Seventh House - Partnerships",
            "Eighth House - The Occult",
            "Ninth House - Philosophy",
            "Tenth House - Role in the Community",
            "Eleventh House - Friends",
            "Twelfth House - Endings"
        ]

        // Initialize an array of optional UIImageViews
        var houseSignGlyphs = [UIImageView?](repeating: nil, count: 12)

        // Populate the array with UIImageView instances
        for i in 0..<houseSignGlyphs.count {
            let signGlyphImageView = UIImageView()
            signGlyphImageView.frame = CGRect(x: 10, y: 10, width: 18, height: 18) // Set the frame as needed
            signGlyphImageView.backgroundColor = .clear
            houseSignGlyphs[i] = signGlyphImageView
        }
        // Dynamic assignment based on sorted house strengths
        // Calculate the y position for the first scroll view
        var yOffset: CGFloat = 200
        let rowHeight: CGFloat = 90
        let sectionHeaderHeight: CGFloat = 40 // Adjust this based on your design
        let spacingBetweenTables: CGFloat = 20 // Gap between scroll views


        for (index, houseStrengthPair) in sortedHousesByStrength.enumerated() {
            let houseNumber = houseStrengthPair.0 - 1
            let scrollView = scrollViews[index]
            let tableView = tableViews[houseNumber]

            // Clear out old views to prevent overlap
            scrollView.subviews.forEach { $0.removeFromSuperview() }

            // Reload the table view data to get the latest number of rows
            tableView.reloadData()
            
            // Calculate the height of the table view based on the number of rows in both sections
            let totalRows = tableView.numberOfRows(inSection: 0) + tableView.numberOfRows(inSection: 1)
            let tableViewHeight = CGFloat(totalRows) * rowHeight + (CGFloat(tableView.numberOfSections) * sectionHeaderHeight)
            // Configure the table view frame
            tableView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: tableViewHeight)
            scrollView.addSubview(tableView)

            // Assign and configure sign glyph
            let signGlyph = houseSignGlyphs[index] ?? UIImageView()
            signGlyph.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
            signGlyph.backgroundColor = .clear
            if let imageName = mySignCusps[houseNumber] {
                signGlyph.image = UIImage(named: imageName)
            }
            scrollView.addSubview(signGlyph)

            // Assign and configure house label
            let houseText = UILabel(frame: CGRect(x: 35, y: 8, width: 300, height: 20))
            houseText.text = houseLabelsTexts[houseNumber]
            houseText.font = .systemFont(ofSize: 16)
            houseText.textColor = .white
            scrollView.addSubview(houseText)

            // Set the frame for the scrollView
            tableView.contentSize = CGSize(width: scrollView.frame.size.width, height: tableView.frame.maxY)
            scrollView.frame = CGRect(x: 0, y: yOffset, width: view.frame.size.width, height: tableView.contentSize.height)
            
            // Update yOffset for the next scrollView
            yOffset += tableView.contentSize.height + 15 // Gap between scroll views
            
            let houseStrengths = chartCake!.sortedHouseStrengths(chartCake?.natal.planets)
            let totalPower = houseStrengths.reduce(0) { $0 + $1.1 } // Sum up all the strengths

            for (index, scrollView) in scrollViews.enumerated() {
                let houseNumber = sortedHousesByStrength[index].0
                let housePower = sortedHousesByStrength[index].1
                
                // Calculate the percentage of power for this house
                let powerPercentage = (housePower / totalPower) * 100
                
                // Create the power label
                let powerLabel = UILabel()
                powerLabel.text = String(format: "%.1f%%", powerPercentage)
                powerLabel.font = .systemFont(ofSize: 14)
                powerLabel.textColor = .white
                powerLabel.textAlignment = .right
                
                // Calculate the frame for the power label
                // Adjust the x position based on where you want to place it within the scrollView
                // The y position should be aligned with the sign glyph and label, or adjusted to your layout needs
                let xPosition = scrollView.frame.width - 110 // 10 points padding from the right edge
                let yPosition = signGlyph.frame.origin.y // Align with the top of the sign glyph
                powerLabel.frame = CGRect(x: xPosition, y: yPosition, width: 100, height: 20)
                
                // Add the power label to the scrollView
                scrollView.addSubview(powerLabel)
            }
        }

        // You no longer need the getYPositionForScrollView function if you follow this approach

     

        // Function to calculate Y position of each scroll view
    
       

        firstScrollView.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: firstTableView.contentSize.height + 40)

        firstTableView.frame = CGRect(x: 10, y: 35, width: firstScrollView.frame.size.width , height: firstTableView.contentSize.height)

        firstScrollView.addSubview(firstTableView)


        secondScrollView.frame = CGRect(x: 0, y: firstScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: secondTableView.contentSize.height + 40)
        secondTableView.frame = CGRect(x: 10, y: 35, width: secondScrollView.frame.size.width , height: secondScrollView.frame.size.height - 60)

        secondScrollView.addSubview(secondTableView)




        thirdScrollView.frame = CGRect(x: 0, y: secondScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: thirdTableView.contentSize.height + 40)
        thirdScrollView.addSubview(thirdTableView)



        fourthScrollView.frame = CGRect(x: 0, y: thirdScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: fourthTableView.contentSize.height + 40)
        fourthScrollView.addSubview(fourthTableView)

        fifthScrollView.frame = CGRect(x: 0, y: fourthScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: fifthTableView.contentSize.height + 40)
        fifthScrollView.addSubview(fifthTableView)

        sixthScrollView.frame = CGRect(x: 0, y: fifthScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: sixthTableView.contentSize.height + 40)
        sixthScrollView.addSubview(sixthTableView)

        seventhScrollView.frame = CGRect(x: 0, y: sixthScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: seventhTableView.contentSize.height + 40)
        seventhScrollView.addSubview(seventhTableView)

        eighthScrollView.frame = CGRect(x: 0, y: seventhScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: eighthTableView.contentSize.height + 40)
        eighthScrollView.addSubview(eighthTableView)

        ninthScrollView.frame = CGRect(x: 0, y: eighthScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: ninthTableView.contentSize.height + 40)
        ninthScrollView.addSubview(ninthTableView)

        tenthScrollView.frame = CGRect(x: 0, y: ninthScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: tenthTableView.contentSize.height + 40)
        tenthScrollView.addSubview(tenthTableView)


        eleventhScrollView.frame = CGRect(x: 0, y: tenthScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: eleventhTableView.contentSize.height + 40)
        eleventhScrollView.addSubview(eleventhTableView)

        twelfthScrollView.frame = CGRect(x: 0, y: eleventhScrollView.frame.maxY + 15, width: scrollView.frame.size.width , height: twelfthTableView.contentSize.height + 40)
        twelfthScrollView.addSubview(twelfthTableView)
//

//


        thirdTableView.frame = CGRect(x: 10, y: 35, width: thirdScrollView.frame.size.width , height: thirdScrollView.frame.size.height - 60)

        fourthTableView.frame = CGRect(x: 10, y: 35, width: fourthScrollView.frame.size.width , height: fourthScrollView.frame.size.height - 60)

        fifthTableView.frame = CGRect(x: 10, y: 35, width: fifthScrollView.frame.size.width , height: fifthScrollView.frame.size.height - 60)

        sixthTableView.frame = CGRect(x: 10, y: 35, width: sixthScrollView.frame.size.width , height: sixthScrollView.frame.size.height - 60)

        seventhTableView.frame = CGRect(x: 10, y: 35, width: seventhScrollView.frame.size.width , height: seventhScrollView.frame.size.height - 60)

        eighthTableView.frame = CGRect(x: 10, y: 35, width: eighthScrollView.frame.size.width , height: eighthScrollView.frame.size.height - 20)
        ninthTableView.frame = CGRect(x: 10, y: 35, width: ninthScrollView.frame.size.width , height: ninthScrollView.frame.size.height - 60)
        tenthTableView.frame = CGRect(x: 10, y: 35, width: tenthScrollView.frame.size.width , height: tenthScrollView.frame.size.height - 60)


        eleventhTableView.frame = CGRect(x: 10, y: 35, width: eleventhScrollView.frame.size.width , height: eleventhScrollView.frame.size.height - 60)
        twelfthTableView.frame = CGRect(x: 10, y: 35, width: twelfthScrollView.frame.size.width , height: twelfthScrollView.frame.size.height - 60)


 

       
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

    @objc func moreAspectsButtonTapped() {
        let flipSynastryVC = NatalAspectsByHousesVC()
        flipSynastryVC.chartCake = self.chartCake
      //  flipSynastryVC.selectedDate = self.selectedDate
        self.navigationController?.pushViewController(flipSynastryVC, animated: true)
    }
}

extension MyNatalHousesVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Assuming you now have 2 sections, one for planets in the house and another for rulers of the cusp
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableViews = [firstTableView, secondTableView, thirdTableView, fourthTableView, fifthTableView, sixthTableView, seventhTableView, eighthTableView, ninthTableView, tenthTableView, eleventhTableView, twelfthTableView]
        
        if let index = tableViews.firstIndex(of: tableView), !sortedHousesByStrength.isEmpty {
            let houseStrengthPair = sortedHousesByStrength[index]
            let houseNumber = houseStrengthPair.0
            
            if section == 0 && (planetsInEachHouse[houseNumber]?.count ?? 0) > 0 {
                return "Planets in the House"
            } else if section == 1 && (cuspRulersInEachHouse[houseNumber]?.count ?? 0) > 0 {
                return "Rulers of the Cusp"
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 20)) // Adjust height as needed
        headerView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.00)
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: -10, width: headerView.bounds.width - 30, height: headerView.bounds.height))
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.textColor = UIColor.white // Set your text color
        headerLabel.font = UIFont.boldSystemFont(ofSize: 10) // Set your font size

        headerView.addSubview(headerLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let tableViews = [firstTableView, secondTableView, thirdTableView, fourthTableView, fifthTableView, sixthTableView, seventhTableView, eighthTableView, ninthTableView, tenthTableView, eleventhTableView, twelfthTableView]
        
        if let index = tableViews.firstIndex(of: tableView), !sortedHousesByStrength.isEmpty {
            let houseStrengthPair = sortedHousesByStrength[index]
            let houseNumber = houseStrengthPair.0
            
            if (section == 0 && (planetsInEachHouse[houseNumber]?.count ?? 0) > 0) || (section == 1 && (cuspRulersInEachHouse[houseNumber]?.count ?? 0) > 0) {
                return 20 // Return the desired height for the header
            }
        }
        return 0 // Return zero height for no header
    }

    // Updated method to determine number of rows based on sorted house strengths
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let tableViews = [firstTableView, secondTableView, thirdTableView, fourthTableView, fifthTableView, sixthTableView, seventhTableView, eighthTableView, ninthTableView, tenthTableView, eleventhTableView, twelfthTableView]
          if let index = tableViews.firstIndex(of: tableView), !sortedHousesByStrength.isEmpty {
              let houseStrengthPair = sortedHousesByStrength[index]
              let houseNumber = houseStrengthPair.0

              if section == 0 {
                  return planetsInEachHouse[houseNumber]?.count ?? 0
              } else if section == 1 {
                  return cuspRulersInEachHouse[houseNumber]?.count ?? 0
              }
          }
          return 0
      }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViews = [firstTableView, secondTableView, thirdTableView, fourthTableView, fifthTableView, sixthTableView, seventhTableView, eighthTableView, ninthTableView, tenthTableView, eleventhTableView, twelfthTableView]

        if let index = tableViews.firstIndex(of: tableView), !sortedHousesByStrength.isEmpty {
            let houseStrengthPair = sortedHousesByStrength[index]
            let houseNumber = houseStrengthPair.0

            if indexPath.section == 0 {
                guard let planetsInHouse = planetsInEachHouse[houseNumber], indexPath.row < planetsInHouse.count else {
                    return UITableViewCell()
                }
                let object = planetsInHouse[indexPath.row]
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {
                    return UITableViewCell()
                }
                let houseEffects = object.houseEffect
                let keyName = object.keyName.lowercased()
                cell.configure(aspectingPlanet: "", secondPlanetImageImageName: keyName, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: houseEffects, firstPlanetTextText: "", firstAspectHeaderTextText: " ", secondAspectHeaderTextText: " ")
                
                return cell
            } else if indexPath.section == 1 {
                guard let rulersInHouse = cuspRulersInEachHouse[houseNumber], indexPath.row < rulersInHouse.count else {
                    return UITableViewCell()
                }
                let object = rulersInHouse[indexPath.row]
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HousesCustomTableViewCell.identifier, for: indexPath) as? HousesCustomTableViewCell else {
                    return UITableViewCell()
                }
                
                let keyName = object.keyName.lowercased()
                let houseEffects = object.houseEffect
                cell.configure(aspectingPlanet: "", secondPlanetImageImageName: keyName, firstSignTextText: "", secondSignTextText: "", secondPlanetTextText: houseEffects, firstPlanetTextText: "", firstAspectHeaderTextText: " ", secondAspectHeaderTextText: " ")
                
                return cell
            }
        }
        return UITableViewCell()
    }

    // Method for fixed height of table view rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    // Method for handling selection of a row in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Additional logic for row selection can be added here
    }
}


