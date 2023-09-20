//
//  RechargeVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import UIKit

class RechargeViewController: UIViewController {

    // Existing UI Components

    let rechargeButton = UIButton()

    // New UI Components
    let transitDateLabel = UILabel()
    let countdownLabel = UILabel()
    let birthdayWishLabel = UILabel()

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        self.title = "Monthly Recharge"

        setupUI()
        startTimer()
    }

    // Other functions remain the same...

    func setupUI() {


        // Set up rechargeButton
        rechargeButton.translatesAutoresizingMaskIntoConstraints = false
        rechargeButton.setTitle("Recharge", for: .normal)
        rechargeButton.backgroundColor = .blue
        rechargeButton.addTarget(self, action: #selector(rechargeAction), for: .touchUpInside)
        view.addSubview(rechargeButton)


        // Set up transitDateLabel
        transitDateLabel.translatesAutoresizingMaskIntoConstraints = false
        transitDateLabel.text = "Next Reacharge Date: \(getNextTransitDate())"
        transitDateLabel.numberOfLines = 0
        view.addSubview(transitDateLabel)

        // Set up countdownLabel
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.text = "Countdown: ..."
        countdownLabel.numberOfLines = 0
        view.addSubview(countdownLabel)

        // Set up birthdayWishLabel
        birthdayWishLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayWishLabel.text = "Birthday Wish: \(retrieveIntention() ?? "None")"
        birthdayWishLabel.numberOfLines = 0
        view.addSubview(birthdayWishLabel)

        setupConstraints()
    }

    func setupConstraints() {



        // New constraints
        NSLayoutConstraint.activate([
            transitDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            transitDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            transitDateLabel.topAnchor.constraint(equalTo: rechargeButton.bottomAnchor, constant: 16),

            countdownLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            countdownLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            countdownLabel.topAnchor.constraint(equalTo: transitDateLabel.bottomAnchor, constant: 16),

            birthdayWishLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            birthdayWishLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            birthdayWishLabel.topAnchor.constraint(equalTo: countdownLabel.bottomAnchor, constant: 16)
        ])
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }


    @objc func rechargeAction() {
        // Handle recharge action here, perhaps show a modal or a new view
    }

    func saveIntention(intention: String) {
        UserDefaults.standard.set(intention, forKey: "userIntention")
    }

    func retrieveIntention() -> String? {
        return UserDefaults.standard.string(forKey: "userIntention")
    }

    func getNextTransitDate() -> Date {
        // You'd need an astrological calculation here.
        // Returning a dummy date for now.
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.date(from: "Oct 02, 2023") ?? Date()
    }

    @objc func updateCountdown() {
        let currentDate = Date()
        let targetDate = getNextTransitDate()
        let interval = targetDate.timeIntervalSince(currentDate)

        if interval <= 0 {
            countdownLabel.text = "Countdown: Time's up!"
            timer?.invalidate()
            timer = nil
            return
        }

        let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60

        // Optionally, add days to the countdown
        let days = hours / 24

        countdownLabel.text = String(format: "Countdown: %02d days, %02d:%02d:%02d", days, hours%24, minutes, seconds)
    }



}


