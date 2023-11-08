//
//  WeatherVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/7/23.
//

import Foundation
import UIKit
import SwiftEphemeris
import CoreLocation
import MapKit
import WeatherKit


class WeatherForecastViewController: UIViewController, UITextFieldDelegate, SuggestionsViewControllerDelegate, MKMapViewDelegate {

    // Assuming you have a ChartCake struct or class
    var chartCake: ChartCake?
    var forecasts: [String] = []
    let temperatureLabel = UILabel()
     let airQualityLabel = UILabel()
     let weatherConditionLabel = UILabel()

     // WeatherService instance
     let weatherService = WeatherService()
    // UI Elements
    lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Tap to select location"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()

    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Date"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.delegate = self  // Make sure to set the delegate
        return textField
    }()


    let forecastDatePicker = UIDatePicker()

    let forecastButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Forecast", for: .normal)
        button.addTarget(self, action: #selector(getForecastButtonTapped), for: .touchUpInside)
        return button
    }()

    let mapView: MKMapView = {
          let mapView = MKMapView()
          mapView.mapType = .standard // Choose the map type you prefer (.standard, .satellite, .hybrid)
          return mapView
      }()
    // Inside WeatherForecastViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()

        setupWeatherInfoViews()
    }

    private func setupViews() {

        view.addSubview(locationTextField)
           view.addSubview(dateTextField)
           view.addSubview(forecastButton)
           view.addSubview(mapView)
           view.addSubview(forecastDatePicker)

               dateTextField.translatesAutoresizingMaskIntoConstraints = false

              mapView.translatesAutoresizingMaskIntoConstraints = false
              mapView.delegate = self
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        forecastButton.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
             locationTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             locationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             locationTextField.heightAnchor.constraint(equalToConstant: 40),

             dateTextField.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 20),
             dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             dateTextField.widthAnchor.constraint(equalToConstant: 200),
             dateTextField.heightAnchor.constraint(equalToConstant: 40),

             forecastButton.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20),
             forecastButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

             mapView.topAnchor.constraint(equalTo: forecastButton.bottomAnchor, constant: 20),
             mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             mapView.heightAnchor.constraint(equalToConstant: 300) // Adjust the height as needed
         ])

         // Configure the date picker
         configureDatePicker()
     }
    private func setupWeatherInfoViews() {
            // Configure labels and add them to the view
            temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
            airQualityLabel.translatesAutoresizingMaskIntoConstraints = false
            weatherConditionLabel.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(temperatureLabel)
            view.addSubview(airQualityLabel)
            view.addSubview(weatherConditionLabel)

            // Define the labels' appearance
            temperatureLabel.font = UIFont.systemFont(ofSize: 16)
        temperatureLabel.textColor = .orange
            airQualityLabel.font = UIFont.systemFont(ofSize: 16)
        airQualityLabel.textColor = .magenta

        weatherConditionLabel.font = UIFont.systemFont(ofSize: 16)
        weatherConditionLabel.textColor = .systemGreen
            // Constraints for the weather information labels
            NSLayoutConstraint.activate([
                temperatureLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
                temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                airQualityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
                airQualityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                airQualityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                weatherConditionLabel.topAnchor.constraint(equalTo: airQualityLabel.bottomAnchor, constant: 10),
                weatherConditionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                weatherConditionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])
        }


    private func configureDatePicker() {
         // Instantiate a UIDatePicker
         let datePicker = UIDatePicker()
         datePicker.datePickerMode = .date
         datePicker.preferredDatePickerStyle = .wheels  // Use `.wheels` for a spinning-wheel style picker
         datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)

         // Assign the datePicker to the dateTextField's inputView
         dateTextField.inputView = datePicker

         // Add a toolbar with a Done button
         let toolbar = UIToolbar()
         toolbar.sizeToFit()
         let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
         toolbar.setItems([doneButton], animated: false)
         dateTextField.inputAccessoryView = toolbar
     }

    func updateMapLocation(_ coordinate: CLLocationCoordinate2D) {
          let regionRadius: CLLocationDistance = 1000000 // Define the region radius to display
          let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
          mapView.setRegion(region, animated: true)

          // Optionally, you can add an annotation to the map
          let annotation = MKPointAnnotation()
          annotation.coordinate = coordinate
          mapView.addAnnotation(annotation)
      }

       // UITextFieldDelegate method
    // UITextFieldDelegate method
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == locationTextField {
            let suggestionsVC = SuggestionsViewController()
            suggestionsVC.delegate = self
            present(suggestionsVC, animated: true, completion: nil)
            return false // Return false to prevent the keyboard from showing
        }
        return true
    }

    @objc private func datePickerChanged(_ sender: UIDatePicker) {
            // Format the date and set it as the text for dateTextField
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateTextField.text = dateFormatter.string(from: sender.date)
        }

        @objc private func dismissKeyboard() {
            view.endEditing(true) // This will dismiss the date picker
        }


    // MARK: - SuggestionsViewControllerDelegate
    func suggestionSelected(_ suggestion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] (response, error) in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
                print("Location not found.")
                return
            }

            self?.updateMapLocation(coordinate)
            self?.locationTextField.text = suggestion.title

            // Fetch the weather information for the selected location
            if let coordinate = response?.mapItems.first?.placemark.coordinate {
                Task {
                    await self?.fetchWeather(for: coordinate)
                }
                // Dismiss the SuggestionsViewController if it's presented
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }


    func fetchWeather(for coordinate: CLLocationCoordinate2D) async {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        do {
            let weather = try await weatherService.weather(for: location)
            DispatchQueue.main.async { [weak self] in
                self?.temperatureLabel.text = "Temperature: \(weather.currentWeather.temperature)"
                self?.airQualityLabel.text = "Air Movement: \(weather.currentWeather.wind)"
                self?.weatherConditionLabel.text = "Conditions: \(weather.currentWeather.condition)"
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func generateChart(for coordinate: CLLocationCoordinate2D) {
           // Logic to generate chart using coordinate
           // Replace with actual date you want to forecast for
           let chartDate = Date()

           // Assuming ChartCake has an initializer that takes date and location parameters
           if let weatherChart = ChartCake(birthDate: chartDate, latitude: coordinate.latitude, longitude: coordinate.longitude) {
               // Do something with the generated chart
               self.chartCake = weatherChart
               print("Weather chart generated for \(coordinate)")
           } else {
               // Handle the error in chart generation
               print("Failed to generate weather chart for \(coordinate)")
           }
       }

       @objc private func getForecastButtonTapped() {
           // Ensure a location has been selected
           guard let chartCake = chartCake else {
               print("Please select a location first.")
               return
           }
           // Call the method to display the chart using the chartCake instance
       }
   }
   extension WeatherForecastViewController: UITableViewDelegate, UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // Return the count of your forecasts array
           return forecasts.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCellIdentifier", for: indexPath)
           let forecast = forecasts[indexPath.row]
           // Configure your cell with data from the forecast
           // Example:
           // cell.textLabel?.text = forecast.summary
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let forecast = forecasts[indexPath.row]
           // Do something with the selected forecast
           // Example:
           // print("Selected forecast for \(forecast.date)")
           tableView.deselectRow(at: indexPath, animated: true)
       }


       // Function to find when the Sun last entered a cardinal sign before the selected date
       func fetchTemperatureChart(for selectedDate: Date, at coordinate: CLLocationCoordinate2D) -> ChartCake? {
           var currentDate = selectedDate
           let timeStep: TimeInterval = -60 * 60 // Go backward in time by 1 hour
           var previousSunPosition = SunPosition(sign: Zodiac(rawValue: (chartCake?.natal.sun.sign)!.rawValue) ?? .aries, degree: (chartCake?.natal.sun.longitude)!) // Replace with actual method to get Sun position

           while true {
               currentDate = currentDate.addingTimeInterval(timeStep)
               let currentSunPosition = SunPosition(sign: Zodiac(rawValue: (chartCake?.natal.sun.sign)!.rawValue) ?? .aries, degree: (chartCake?.natal.sun.longitude)!) // Replace with actual method to get Sun position for currentDate

               // Check if the Sun has entered a cardinal sign by comparing the current and previous positions
               if currentSunPosition.isEnteringCardinalSign(from: previousSunPosition) {
                   let temperatureChart = ChartCake(birthDate: currentDate, latitude: coordinate.latitude, longitude: coordinate.longitude)
                   return temperatureChart
               }

               if currentDate.timeIntervalSince1970 <= selectedDate.timeIntervalSince1970 - (365 * 24 * 60 * 60) {
                   // Break the loop if we've gone back more than a year without finding an ingress
                   break
               }

               previousSunPosition = currentSunPosition
           }

           return nil
       }

       // Function to find when Mercury last entered Taurus before the selected date
       func fetchAirMovementChart(for selectedDate: Date, at coordinate: CLLocationCoordinate2D) -> ChartCake? {
           var currentDate = selectedDate
           let timeStep: TimeInterval = -60 * 60 // Go backward in time by 1 hour
           var previousMercuryPosition = MercuryPosition(sign: Zodiac(rawValue: (chartCake?.natal.mercury.sign)!.rawValue) ?? .aries, degree: (chartCake?.natal.mercury.longitude)!) // Replace with actual method to get Mercury position

           while true {
               currentDate = currentDate.addingTimeInterval(timeStep)
               let currentMercuryPosition = MercuryPosition(sign: Zodiac(rawValue: (chartCake?.natal.mercury.sign)!.rawValue) ?? .aries, degree: (chartCake?.natal.mercury.longitude)!) // Replace with actual method to get Mercury position for currentDate

               // Check if Mercury has entered Taurus by comparing the current and previous positions
               if currentMercuryPosition.isEnteringSign(.taurus, from: previousMercuryPosition) {
                   let airMovementChart = ChartCake(birthDate: currentDate, latitude: coordinate.latitude, longitude: coordinate.longitude)
                   return airMovementChart
               }

               if currentDate.timeIntervalSince1970 <= selectedDate.timeIntervalSince1970 - (365 * 24 * 60 * 60) {
                   // Break the loop if we've gone back more than a year without finding an ingress
                   break
               }

               previousMercuryPosition = currentMercuryPosition
           }

           return nil
       }

       // Function to find the New Moon before the selected date
       // Assuming you have an ephemeris library that can provide Sun and Moon positions

       // This method should find the last New Moon before the selected date
       func findLastNewMoon(before selectedDate: Date, for coordinate: CLLocationCoordinate2D, with chartCake: ChartCake) -> Date? {
           var currentDate = selectedDate
           let timeStep: TimeInterval = -60 * 60 * 24 // Step back one day at a time
           var sunPositionLongitude = chartCake.natal.sun.longitude
           var moonPositionLongitude = chartCake.natal.moon.longitude

           // Loop until we find a New Moon or exceed the search bounds
           while true {
               // Calculate the difference in longitude between the Sun and the Moon
               let longitudeDifference = getLongitudeDifference(sunPositionLongitude, moonPositionLongitude)

               // If the Sun and Moon are at the same longitude, we found a New Moon
               if abs(longitudeDifference) < 1 {
                   return currentDate
               }

               // Step back one day and repeat
               currentDate = currentDate.addingTimeInterval(timeStep)
               // Assuming you have a method to update the positions for the new currentDate
               sunPositionLongitude = chartCake.natal.sun.longitude  // Update this value based on the new currentDate
               moonPositionLongitude = chartCake.natal.moon.longitude  // Update this value based on the new currentDate

               // Safety check to avoid infinite loop
               if -currentDate.timeIntervalSince(selectedDate) > 29.5 * 24 * 60 * 60 {
                   // If we've gone back more than a lunar cycle without finding a New Moon, stop the search
                   return nil
               }
           }
       }
       func getLongitudeDifference(_ sunLongitude: Double, _ moonLongitude: Double) -> Double {
           // Normalize the longitudes between 0 and 360
           let normalizedSunLongitude = sunLongitude.truncatingRemainder(dividingBy: 360)
           let normalizedMoonLongitude = moonLongitude.truncatingRemainder(dividingBy: 360)

           // Calculate the difference in longitude
           let difference = normalizedMoonLongitude - normalizedSunLongitude

           // Adjust for wrapping around the zodiac
           return (difference < 0) ? (difference + 360) : (difference > 360) ? (difference - 360) : difference
       }

       // Use `findLastNewMoon` in your `fetchMoistureChart` function
       func fetchMoistureChart(for selectedDate: Date, at coordinate: CLLocationCoordinate2D) -> ChartCake? {
           if let newMoonDate = findLastNewMoon(before: selectedDate, for: coordinate, with: chartCake!) {
               let moistureChart = ChartCake(birthDate: newMoonDate, latitude: coordinate.latitude, longitude: coordinate.longitude)
               return moistureChart
           } else {
               print("Failed to find the last New Moon before the selected date.")
               return nil
           }
       }

       struct SunPosition {
           var sign: Zodiac
           var degree: Double

           // Implement this method to determine if the Sun is entering a cardinal sign
           func isEnteringCardinalSign(from previousPosition: SunPosition) -> Bool {
               // Logic to determine if the Sun has entered a cardinal sign
               return false
           }
       }

       struct MercuryPosition {
           var sign: Zodiac
           var degree: Double

           // Implement this method to determine if Mercury is entering a given sign
           func isEnteringSign(_ sign: Zodiac, from previousPosition: MercuryPosition) -> Bool {
               // Logic to determine if Mercury has entered the given sign
               return false
           }
       }
   }

