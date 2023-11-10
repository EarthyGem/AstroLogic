//
//  CompositStrongestPlanet.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/8/23.
//

import Foundation
import UIKit
import SwiftEphemeris



class CompositeStrongestPlanetViewController: UIViewController {
    var tarot: String = ""
    var harTarot: String = ""
    var disTarot: String = ""
    var strongestPlanetName: String!
    var strongestPlanet: String!
    var mostHarmoniousPlanet: String!
    var strongestPlanetArchetype: String!
    var mostHarmoniousPlanetArchetype: String!
    var mostDiscordantPlanetArchetype: String!
    var mostDiscordantPlanet: String!
    var sentenceText: String!
    var scores: [Planet: CGFloat]?
    var chart: Chart?
    var chartCake: ChartCake?
    var otherChart: ChartCake?
    var name: String!
    var latitude: Double?
    var longitude: Double?
    var phaseName: String?

    var combinedBirthDateTime: (date: Date?, timeZone: TimeZone?)?
    var birthPlace: String?
    private let nameLabel = UILabel()
    private let placeLabel = UILabel()
    private let dateTimeLabel = UILabel()
    var dateString: String?
    var strongestPlanetSign: String!
    var sortedPlanets: [CelestialObject] = []
    var birthDate: Date?
    // Add
//    var getMinors: (() -> Date)?
//    var getMajorProgresseDate: (() -> Date)?

    private let bottomLabel = UILabel()
    private let imageView = UIImageView()
    private let label = UILabel()
    private let titleLabel = UILabel()

    private let harmoniousImageView = UIImageView()
    private let harmoniousLabel = UILabel()
    private let harmoniousTitleLabel = UILabel()

    private let discordantImageView = UIImageView()
    private let discordantLabel = UILabel()
    private let discordantTitleLabel = UILabel()

//    let planetTexts = [
//        "Sun": SunText,
//        "Moon": MoonText,
//        "Mercury": MercuryText,
//        "Venus": VenusText,
//        "Mars": MarsText,
//        "Jupiter": JupiterText,
//        "Saturn": SaturnText,
//        "Uranus": UranusText,
//        "Neptune": NeptuneText,
//        "Pluto": PlutoText
//    ]


    private let myItemsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to My Items", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(StrongestPlanetViewController.self, action: #selector(myItemsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        var chart = Chart(alpha: otherChart!.natal, bravo: chartCake!.natal)
        self.navigationItem.hidesBackButton = true
          let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.back(sender:)))
          self.navigationItem.leftBarButtonItem = newBackButton
        view.backgroundColor = .black
       configureStrongestImageView()
    //  configureStrongestLabel()
  //      configureStrongestTitleLabel(name: name)
        configureHarmoniousImageView()
    //    configureHarmoniousTitleLabel()
   //     configureHarmoniousLabel()
        configureDiscordantImageView()
   //     configureDiscordantTitleLabel()
   //     configureDiscordantLabel()
        configureBottomLabel()

        let myItemsButton = UIButton(type: .system)
        myItemsButton.setTitle("Go to My Items", for: .normal)
        myItemsButton.addTarget(self, action: #selector(myItemsButtonTapped), for: .touchUpInside)
        myItemsButton.translatesAutoresizingMaskIntoConstraints = false

        let myItemsBarButtonItem = UIBarButtonItem(customView: myItemsButton)
        navigationItem.rightBarButtonItem = myItemsBarButtonItem

        configureNameLabel()
           configurePlaceLabel()
           configureDateTimeLabel()
        setupLabels()
        
        
        let scores = chart.getTotalPowerScoresForPlanets()
        let strongestPlanet = getStrongestPlanet(from: scores)
        print(strongestPlanet)

        // let signScore = self.otherChart.natal.calculateTotalSignScore()
        // let houseStrengths = self.otherChart.natal.calculatePlanetInHouseScores()
        // let houseScores = self.otherChart.natal.calculateHouseStrengths()

        let tuple = chart.getTotalHarmonyDiscordScoresForPlanets()
        let mostDiscordantPlanet = getMostDiscordantPlanet(from: tuple)
        let mostHarmoniousPlanet = getMostHarmoniousPlanet(from: tuple)
var tarot = getStrongestPlanet(from: scores).tarot
        var disTarot = mostDiscordantPlanet.tarot
        var harTarot = mostHarmoniousPlanet.tarot
        var strongestPlanetArchetype = strongestPlanet.archetype
        var mostDiscordantPlanetArchetype = mostDiscordantPlanet.archetype
        var mostHarmoniousPlanetArchetype = mostHarmoniousPlanet.archetype
        var strongestPlanetSign = strongestPlanetSign
        
        
        
        if strongestPlanet == Planet.sun.celestialObject {
            strongestPlanetSign = chart.sun.sign.keyName
        } else if strongestPlanet == Planet.moon.celestialObject {
            strongestPlanetSign = chart.moon.sign.keyName
        } else if strongestPlanet == Planet.mercury.celestialObject {
            strongestPlanetSign = chart.mercury.sign.keyName
        } else if strongestPlanet == Planet.venus.celestialObject {
            strongestPlanetSign = chart.venus.sign.keyName
        } else if strongestPlanet == Planet.mars.celestialObject {
            strongestPlanetSign = chart.mars.sign.keyName
        } else if strongestPlanet == Planet.jupiter.celestialObject {
           
            strongestPlanetSign = chart.saturn.sign.keyName
        } else if strongestPlanet == Planet.uranus.celestialObject {
            strongestPlanetSign = chart.uranus.sign.keyName
        } else if strongestPlanet == Planet.neptune.celestialObject {
            strongestPlanetSign = chart.neptune.sign.keyName
        } else if strongestPlanet == Planet.pluto.celestialObject {
            strongestPlanetSign = chart.pluto.sign.keyName
        } else if strongestPlanet == LunarNode.meanSouthNode.celestialObject {
            strongestPlanetSign = chart.southNode.sign.keyName
        }

     //   let sentence = generateAstroSentence(strongestPlanet: strongestPlanet.keyName,
//                                             strongestPlanetSign: strongestPlanetSign!,
//                                             sunSign: chart.sun.sign.keyName,
//                                             moonSign: chart.moon.sign.keyName,
//                                             risingSign: chart.houseCusps.ascendent.sign.keyName, name: name)
//
//        
       
        
     

    }

    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }


    @objc func myItemsButtonTapped() {
        // Initialize and push the MyItemsViewController
        let myItemsVC = MyCompositeItemsViewController()
        myItemsVC.chart = Chart(alpha: chartCake!.natal, bravo: otherChart!.natal)
        myItemsVC.strongestPlanet = strongestPlanet.self
        myItemsVC.chartCake = chartCake.self
        myItemsVC.sortedPlanets = sortedPlanets.self
        myItemsVC.name = name.self
        myItemsVC.phaseName = phaseName.self
        myItemsVC.birthDate = birthDate.self
        myItemsVC.sortedPlanets = sortedPlanets.self
        myItemsVC.latitude = latitude.self
        myItemsVC.longitude = longitude.self
        // Pass other properties if needed
        // myItemsVC.strongestPlanet = self.strongestPlanet
        // myItemsVC.getMinors = self.getMinors
        // myItemsVC.getMajorProgresseDate = self.getMajorProgresseDate
        self.navigationController?.pushViewController(myItemsVC, animated: true)
    }
    
    func getStrongestPlanet(from scores: [CelestialObject: Double]) -> CelestialObject {
        let sorted = scores.sorted { $0.value > $1.value }
        let strongestPlanet = sorted.first!.key

        return strongestPlanet
    }


    // ... existing methods

    private func configureHarmoniousImageView() {
        guard let imageName = mostHarmoniousPlanet?.lowercased() else {
               // Handle the case when strongestPlanet is nil
               return
           }
        harmoniousImageView.image = UIImage(named: imageName)
        harmoniousImageView.contentMode = .scaleAspectFit
        harmoniousImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(harmoniousImageView)

        NSLayoutConstraint.activate([
            harmoniousImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            harmoniousImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            harmoniousImageView.widthAnchor.constraint(equalToConstant: 100),
            harmoniousImageView.heightAnchor.constraint(equalToConstant: 100)


        ])
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(harmoniousImageViewTapped))
               harmoniousImageView.addGestureRecognizer(tapGestureRecognizer)
               harmoniousImageView.isUserInteractionEnabled = true

    }
    
    func getMostHarmoniousPlanet(from scores: [CelestialObject: (harmony: Double, discord: Double, net: Double)]) -> CelestialObject {
        let sorted = scores.sorted { $0.value.net > $1.value.net }
        let mostHarmoniousPlanet = sorted.first!.key
        return mostHarmoniousPlanet
    }

    func getMostDiscordantPlanet(from scores: [CelestialObject: (harmony: Double, discord: Double, net: Double)]) -> CelestialObject {
        let sorted = scores.sorted { $0.value.net < $1.value.net }
        let mostDiscordantPlanet = sorted.first!.key
        return mostDiscordantPlanet
    }


    private func configureHarmoniousTitleLabel() {
        harmoniousTitleLabel.text = "Gift Giver😇"
        harmoniousTitleLabel.textColor = .white
        harmoniousTitleLabel.font = UIFont.systemFont(ofSize: 14)
        harmoniousTitleLabel.textAlignment = .center
        harmoniousTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(harmoniousTitleLabel)

//        NSLayoutConstraint.activate([
//            harmoniousTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            harmoniousTitleLabel.trailingAnchor.constraint(equalTo: harmoniousImageView.trailingAnchor),
//            harmoniousTitleLabel.bottomAnchor.constraint(equalTo: harmoniousImageView.topAnchor, constant: -10),
//        ])
    }

    private func configureStrongestImageView() {
        guard let imageName = strongestPlanet?.lowercased() else {
               // Handle the case when strongestPlanet is nil
               return
           }
           imageView.image = UIImage(named: imageName)


        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
    }

    @objc func imageViewTapped() {
        let infoViewController = SPInfoViewController()
        infoViewController.tarot = tarot
        infoViewController.name = name
        infoViewController.strongestPlanetSign = strongestPlanetSign
        infoViewController.strongestPlanet = strongestPlanet

           self.present(infoViewController, animated: true, completion: nil)
    }
//
    @objc func harmoniousImageViewTapped() {
        let infoViewController = HarmonyInfoViewController()
        infoViewController.harTarot = harTarot
        infoViewController.name = name
        infoViewController.mostHarmoniousPlanet = mostHarmoniousPlanet
        self.present(infoViewController, animated: true, completion: nil)
    }

    @objc func discordantImageViewTapped() {
        let infoViewController = DiscordInfoViewController()
        infoViewController.disTarot = disTarot
        infoViewController.name = name
        infoViewController.mostDiscordantPlanet = mostDiscordantPlanet
        self.present(infoViewController, animated: true, completion: nil)
    }



    private func configureStrongestTitleLabel(name: String) {
        titleLabel.text = "This Relationship's Dominant Archetype"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -20),
        ])
    }





        // Initialize and push the ChartViewController


        //        birthChartView = BirthChartView(frame: view.bounds, chartCake: chartCake!)


//    private func configureStrongestLabel() {
//        label.text = "The"
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
//        ])
//    }

//    private func configureHarmoniousLabel() {
//        harmoniousLabel.text = "The "
//        harmoniousLabel.textColor = .white
//        harmoniousLabel.font = UIFont.systemFont(ofSize: 14)
//        harmoniousLabel.textAlignment = .center
//        harmoniousLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(harmoniousLabel)
//
//        NSLayoutConstraint.activate([
//            harmoniousLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            harmoniousLabel.trailingAnchor.constraint(equalTo: harmoniousImageView.trailingAnchor),
//            harmoniousLabel.topAnchor.constraint(equalTo: harmoniousImageView.bottomAnchor, constant: 10),
//        ])
//    }

    private func configureDiscordantImageView() {
        guard let imageName = mostDiscordantPlanet?.lowercased() else {
               // Handle the case when strongestPlanet is nil
               return
           }
        discordantImageView.image = UIImage(named: imageName)
        discordantImageView.contentMode = .scaleAspectFit
        discordantImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(discordantImageView)

        NSLayoutConstraint.activate([
            discordantImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            discordantImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20), discordantImageView.widthAnchor.constraint(equalToConstant: 100),
            discordantImageView.heightAnchor.constraint(equalToConstant: 100)
            ])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(discordantImageViewTapped))
           discordantImageView.addGestureRecognizer(tapGestureRecognizer)
           discordantImageView.isUserInteractionEnabled = true
            }


            private func configureDiscordantTitleLabel() {
                discordantTitleLabel.text = "Guardian of the Threshold⚔️"
                discordantTitleLabel.textColor = .white
                discordantTitleLabel.font = UIFont.systemFont(ofSize: 12)
                discordantTitleLabel.numberOfLines = 2
                discordantTitleLabel.textAlignment = .center
                discordantTitleLabel.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(discordantTitleLabel)

//                NSLayoutConstraint.activate([
//                    discordantTitleLabel.leadingAnchor.constraint(equalTo: discordantImageView.leadingAnchor),
//                    discordantTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                    discordantTitleLabel.bottomAnchor.constraint(equalTo: discordantImageView.topAnchor, constant: -10),
//                ])
            }

//            private func configureDiscordantLabel() {
//                discordantLabel.text = "The \(mostDiscordantPlanetArchetype!)"
//                discordantLabel.textColor = .white
//                discordantLabel.font = UIFont.systemFont(ofSize: 14)
//                discordantLabel.textAlignment = .center
//                discordantLabel.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(discordantLabel)
//
//                NSLayoutConstraint.activate([
//                    discordantLabel.leadingAnchor.constraint(equalTo: discordantImageView.leadingAnchor),
//                    discordantLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                    discordantLabel.topAnchor.constraint(equalTo: discordantImageView.bottomAnchor, constant: 10),
//                ])
//            }

//            func getPlanetOrSignData(planetOrSign: String) -> [String] {
//                return PlanetData.data[planetOrSign] ?? []
//            }

    private func setupLabels() {
        configureNameLabel()
        configurePlaceLabel()
        configureDateTimeLabel()

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            placeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            placeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            placeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            dateTimeLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 1),
            dateTimeLabel.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            dateTimeLabel.trailingAnchor.constraint(equalTo: placeLabel.trailingAnchor)
        ])
    }

    private func configureNameLabel() {
        nameLabel.text = name
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
    }

    private func configurePlaceLabel() {

        placeLabel.text = birthPlace
        placeLabel.textColor = .white
        placeLabel.font = UIFont.systemFont(ofSize: 12)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeLabel)
    }



    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss zzzz" // or whatever your desired format is

        // Here is the critical part. Set the time zone of the formatter.
        if let timeZone = self.combinedBirthDateTime?.timeZone { // assuming you have a way to retrieve the timezone
            formatter.timeZone = timeZone
        }

        return formatter.string(from: date)
    }

    private func configureDateTimeLabel() {
        if let dateString = dateString {
            dateTimeLabel.text = dateString
        } else {
           // dateTimeLabel.text = "Date & Time not set"
        }

        dateTimeLabel.textColor = .white
        dateTimeLabel.font = UIFont.systemFont(ofSize: 12)
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateTimeLabel)
    }

    private func configureBottomLabel() {
           bottomLabel.text = sentenceText
           bottomLabel.textColor = .white
           bottomLabel.font = UIFont.systemFont(ofSize: 18)
        bottomLabel.lineBreakMode = .byWordWrapping
        bottomLabel.numberOfLines = 0
           bottomLabel.textAlignment = .center
           bottomLabel.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(bottomLabel)

           NSLayoutConstraint.activate([
               bottomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               bottomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               bottomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
           ])
       }
   }

           
