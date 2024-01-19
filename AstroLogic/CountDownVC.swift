//
//  CountDownVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import UIKit
import SwiftEphemeris

class CountdownViewController: UIViewController {

    var countdownLabel: UILabel!
    var timer: Timer?
    var targetDate: Date? // This will be the user's birthday
    var chartCake: ChartCake!
    var birthdayWishTextField: UITextField!
    var birthdayWishLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setupCountdownLabel()
        setupBirthdayWishTextField()
        
        // Directly use the natal longitude since it's not optional
        let natalSunLongitude = chartCake.natal.sun.longitude
        // Use today's date as the starting point to find the next birthday
        if let nextBirthday = findNextBirthdayLongitudeMatch(currentLongitude: natalSunLongitude, startFromDate: Date()) {
            targetDate = nextBirthday
            startTimer()
        } else {
            print("Could not find the next birthday longitude match.")
            // Handle error case here, perhaps alert the user or provide a default date
        }
    }


    func setupCountdownLabel() {
        countdownLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 40))
        countdownLabel.textColor = .white
        countdownLabel.textAlignment = .center
        countdownLabel.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(countdownLabel)
    }

    func setupBirthdayWishTextField() {
        birthdayWishTextField = UITextField(frame: CGRect(x: 20, y: countdownLabel.frame.maxY + 20, width: self.view.frame.width - 40, height: 40))
        birthdayWishTextField.borderStyle = .roundedRect
        birthdayWishTextField.font = UIFont.systemFont(ofSize: 18)
        birthdayWishTextField.placeholder = "Enter your birthday wish"
        birthdayWishTextField.textAlignment = .center
        birthdayWishTextField.isHidden = true // Initially hidden
        view.addSubview(birthdayWishTextField)
    }

    func startTimer() {
        timer?.invalidate() // Invalidate any existing timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc func updateCountdown() {
        guard let targetDate = targetDate else {
            countdownLabel.text = "Set your birthday in settings"
            return
        }

        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: currentDate, to: targetDate)

        if let month = components.month, let day = components.day, let hour = components.hour, let minute = components.minute, let second = components.second {
            countdownLabel.text = "\(month) months, \(day) days, \(hour) hours, \(minute) minutes, \(second) seconds until your birthday!"
        }

        // Check if it's the user's birthday
        if calendar.isDateInToday(targetDate) {
            if let birthdayWish = UserDefaults.standard.string(forKey: "birthdayWish") {
                // If a wish has been saved, display it
                displayBirthdayWish(wish: birthdayWish)
            } else {
                // It's the user's birthday and no wish has been saved, so show the text field
                birthdayWishTextField.isHidden = false
            }
        } else {
            birthdayWishTextField.isHidden = true
        }
    }

    func displayBirthdayWish(wish: String) {
        if birthdayWishLabel == nil {
            birthdayWishLabel = UILabel(frame: CGRect(x: 20, y: countdownLabel.frame.maxY + 20, width: self.view.frame.width - 40, height: 100))
            birthdayWishLabel.font = UIFont.systemFont(ofSize: 24)
            birthdayWishLabel.textColor = .lightGray
            birthdayWishLabel.textAlignment = .center
            birthdayWishLabel.numberOfLines = 0
            view.addSubview(birthdayWishLabel)
        }

        birthdayWishLabel.text = wish
    }

    // Call this method when the user enters their birthday wish
    func saveBirthdayWish() {
        if let wish = birthdayWishTextField.text, !wish.isEmpty {
            UserDefaults.standard.set(wish, forKey: "birthdayWish")
            birthdayWishTextField.isHidden = true
            displayBirthdayWish(wish: wish)
        }
    }
    
    func findNextBirthdayLongitudeMatch(currentLongitude: Double, startFromDate date: Date) -> Date? {
        var currentDate = date
        let calendar = Calendar.current
        let oneDay = TimeInterval(24 * 60 * 60) // One day in seconds

        // Loop through each day starting from 'date'
        while true {
            // Assuming chartCake can calculate the longitude for a given date
            let transitSunLongitude = chartCake.transits.sun.longitude
            
            // Check if the longitude matches, with a small range to account for the sun's apparent motion
            if abs(transitSunLongitude - currentLongitude) < 0.1 { // You can adjust the range as needed
                return currentDate
            }
            
            // Increment the date by one day and continue
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            } else {
                // In case date addition fails, return nil
                return nil
            }
        }
    }

}
