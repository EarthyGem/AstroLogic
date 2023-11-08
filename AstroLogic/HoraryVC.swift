//
//  HoraryVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/7/23.
//

import Foundation
import UIKit
import CoreLocation
import SwiftEphemeris



class HoraryAstrologyViewController: UIViewController, CLLocationManagerDelegate, UITextViewDelegate {
    
    // UI Elements
    private let questionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let askButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ask", for: .normal)
        button.addTarget(self, action: #selector(askButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // Location manager to get the current location
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureLocationManager()
    }
    
    private func setupViews() {
        // Add subviews
        view.addSubview(questionTextView)
        view.addSubview(askButton)
        questionTextView.delegate = self  // Set the delegate for UITextView
        
        // Set translatesAutoresizingMaskIntoConstraints to false to use Auto Layout
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        askButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Activate constraints
        NSLayoutConstraint.activate([
            questionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionTextView.heightAnchor.constraint(equalToConstant: 80), // Adjust the height as needed
            
            askButton.topAnchor.constraint(equalTo: questionTextView.bottomAnchor, constant: 20),
            askButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc private func askButtonTapped() {
        questionTextView.resignFirstResponder() // Dismiss the keyboard
        locationManager.requestLocation() // Request current location
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first {
            createChart(for: currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    private func createChart(for location: CLLocation) {
        let currentDate = Date()
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // Create a ChartCake for the current time and place
        if let chartCake = ChartCake(birthDate: currentDate, latitude: latitude, longitude: longitude) {
            // Do something with the generated chart, e.g., present it in a new view controller or alert the user
            print("Chart created for the question: '\(questionTextView.text ?? "")'")
        } else {
            // Handle the error in chart creation
            print("Failed to generate chart")
        }
    }
    
    // UITextViewDelegate method
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type your question here" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type your question here"
            textView.textColor = .lightGray
        }
    }
}
