//
//  CountDownVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import UIKit

class CountdownViewController: UIViewController {

    var countdownLabel: UILabel!
       var timer: Timer?
       var targetDate: Date? // This will be the user's birthday

    var reflectionTextView: UITextView!
    var insightsTextView: UITextView!
    var birthdayWishLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setupCountdownLabel()
     //   setupReflectionSection()
//setupInsightSection()
        startTimer()
        setupSections()
    }

    // ... [Other Functions]

    func setupReflectionSection() {
        reflectionTextView = UITextView(frame: CGRect(x: 20, y: countdownLabel.frame.maxY + 20, width: self.view.frame.width - 40, height: (self.view.frame.height - countdownLabel.frame.maxY) / 2 - 30))
        reflectionTextView.font = UIFont.systemFont(ofSize: 18)
        reflectionTextView.isEditable = false
        reflectionTextView.text = "Your reflections from the past year: \n\n" // Load this from wherever you store the user's reflection data
        view.addSubview(reflectionTextView)
    }

    func setupInsightSection() {
//        insightsTextView = UITextView(frame: CGRect(x: 20, y: reflectionTextView.frame.maxY + 20, width: self.view.frame.width - 40, height: (self.view.frame.height - reflectionTextView.frame.maxY) / 2 - 30))
//        insightsTextView.font = UIFont.systemFont(ofSize: 18)
//        insightsTextView.isEditable = false
//        insightsTextView.text = "Your insights for the upcoming year: \n\n" // Load this from your astrological insights data source
//        view.addSubview(insightsTextView)
    }
    
    func setupCountdownLabel() {
            countdownLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
            countdownLabel.center = self.view.center
        countdownLabel.textColor = .purple
            countdownLabel.textAlignment = .center
            countdownLabel.font = UIFont.systemFont(ofSize: 30)
            view.addSubview(countdownLabel)
        }

        func startTimer() {
            // Ensure the timer starts fresh
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        }


    func setupSections() {
            let currentDate = Date()
            let twoWeeksInterval = TimeInterval(2 * 7 * 24 * 60 * 60) // 2 weeks in seconds

            guard let targetDate = targetDate, let diff = Calendar.current.dateComponents([.day], from: currentDate, to: targetDate).day else {
                setupBirthdayWishSection() // Default to birthday wish if something goes wrong
                return
            }

            if diff <= 14 {
                setupReflectionSection()
                setupInsightSection()
            } else {
                setupBirthdayWishSection()
            }
        }

    func setupBirthdayWishSection() {
        birthdayWishLabel = UILabel()
        birthdayWishLabel.font = UIFont.systemFont(ofSize: 34)
        birthdayWishLabel.textColor = .blue
        birthdayWishLabel.text = "Birthday Wish 🎂" // Load this from wherever you store the user's birthday wish
        birthdayWishLabel.textAlignment = .center
        birthdayWishLabel.numberOfLines = 0 // This allows the label to wrap text if needed

        // Set the frame to the view's bounds
        birthdayWishLabel.frame = view.bounds

        // Allow the label to automatically resize for any changes (like device rotation)
        birthdayWishLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(birthdayWishLabel)
    }

        @objc func updateCountdown() {
            guard let targetDate = targetDate else { return }

            let currentDate = Date()
            let calendar = Calendar.current

            let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: targetDate)

            if let days = components.day, let hours = components.hour, let minutes = components.minute, let seconds = components.second {
                countdownLabel.text = "\(days) days, \(hours) hours, \(minutes) minutes, \(seconds) seconds until your birthday!"

                // This will ensure that sections update when the date crosses the 2-weeks mark:
                if (days == 14 && hours == 0 && minutes == 0 && seconds == 0) || (days == 0 && hours == 0 && minutes == 0 && seconds == 0) {
                    for subview in view.subviews {
                        if subview is UITextView {
                            subview.removeFromSuperview()
                        }
                    }
                    setupSections()
                }
            }
        }
    }
