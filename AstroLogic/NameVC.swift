//
//  NameVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/8/23.
//

import Foundation
import UIKit
import SwiftEphemeris

class NameViewController: UIViewController {
    var chartCake: ChartCake!
    var harmoniousSigns: [Zodiac] = []
    var harmoniousPlanets: [CelestialObject] = []
    var name: String?
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a name"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    
    let checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check Harmony", for: .normal)
        button.addTarget(NameViewController.self, action: #selector(calculateHarmony), for: .touchUpInside)
        return button
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Name"
        label.textColor = .white
        return label
    }()
    
    let elementLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = ""
        label.textColor = .white
        return label
    }()
    
    let harmonyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = ""
        label.textColor = .white
        return label
    }()

    
    let glyphImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mercury")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
  

    override func viewDidLoad() {
         super.viewDidLoad()
         setupUI()
     }

    private func setupUI() {
           // Define the frames
           nameTextField.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 40)
        checkButton.frame = CGRect(x: 20, y: 160, width: view.bounds.width - 40, height: 50)
           resultLabel.frame = CGRect(x: 20, y: 220, width: view.bounds.width - 40, height: 80)
           glyphImageView.frame = CGRect(x: (view.bounds.width - 100) / 2, y: 320, width: 100, height: 100)
        harmonyLabel.frame = CGRect(x: 20, y: 250, width: view.bounds.width - 40, height: 80)
        
    

           // Additional UI setup...
           // Example: setting the placeholder for the text field
           nameTextField.placeholder = "Enter name"

           // Example: setting the title for the button
        checkButton.setTitle("What's in this Name?", for: .normal)

           // Add elements to the view
           view.addSubview(nameTextField)
           view.addSubview(checkButton)
           view.addSubview(resultLabel)
        view.addSubview(harmonyLabel)
           view.addSubview(glyphImageView)
       }
    @objc private func calculateHarmony() {
        guard let name = nameTextField.text, !name.isEmpty else {
            print("Name is empty")
            return // Handle empty name
        }

        let score = calculateNameScore(name: name)
        var planetOrSign = mapScoreToPlanetOrSign(score: score)
        
      //  print("Mapped Planet/Sign: \(planetOrSign)")
        let zodiacSigns = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]

        let isZodiacSign = zodiacSigns.contains(planetOrSign.capitalized)
        if isZodiacSign {
            planetOrSign = planetOrSign.prefix(1).capitalized + planetOrSign.dropFirst()
        }

       // print("Planet/Sign: \(planetOrSign)")

        // Get all scores, regardless of harmony
        let allPlanetScores = chartCake!.getPlanetsWithHarmonyScores(fromNetScores: chartCake.getTotalHarmonyDiscordNetScoresForPlanets())
        let allElementScores = chartCake!.getSignsWithHarmonyScores(fromScores: chartCake.calculateTotalSignHarmonyDiscord())

      //  print("All Planet Scores: \(allPlanetScores)")
       // print("All Element Scores: \(allElementScores)")

        // Determine the image and score for the glyph
        let glyphImage = UIImage(named: planetOrSign) // Fetch the image
        var harmonyScore: Double = 0.0

        if isZodiacSign {
            // Extract score for zodiac sign
            harmonyScore = allElementScores.first(where: { $0.zodiac.keyName == planetOrSign })?.score ?? 0.0
        } else {
            // Extract score for planet
            // Adjust comparison to be case-insensitive
            harmonyScore = allPlanetScores.first(where: { $0.planet.keyName.lowercased() == planetOrSign.lowercased() })?.score ?? 0.0
          //  print("Pre-UI Update Harmony Score for Planet: \(harmonyScore)")
        }

     //   print("Harmony Score: \(harmonyScore)")
        let harmonyStatus = determineHarmonyStatus(score: harmonyScore)
        // Update UI
        DispatchQueue.main.async { // Ensure UI updates are on the main thread
            self.resultLabel.text = "\(name)\nHarmony Score: \(String(format: "%.2f", harmonyScore))"
            self.glyphImageView.image = glyphImage
            self.harmonyLabel.text = harmonyStatus
        }
    }


    func determineHarmonyStatus(score: Double) -> String {
        switch score {
        case let x where x > 15.0:
            return "Very Harmonious"
        case let x where x > 7.0:
            return "Harmonious"
        case let x where x > 3.0:
            return "Mildly Harmonious"
        case let x where x > 0.0:
            return "Slightly Harmonious"
        case let x where x < 0.0:
            return "Slightly Discordant"
        case let x where x < -5.0:
            return "Mildly Discordant"
        case let x where x < -10.0:
            return "Discordant"
        default:
            return "Highly Discordant"
        }
    }

    
    func setupLayout() {
        view.backgroundColor = .black

        
        
        // Add subviews
        view.addSubview(nameTextField)
        view.addSubview(checkButton)
        view.addSubview(nameLabel)
        view.addSubview(glyphImageView)
        view.addSubview(resultLabel)
        view.addSubview(elementLabel)
        // Disable autoresizing masks
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        glyphImageView.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        elementLabel.translatesAutoresizingMaskIntoConstraints = false
        // Set up constraints
        NSLayoutConstraint.activate([
            // nameTextField constraints
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            elementLabel.topAnchor.constraint(equalTo: glyphImageView.bottomAnchor, constant: 10),
                  elementLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  elementLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            // checkButton constraints
            checkButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // nameLabel constraints
            nameLabel.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),

            // glyphImageView constraints
            glyphImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            glyphImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            glyphImageView.widthAnchor.constraint(equalToConstant: 100),
            glyphImageView.heightAnchor.constraint(equalToConstant: 100),

            // resultLabel constraints
            resultLabel.topAnchor.constraint(equalTo: elementLabel.bottomAnchor, constant: 10),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            resultLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            
            
        ])
    }

   

    func displayResult(isHarmonious: Bool, element: String) {
        // Assuming 'element' is the name of the sign or planet and
        // there are corresponding image assets in your project.
        let imageName = isHarmonious ? element.lowercased() : "notHarmonious"
        glyphImageView.image = UIImage(named: imageName)
        
        resultLabel.text = isHarmonious ? "Harmonious! \(element.capitalized) vibes with your chart." : "Not Harmonious"
        nameLabel.text = nameTextField.text // Update the nameLabel with the entered name
    }

    
    func reduceToRange(score: Int) -> Int {
        var result = score
        while result > 22 {
            result = String(result).reduce(0, { acc, char in
                acc + (Int(String(char)) ?? 0)
            })
        }
        return result
    }

    func calculateNameScore(name: String) -> Int {
        let key: [Character: Int] = [
            "a": 1, "b": 2, "g": 3, "d": 4, "e": 5, "v": 6, "u": 6, "w": 6, "z": 7,
            "h": 8, "i": 10, "y": 10, "j": 10, "c": 11, "k": 11, "l": 12, "m": 13,
            "n": 14, "x": 15, "o": 16, "p": 17, "f": 17, "q": 19, "r": 20, "s": 21,
            "t": 22
        ]

        let specialKey: [String: Int] = [
            "ch": 8, "th": 9, "ph": 17, "sh": 18, "ts": 18, "tz": 18
        ]

        var score = 0
        var index = 0

        while index < name.count {
            let char = name[name.index(name.startIndex, offsetBy: index)]
            if index < name.count - 1 {
                let nextChar = name[name.index(name.startIndex, offsetBy: index + 1)]
                let substr = String([char, nextChar]).lowercased()

                if let specialScore = specialKey[substr] {
                    score += specialScore
                    index += 2
                    continue
                }
            }

            if let charScore = key[char.lowercased().first!] {
                score += charScore
            }
            index += 1
        }

        return reduceToRange(score: score)
    }
    func mapScoreToPlanetOrSign(score: Int) -> String {
        let planetOrSigns = [
            1: "mercury",
            2: "virgo",
            3: "libra",
            4: "scorpio",
            5: "jupiter",
            6: "venus",
            7: "sagittarius",
            8: "capricorn",
            9: "aquarius",
            10: "uranus",
            11: "neptune",
            12: "pisces",
            13: "aries",
            14: "taurus",
            15: "saturn",
            16: "mars",
            17: "gemini",
            18: "cancer",
            19: "leo",
            20: "moon",
            21: "sun",
            22: "pluto"
        ]
        return planetOrSigns[score] ?? ""
    }

}
