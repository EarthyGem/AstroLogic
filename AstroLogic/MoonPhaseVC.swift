// MoonPhaseVC.swift
// AstroLogic
//
// Created by Errick Williams on 10/23/23.
//

import Foundation
import SwiftEphemeris
import UIKit

class MoonPhaseViewController: UIViewController {
    var chartCake: ChartCake?
    
    // This will hold the name of the moon phase.
    var phaseName: String!
    var archetype: String!
    var phaseNameSentence: String!
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private var phaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = . lightGray
        return label
    }()
    
    private var archetypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = . lightGray
        return label
    }()
    
    private var speedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()

    private var declinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()

    
    // Convert average Moon speed to decimal degrees
    let averageMoonSpeed: Double = 13 + 10.0/60 + 35.0/3600  // 13.1675

    // Determine if the Moon's speed is "Slow" or "Fast"
    func moonSpeedDescription(speed: Double?) -> String {
        var moonSpeed = chartCake?.natal.moon.speedLongitude
        if moonSpeed! > averageMoonSpeed {
            return "Fast Moon"
        } else {
            return "Slow Moon"
        }
    }

    // Threshold for "out of bounds" Moon in declination
    let outOfBoundsThreshold: Double = 23 + 28.0/60  // 23.4667

    // Determine if the Moon's declination is "out of bounds"
    func moonDeclinationDescription(declination: Double?) -> String {
        var moonDeclination = chartCake?.natal.moon.declination
        
        if abs(moonDeclination!) > outOfBoundsThreshold {
            return "Out of Bounds Moon"
        } else {
            return "In Bounds Moon"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // Declare lunarPhase outside of the if-let scope so it can be used throughout viewDidLoad
        let lunarPhase = chartCake?.lunarPhase(for: chartCake!.natal)
        
        if let phase = lunarPhase?.rawValue,
           let moonFormatted = chartCake?.natal.moon.sign.keyName.capitalizingFirstLetter() {
            archetype = lunarPhase?.archetype
            phaseNameSentence = "\(phase) Moon in \(moonFormatted)"
        } else {
            phaseNameSentence = "Unknown Phase" // Fallback in case any of the data is missing
            archetype = "Unknown Archetype"
        }

        setupImageView()
        setupPhaseLabel()
        setupArchetypeLabel() // Now, this function is called with the archetype variable properly assigned.
        setupSpeedLabel()
        setupDeclinationLabel()

        imageView.image = UIImage(named: lunarPhase?.rawValue ?? "")
        phaseLabel.text = phaseNameSentence
        archetypeLabel.text = archetype // Now, this line is correct as archetype is in the wider scope.
        speedLabel.text = moonSpeedDescription(speed: chartCake?.natal.moon.speedLongitude)
        declinationLabel.text = moonDeclinationDescription(declination: chartCake?.natal.moon.declination)
    }


    func setupArchetypeLabel() {
        view.addSubview(archetypeLabel)

        NSLayoutConstraint.activate([
            archetypeLabel.topAnchor.constraint(equalTo: phaseLabel.bottomAnchor, constant: 10),
            archetypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            archetypeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 40),
        ])
    }

    func setupSpeedLabel() {
        view.addSubview(speedLabel)

        NSLayoutConstraint.activate([
            speedLabel.topAnchor.constraint(equalTo: archetypeLabel.bottomAnchor, constant: 10), // Position below the archetype label
            speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 40),
        ])
    }

    // ... rest of your existing code ...

    
    
    func setupImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150), // Adjust this value to move the imageView up or down
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setupPhaseLabel() {
        view.addSubview(phaseLabel)
        
        NSLayoutConstraint.activate([
            phaseLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20), // 20 points space below imageView
            phaseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phaseLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 40), // Assuming you want some margin on the sides. Adjust if needed.
        ])
    }
    

    func setupDeclinationLabel() {
        view.addSubview(declinationLabel)
        
        NSLayoutConstraint.activate([
            declinationLabel.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 10),
            declinationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            declinationLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 40),
        ])
    }
}
