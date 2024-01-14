//
//  ListViewController.swift
//  TableviewPassData
//
//  Created by Afraz Siddiqui on 8/29/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//
import SwiftEphemeris
import UIKit

class RelationshipsPlanetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 
    var birthChartView: BirthChartView!

    var natalSigns = [String]()

    var natalChart: ChartCake?
    var selectedChart: ChartCake?
    
    func setupNatalSigns() -> [String] {
        natalSigns = [
            natalChart?.natal.sun.sign.keyName,
            natalChart?.natal.moon.sign.keyName,
            natalChart?.natal.ascendant.sign.keyName,
            natalChart?.natal.mercury.sign.keyName,
            natalChart?.natal.venus.sign.keyName,
            natalChart?.natal.mars.sign.keyName,
            natalChart?.natal.jupiter.sign.keyName,
            natalChart?.natal.saturn.sign.keyName,
            natalChart?.natal.uranus.sign.keyName,
            natalChart?.natal.neptune.sign.keyName,
            natalChart?.natal.pluto.sign.keyName,
            natalChart?.natal.southNode.sign.keyName
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return natalSigns
    }
    
    func getNatalPositions() -> [String] {
        natalSigns = [
            natalChart?.natal.sun.formatted,
            natalChart?.natal.moon.formatted,
            natalChart?.natal.ascendant.formatted,
            natalChart?.natal.mercury.formatted,
            natalChart?.natal.venus.formatted,
            natalChart?.natal.mars.formatted,
            natalChart?.natal.jupiter.formatted,
            natalChart?.natal.saturn.formatted,
            natalChart?.natal.uranus.formatted,
            natalChart?.natal.neptune.formatted,
            natalChart?.natal.pluto.formatted,
            natalChart?.natal.southNode.formatted
        ].compactMap { $0 } // This will remove any nil values from the array
    

        
        // This will remove any nil values from the array
        
        return natalSigns
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
        let birthChartView = RelationshipBirthChartView(frame: CGRect(x: 0, y: 130, width: screenWidth, height: screenWidth), chartCake: natalChart!, otherChartCake: selectedChart!)
     
        
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
        tableView.frame = CGRect(x: 10, y: 550, width: 380, height: 700)
        
    }




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
             
             return UITableViewCell()
         }
        
        cell.configure(signGlyphImageName: planetGlyphs[indexPath.row], planetImageImageName: "", signTextText: getNatalPositions()[indexPath.row], planetTextText: "", headerTextText: "", capsuleText: "")
        

        
         return cell
         
         
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print(planets[indexPath.row])
        
      


        
     
}

}

