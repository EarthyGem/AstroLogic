//
//  ListViewController.swift
//  TableviewPassData
//
//  Created by Afraz Siddiqui on 8/29/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//
import SwiftEphemeris
import UIKit

class CompositePlanetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var chartCake: ChartCake!
    var otherChart: ChartCake!
    
    
    var CompositeChartView: BirthChartView!

    var natalSigns: [String] = []

    // ... Rest of your code ...
    
    func setupNatalSigns() -> [String] {
        natalSigns = [
            otherChart?.natal.sun.sign.keyName,
            otherChart?.natal.moon.sign.keyName,
            otherChart?.natal.ascendant.sign.keyName,
            otherChart?.natal.mercury.sign.keyName,
            otherChart?.natal.venus.sign.keyName,
            otherChart?.natal.mars.sign.keyName,
            otherChart?.natal.jupiter.sign.keyName,
            otherChart?.natal.saturn.sign.keyName,
            otherChart?.natal.uranus.sign.keyName,
            otherChart?.natal.neptune.sign.keyName,
            otherChart?.natal.pluto.sign.keyName,
            otherChart?.natal.southNode.sign.keyName
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return natalSigns
    }
    
    func getNatalPositions() -> [String] {
        natalSigns = [
            otherChart?.natal.sun.formatted,
            otherChart?.natal.moon.formatted,
            otherChart?.natal.ascendant.formatted,
            otherChart?.natal.mercury.formatted,
            otherChart?.natal.venus.formatted,
            otherChart?.natal.mars.formatted,
            otherChart?.natal.jupiter.formatted,
            otherChart?.natal.saturn.formatted,
            otherChart?.natal.uranus.formatted,
            otherChart?.natal.neptune.formatted,
            otherChart?.natal.pluto.formatted,
            otherChart?.natal.southNode.formatted
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return natalSigns
    }
    
var planetGlyphs = ["sun","moon","","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto"]


    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
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
        let birthChartView = CompositeBirthChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: chartCake!, otherChart: otherChart!)
        
     
    //    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Transits", style: .plain, target: self, action: #selector(transitsToCompositeButtonTapped))
        
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
        let yOffset: CGFloat = 550
        let tableViewHeight = view.bounds.height - yOffset - 20  // Adjust this as per your requirements
        tableView.frame = CGRect(x: 10, y: yOffset, width: view.bounds.width - 20, height: tableViewHeight)
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: "", planetImageImageName: "", signTextText: "", planetTextText: "", headerTextText: "")
        
//        cell.configure(signGlyphImageName: planetGlyphs[indexPath.row], planetImageImageName: "\(planetImages2[indexPath.row])", signTextText: getNatalPositions()[indexPath.row], planetTextText: "\(h_Planets[indexPath.row])", headerTextText: "\(h_planets[indexPath.row])")
        
        
         return cell
         
         
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print(planets[indexPath.row])
        

        
        let MovingPlanetVCs = [TodayViewController()]
        
        
        let vc = MovingPlanetVCs[indexPath.row]
        present(UINavigationController(rootViewController: vc), animated: true)
        
        
     
}

}

