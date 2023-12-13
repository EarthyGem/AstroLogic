//
//  AspectChartTableViewController.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/10/23.
//

import Foundation
import SwiftEphemeris
import CoreData
import UIKit
import CoreLocation
import MapKit
//import GoogleMaps



class AspectChartTableViewController: UIViewController,SuggestionsViewControllerDelegate, MKLocalSearchCompleterDelegate, UITextFieldDelegate  {

    var birthPlaceTimeZone: TimeZone? {
        didSet {
            datePicker.timeZone = birthPlaceTimeZone

        }
    }
    var selectedPlanetName: String?
    var selectedPlanet: Coordinate?
    var selectedDate: Date?
    var chart: Chart?
    var birthChartView: BirthChartView?
    var strongestPlanetSign: String?
    let locationManager = CLLocationManager()
    var transitDateLabel: String?
    var latitude: Double?
    var longitude: Double?
    let searchCompleter = MKLocalSearchCompleter()
    var suggestions: [MKLocalSearchCompletion] = []
     var searchRequest: MKLocalSearch.Request?

    var autocompleteSuggestions: [String] = []

    let houseCusps: [Cusp] = []

    var chartCake: ChartCake?
    let aboutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("About", for: .normal)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        button.addTarget(ViewController.self, action: #selector(showAboutViewController), for: .touchUpInside)
        return button
    }()



    lazy var eventTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Event"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.frame = CGRect(x: 50, y: 200, width: 300, height: 45)  // Adjust y to position it above dateTextField

        return textField
    }()

    lazy var eventPlaceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Capital of Country or State Affected"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.frame = CGRect(x: 50, y: 260, width: 300, height: 45)
        textField.addTarget(self, action: #selector(eventPlaceTextFieldEditingDidBegin), for: .editingDidBegin)
        return textField
    }()



    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date of Event"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.frame = CGRect(x: 50, y: 320, width: 300, height: 45)

        return textField
    }()





    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        formatter.timeZone = birthPlaceTimeZone ?? TimeZone.current

        return formatter
    }()

    lazy var getCycleChartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cycle Chart", for: .normal)
        button.addTarget(self, action: #selector(getCycleChartButtonTapped), for: .touchUpInside)

        // Set background color to lavender
        button.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1) // Light blue color


        // Make button corners rounded
        button.layer.cornerRadius = 8.0

        // Set the title color to the color you provided
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0.5, alpha: 1), for: .normal)

        // Set font to bold and adjust the size accordingly
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17) // Adjust size to fit your needs

        return button
    }()

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.timeZone = TimeZone.current // Use birthPlaceTimeZone

        // Set default date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.date(from: "1978/03/03") {
            datePicker.date = date
        }

        return datePicker
    }()

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        searchCompleter.queryFragment = text!
       return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self

        view.backgroundColor = UIColor(red: 236/255, green: 239/255, blue: 244/255, alpha: 1) // Light grey background for a clean look.

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        headerView.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1) // Light blue color

        // Create the title label
        // Create the title label
        let titleLabel = UILabel(frame: CGRect(x: 15, y: headerView.bounds.height - 50, width: self.view.bounds.width - 80, height: 40))  // adjust width to leave space for button
        titleLabel.text = "World Events ♇" // Replace "♇" with the Pluto glyph or symbol

        // Use a system font with a specific style
        titleLabel.font = UIFont(name: "Didot-Bold", size: 30) // You can replace "Didot-Bold" with any system font that fits your app's style and theme



        eventPlaceTextField.isUserInteractionEnabled = true

        // Create the myChartsButton
        let myChartsButton = UIButton(type: .custom)
        myChartsButton.setImage(UIImage(systemName: "folder.fill"), for: .normal)
        myChartsButton.tintColor =
        UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        // Adjust the frame
        let buttonX = titleLabel.frame.maxX + 10
        let buttonY = titleLabel.frame.minY
        myChartsButton.frame = CGRect(x: buttonX, y: buttonY, width: 40, height: 40)

        myChartsButton.addTarget(self, action: #selector(showMyCharts), for: .touchUpInside)
        headerView.addSubview(myChartsButton)  // Add the button to the headerView

        headerView.addSubview(titleLabel)

        // Add custom header to the main view BEFORE other subviews to ensure it's not overlapped
        self.view.addSubview(headerView)


        view.addSubview(eventPlaceTextField)

        view.addSubview(dateTextField)
        view.addSubview(eventPlaceTextField)


        view.addSubview(aboutButton)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        dateTextField.inputView = datePicker
        view.addSubview(eventTextField)

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDonePressed))
        toolBar.setItems([doneBtn], animated: true)
        dateTextField.inputAccessoryView = toolBar





        getCycleChartButton.frame = CGRect(x: 50, y: 440, width: 300, height: 45)
       // parseAndSaveData()
        view.addSubview(getCycleChartButton)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()



    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar again
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    @objc func showMyCharts() {
        let myChartsViewController = ChartsViewController() // Assuming it's a basic table view
        navigationController?.pushViewController(myChartsViewController, animated: true)
    }
    @objc func eventPlaceTextFieldEditingDidBegin() {
          let suggestionsVC = SuggestionsViewController()
          suggestionsVC.delegate = self
          present(suggestionsVC, animated: true, completion: nil)
      }


    func updateSearchBarTextColor(in view: UIView, to color: UIColor) {
        if let textField = view as? UITextField {
            textField.textColor = color
            return
        } else {
            for subview in view.subviews {
                updateSearchBarTextColor(in: subview, to: color)
            }
        }
    }


    func clearSearchBarText(in view: UIView) {
        if let searchBar = view as? UISearchBar {
            searchBar.text = ""
            return
        } else {
            for subview in view.subviews {
                clearSearchBarText(in: subview)
            }
        }
    }

        func suggestionSelected(_ suggestion: MKLocalSearchCompletion) {
            eventPlaceTextField.text = suggestion.title
        }




    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let suggestions = completer.results

        if let suggestionsVC = presentedViewController as? SuggestionsViewController {
            suggestionsVC.autocompleteSuggestions = suggestions
            suggestionsVC.tableView.reloadData()
        }
    }


    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle the error
        print("Search error: \(error.localizedDescription)")
    }

    func didSelectPlace(_ place: String) {
        // Handle the selected place, e.g., update the birthplace text field with 'place'
        eventTextField.text = place
    }





    @objc func eventPlaceTextFieldDidChange() {
        updateDatePickerTimeZone()

    }


    @objc func showAboutViewController() {
        let aboutVC = AboutViewController()
        navigationController?.pushViewController(aboutVC, animated: true)
    }


    func updateDatePickerTimeZone() {
        let geocoder = CLGeocoder()
        let addressString = eventPlaceTextField.text ?? ""

        geocoder.geocodeAddressString(addressString) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                // Handle error or default timezone
                return
            }

            let timestamp = Int(Date().timeIntervalSince1970)
            self.fetchTimeZone(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, timestamp: timestamp) { timeZone in
                DispatchQueue.main.async {
                    self.datePicker.timeZone = timeZone
                    self.birthPlaceTimeZone = timeZone
                }
            }
        }
    }


    @objc func getCycleChartButtonTapped() {
        // Disable the button to prevent multiple taps
        getCycleChartButton.isEnabled = false

        // Get the event location from the text field
        let location = eventPlaceTextField.text!

        // Geocode the event location to obtain latitude and longitude
        geocoding(location: location) { [weak self] latitude, longitude in
            guard let self = self else { return }

            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            // Fetch the timezone for the specified location
            getTimeZone(location: coordinate) { timeZone in
                guard let timeZone = timeZone else {
                    // Handle timezone fetching error
                    DispatchQueue.main.async {
                        self.getCycleChartButton.isEnabled = true
                    }
                    return
                }

                // Update the latitude and longitude values
                self.latitude = latitude
                self.longitude = longitude

                // Set the time zone of the date picker
                self.datePicker.timeZone = timeZone
                self.birthPlaceTimeZone = timeZone

                // Create a date using the date and time picked by the user
                let eventDate = self.datePicker.date

                // Extract the month and year from the event date
                let calendar = Calendar.current
                let year = calendar.component(.year, from: eventDate)
                let month = calendar.component(.month, from: eventDate)

                // Fetch news from the New York Times Archive for the same month and year as the event
                // Fetch news from the New York Times Archive for the same month and year as the event
                fetchNYTArchive(forMonth: month, year: year, apiKey: "Akt8PwlMxVONRPRTRsxyiqI4FGXdSpRo") { articles in
                    // Process NYT archive articles
                    guard let articles = articles else {
                        print("Failed to fetch articles from NYT Archive")
                        DispatchQueue.main.async {
                            self.getCycleChartButton.isEnabled = true
                        }
                        return
                    }

                    // Format the eventDate to match the format used in the NYT articles
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let formattedEventDate = dateFormatter.string(from: eventDate)

                    // Filter and print articles that match the eventDate
                    for article in articles where article.pub_date.starts(with: formattedEventDate) {
                        print(article.headline,article.abstract,article.pub_date)
                    }

                    // Enable the button after processing
                    DispatchQueue.main.async {
                        self.getCycleChartButton.isEnabled = true
                    }
                }

            }
        } failure: { msg in
            // Handle geocoding failure
            DispatchQueue.main.async {
                self.getCycleChartButton.isEnabled = true
            }
        }
    }

    func getCountryFromCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error during reverse geocoding: \(error)")
                completion(nil)
                return
            }
            if let country = placemarks?.first?.country {
                completion(country)
            } else {
                completion(nil)
            }
        }
    }


    func resetViewController() {
        // Clear input fields
        eventPlaceTextField.text = ""
        datePicker.setDate(Date(), animated: true)

        // Get the text from the eventPlaceTextField
        if let birthPlace = eventPlaceTextField.text {
            // Use the text to determine the time zone identifier
            let timeZone = TimeZone(identifier: birthPlace)

            // Set the timeZone property of the UIDatePicker


            func resetViewController() {
                eventPlaceTextField.text = ""
                eventTextField.text = ""
                datePicker.setDate(Date(), animated: true)


                // Reset the time zone of the UIDatePicker based on the input in the eventPlaceTextField
                if let birthPlace = eventPlaceTextField.text,
                   let timeZone = TimeZone(identifier: birthPlace) {

                }

                // Reset any other components to their initial state
                // ...
            }

        }
    }


    func updateTimeZoneForNewLocation(latitude: Double, longitude: Double) {
        let currentTimestamp = Int(Date().timeIntervalSince1970)
        fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: currentTimestamp) { newTimeZone in
            self.birthPlaceTimeZone = newTimeZone

            // Optionally: Update the displayed date and time in the date and time picker fields to reflect the new timezone
            self.datePickerValueChanged(self.datePicker)

        }
    }




    func fetchTimeZone(latitude: Double, longitude: Double, timestamp: Int, completion: @escaping (TimeZone?) -> Void) {
        let API_KEY = "AIzaSyA5sA9Mz9AOMdRoHy4ex035V3xsJxSJU_8" // Note: Never hard-code API keys in production apps. Use environment variables or secure storage.
        let url = URL(string: "https://maps.googleapis.com/maps/api/timezone/json?location=\(latitude),\(longitude)&timestamp=\(timestamp)&key=\(API_KEY)")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                self.birthPlaceTimeZone = nil
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let timeZoneId = json["timeZoneId"] as? String {
                        self.birthPlaceTimeZone = TimeZone(identifier: timeZoneId)
                        completion(self.birthPlaceTimeZone)
                    } else {
                        self.birthPlaceTimeZone = nil
                        completion(nil)
                    }
                }
            } catch {
                self.birthPlaceTimeZone = nil
                completion(nil)
            }
        }
        task.resume()
    }


    func getStrongestPlanet(from scores: [CelestialObject: Double]) -> CelestialObject {
        let sorted = scores.sorted { $0.value > $1.value }
        let strongestPlanet = sorted.first!.key

        return strongestPlanet
    }

    func getPlanetsSortedByStrength(from scores: [CelestialObject: Double]) -> [CelestialObject] {
        let sortedPlanets = scores.sorted { $0.value > $1.value }.map { $0.key }
        return sortedPlanets
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        var selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        dateFormatter.timeZone = birthPlaceTimeZone // Use the birthPlaceTimeZone here
        let dateString = dateFormatter.string(from: selectedDate)
        dateTextField.text = dateString
    }

    @objc func datePickerDonePressed() {
        // Set the time zone for the date picker

        dateTextField.resignFirstResponder()
    }

    func createDate(day: Int, month: Int, year: Int) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        return calendar.date(from: dateComponents)
    }



    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil
        ) }



}

extension AspectChartTableViewController: CLLocationManagerDelegate {


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


    func fetchAndPrintCharts() {
        // Get the Core Data managed context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Unable to get AppDelegate")
            return
        }

        let context = appDelegate.persistentContainer.viewContext

        // Create a fetch request for the ChartEntity
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ChartEntity")

        do {
            // Execute the fetch request
            let charts = try context.fetch(fetchRequest)

            // Check if we got any results
            if charts.isEmpty {
                print("No charts saved in Core Data.")
            } else {
                for chart in charts {
                    if let name = chart.value(forKey: "name") as? String,
                       let birthDate = chart.value(forKey: "birthDate") as? Date,
                       let latitude = chart.value(forKey: "latitude") as? Double,
                       let longitude = chart.value(forKey: "longitude") as? Double,
                      let birthPlace = chart.value(forKey: "birthPlace") as? String,
                        let strongestPlanet = chart.value(forKey: "strongestPlanet") as? String
                    {

                    //    print("Name: \(name), BirthDate: \(birthDate), Latitude: \(latitude), Longitude: \(longitude), BirthPlace: \(birthPlace)")
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }


    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }



    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")


    }


    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = sender.timeZone
        dateFormatter.dateFormat = "h:mm a" // Adjust this to your desired format

    }

    func combinedDateAndTime() -> Date? {
        let calendar = Calendar.current


        datePicker.timeZone = birthPlaceTimeZone


        // Extract date components using birthPlaceTimeZone
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: datePicker.date)

        // Extract time components using the same timezone (birthPlaceTimeZone)

        // Combine date and time components
        dateComponents.timeZone = birthPlaceTimeZone


        print("Combined date and time components: \(dateComponents)")

        return calendar.date(from: dateComponents)
    }

}