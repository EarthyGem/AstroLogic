//
//  CurrentMoonPhaseVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 10/31/23.
//

import Foundation
import SwiftEphemeris
import UIKit

class CurrentMoonPhaseViewController: UIViewController {
    var chartCake: ChartCake?

    // This will hold the name of the moon phase.
    var phaseName: String!
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
        var moonSpeed = chartCake?.transits.moon.speedLongitude
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
        var moonDeclination = chartCake?.transits.moon.declination

        if abs(moonDeclination!) > outOfBoundsThreshold {
            return "Out of Bounds Moon"
        } else {
            return "In Bounds Moon"
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        if let lunarPhase = chartCake?.lunarPhase(for: chartCake!.transits).rawValue,
           let moonFormatted = chartCake?.transits.moon.sign.keyName.capitalizingFirstLetter(),
           let _ = chartCake?.houseCusps.house(of: chartCake!.transits.moon).houseKeywords {
            phaseNameSentence = "\(lunarPhase) Moon in \(moonFormatted)"
        } else {
            phaseNameSentence = "Unknown Phase" // This is a fallback in case any of the data is missing
        }
var lunarPhases = chartCake?.lunarPhase(for: chartCake!.transits).rawValue

        setupImageView()
        setupPhaseLabel()
        setupSpeedLabel()
        setupDeclinationLabel()

        imageView.image = UIImage(named: lunarPhases!)
        phaseLabel.text = phaseNameSentence
        speedLabel.text = moonSpeedDescription(speed: chartCake?.transits.moon.speedLongitude)
        declinationLabel.text = moonDeclinationDescription(declination: chartCake?.transits.moon.declination)
    }



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

    func setupSpeedLabel() {
        view.addSubview(speedLabel)

        NSLayoutConstraint.activate([
            speedLabel.topAnchor.constraint(equalTo: phaseLabel.bottomAnchor, constant: 10),
            speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 40),
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
