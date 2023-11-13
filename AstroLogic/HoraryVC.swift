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
import CoreData



class HoraryAstrologyViewController: UIViewController, CLLocationManagerDelegate, UITextViewDelegate {
    var latitude: Double?
    var longitude: Double?
    var timeZone: TimeZone?
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

           // ... existing setup code ...
           configureLocationManager()
       }

       private func configureLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestWhenInUseAuthorization()
       }

  
       // CLLocationManagerDelegate methods
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let currentLocation = locations.first {
                     let timeZone = TimeZone.current // or use currentLocation to fetch timezone
                     // Now use currentLocation and timeZone as needed
               createChart(for: currentLocation, at: Date(), with: timeZone)
                 }
       }

       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Failed to find user's location: \(error.localizedDescription)")
       }

    private func createChart(for location: CLLocation, at date: Date, with timeZone: TimeZone) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // Assuming ChartCake initialization is correct
        if let chartCake = ChartCake(birthDate: date, latitude: latitude, longitude: longitude) {
            // Handle the chart as needed

            // Create and add BirthChartView
            let screenWidth = UIScreen.main.bounds.width
            let birthChartView = BirthChartView(frame: CGRect(x: 0, y: 250, width: screenWidth, height: screenWidth), chartCake: chartCake)
            view.addSubview(birthChartView)
        } else {
            print("Failed to generate chart")
        }
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
    
    @objc private func askButtonTapped() {
        questionTextView.resignFirstResponder() // Dismiss the keyboard
        locationManager.requestLocation() // Request current location
    

        askButton.isEnabled = false
      
        
        
        
        geocoding(location: locationManager.description) { latitude, longitude in
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            getTimeZone(location: coordinate) { [self] timeZone in
                guard let timeZone = timeZone else {
                    DispatchQueue.main.async {
                        self.askButton.isEnabled = true
                    }
                    return
                }
                
                
                
                // Update the latitude and longitude values
                self.latitude = latitude
                self.longitude = longitude
                
                // Set the time zone of the date picker and time picker
                self.timeZone = timeZone
      
       
                
                
                let chartDate = Date()
                chart = Chart(date: Date(), latitude: latitude, longitude: longitude, houseSystem: .placidus)
                var chartCake: () = createChart(for:locationManager.location!, at: Date(), with: timeZone)
                
                guard let chart = chart else {
                    assert(false, "There is no chart")
                    return
                }
                
                
                let scores = chart.getTotalPowerScoresForPlanets()
                let strongestPlanet = getStrongestPlanet(from: scores)
                
                
                saveChart(name: questionTextView.text, birthDate: Date(), latitude: latitude, longitude: longitude, birthPlace: locationManager.location.debugDescription, strongestPlanet: strongestPlanet.keyName)
                
                
                
           
                let tuple = chart.getTotalHarmonyDiscordScoresForPlanets()
                let mostDiscordantPlanet = getMostDiscordantPlanet(from: tuple)
                let mostHarmoniousPlanet = getMostHarmoniousPlanet(from: tuple)
        
    
                
                
                questionTextView.text = ""
                questionTextView.text = ""
     
                
                // ... existing code ...
                DispatchQueue.main.async {
                    self.askButton.isEnabled = true
                }
            }
        } failure: { msg in
            // Also enable the button when there's a failure in geocoding
            DispatchQueue.main.async {
                self.askButton.isEnabled = true
            }
        }
    }
    func getStrongestPlanet(from scores: [CelestialObject: Double]) -> CelestialObject {
        let sorted = scores.sorted { $0.value > $1.value }
        let strongestPlanet = sorted.first!.key

        return strongestPlanet
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


        func saveChart(name: String, birthDate: Date, latitude: Double, longitude: Double, birthPlace: String, strongestPlanet: String) {
            // Get the Core Data managed context
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                print("Unable to get AppDelegate")
                return
            }

            let context = appDelegate.persistentContainer.viewContext

            // Ensure the context is not nil and is ready to use




            // Check whether "ChartEntity" is the correct entity name in your .xcdatamodeld file.
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "ChartEntity", in: context) else {
                print("Failed to get the entity description for 'ChartEntity'")
                return
            }

            let newChart = NSManagedObject(entity: entityDescription, insertInto: context)
            newChart.setValue(name, forKey: "name")
            newChart.setValue(birthDate, forKey: "birthDate")
            newChart.setValue(latitude, forKey: "latitude")
            newChart.setValue(longitude, forKey: "longitude")
            newChart.setValue(birthPlace, forKey: "birthPlace")
            newChart.setValue(strongestPlanet, forKey: "strongestPlanet")
            // Try saving the context
            do {
                try context.save()
            } catch {
                print("Failed to save chart: \(error.localizedDescription)")
            }
        }

   
}
