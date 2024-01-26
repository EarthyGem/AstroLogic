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
    
    private var moodOfDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0 // Allows label to wrap text to as many lines as needed
        return label
    }()
    
    private var moonPhaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0 // Allows label to wrap text to as many lines as needed
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

        setupImageView()
        setupPhaseLabel()
        setupSpeedLabel()
        setupDeclinationLabel()
        setupMoodOfDayLabel()
        setupMoonPhaseLabel()

        // Assuming you have a method to get the mood of the day text
        moonPhaseLabel.text = getMoonPhaseText()
        moodOfDayLabel.text = getMoodOfDayText()

        if let lunarPhase = chartCake?.lunarPhase(for: chartCake!.transits).rawValue,
           let moonFormatted = chartCake?.transits.moon.sign.keyName {
            phaseNameSentence = "\(lunarPhase) Moon in \(moonFormatted)"
        } else {
            phaseNameSentence = "Unknown Phase" // Fallback in case data is missing
        }

        if let lunarPhases = chartCake?.lunarPhase(for: chartCake!.transits).rawValue {
            imageView.image = UIImage(named: lunarPhases)
        }
        phaseLabel.text = phaseNameSentence
        speedLabel.text = moonSpeedDescription(speed: chartCake?.transits.moon.speedLongitude)
        declinationLabel.text = moonDeclinationDescription(declination: chartCake?.transits.moon.declination)
    }


    func setupImageView() {
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // Adjust top anchor to safe area
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    func setupPhaseLabel() {
        view.addSubview(phaseLabel)

        NSLayoutConstraint.activate([
            phaseLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            phaseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func setupSpeedLabel() {
        view.addSubview(speedLabel)

        NSLayoutConstraint.activate([
            speedLabel.topAnchor.constraint(equalTo: phaseLabel.bottomAnchor, constant: 10),
            speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            speedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func setupDeclinationLabel() {
        view.addSubview(declinationLabel)

        NSLayoutConstraint.activate([
            declinationLabel.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 10),
            declinationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            declinationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            declinationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func setupMoodOfDayLabel() {
        view.addSubview(moodOfDayLabel)

        NSLayoutConstraint.activate([
            moodOfDayLabel.topAnchor.constraint(equalTo: declinationLabel.bottomAnchor, constant: 20),
            moodOfDayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moodOfDayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            moodOfDayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func setupMoonPhaseLabel() {
        view.addSubview(moonPhaseLabel)

        NSLayoutConstraint.activate([
            moonPhaseLabel.topAnchor.constraint(equalTo: moodOfDayLabel.bottomAnchor, constant: 20),
            moonPhaseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moonPhaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            moonPhaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // A placeholder method that you'll replace with the actual implementation
    func getMoodOfDayText() -> String {
        // This method should return the "Mood of the Day" based on the current moon phase or zodiac sign.
        return (chartCake?.transits.moon.sign.moodOfTheDay)!
    }
    
    func getMoonPhaseText() -> String {
        guard let lunarPhase = chartCake?.lunarPhase(for: chartCake!.transits) else {
            return "Moon phase information is currently unavailable."
        }
        
        // Get the current month as an integer
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        // Retrieve the message for the current lunar phase and month
        return lunarPhase.messageFor(month: currentMonth)
    }


}

