import SwiftEphemeris
import UIKit
import CoreLocation
import GooglePlaces
//import GoogleMaps



class ViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    var selectedPlace: GMSPlace?
    var birthPlaceTimeZone: TimeZone? {
        didSet {
            datePicker.timeZone = birthPlaceTimeZone
            timePicker.timeZone = birthPlaceTimeZone
        }
    }

    var selectedDate: Date?
    var chart: Chart?
    var birthChartView: BirthChartView?
    var strongestPlanetSign: String?
    let locationManager = CLLocationManager()
    var harmonyDiscordScores: [String: (harmony: Double, discord: Double, difference: Double)]?
    //   var aspects: [AstroAspect?] = []
    var latitude: Double?
    var longitude: Double?
    let planetsInHouses: [Int: [String]] = [:]
    var signScore: [String : Double] = [:]
    var houseScores: [Int : Double] = [:]
    let houseCusps: [Cusp] = []
    var ascDeclination: Double?
    var mcDeclination: Double?
    var scores: [String : Double] = [:]
    var chartCake: ChartCake?

    let aboutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("About", for: .normal)
        button.addTarget(ViewController.self, action: #selector(showAboutViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var birthPlaceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Place of Birth"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        textField.frame = CGRect(x: 25, y: 200, width: 250, height: 35)
        textField.addTarget(self, action: #selector(birthPlaceTextFieldEditingDidBegin), for: .editingDidBegin)
        return textField
    }()
    
    var autocompleteController: GMSAutocompleteViewController? // Add this line
    

    

    
    
    lazy var birthTimeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Time of Birth"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        textField.frame = CGRect(x: 25, y: 250, width: 250, height: 35)
        return textField
    }()
    
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        formatter.timeZone = birthPlaceTimeZone ?? TimeZone.current
        return formatter
    }()

    lazy var getPowerPlanetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Power Planet", for: .normal)
        button.addTarget(self, action: #selector(getPowerPlanetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var getChartButton: UIButton = {
        let chartButton = UIButton(type: .system)
        chartButton.setTitle("Get Chart", for: .normal)
        chartButton.addTarget(self, action: #selector(getChartButtonTapped), for: .touchUpInside)
        return chartButton
        
    }()
    
    lazy var scoresText: UILabel = {
        let scoresText = UILabel()
        scoresText.textColor = .white
        scoresText.numberOfLines = 0
        
        return scoresText
        
    }()
    
    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date of Birth"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        textField.frame = CGRect(x: 25, y: 150, width: 250, height: 35)

        return textField
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


    lazy var timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.timeZone = TimeZone.current // Use birthPlaceTimeZone
        datePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        datePicker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)

        // Set default time to noon
        let calendar = Calendar.current
        if let noonDate = calendar.date(bySettingHour: 14, minute: 51, second: 0, of: Date()) {
            datePicker.date = noonDate
        }

        return datePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(getChartButton)
        view.backgroundColor = .black
        view.addSubview(birthPlaceTextField)
        makeAutocompleteViewController()
        view.addSubview(dateTextField)
        view.addSubview(birthPlaceTextField)
        birthPlaceTextField.addTarget(self, action: #selector(birthPlaceTextFieldDidChange), for: .editingChanged)
        view.addSubview(birthTimeTextField)
        birthTimeTextField.inputView = timePicker
        view.addSubview(aboutButton)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        dateTextField.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDonePressed))
        toolBar.setItems([doneBtn], animated: true)
        dateTextField.inputAccessoryView = toolBar
        
        let timePickerToolBar = UIToolbar()
        timePickerToolBar.sizeToFit()
        let timePickerDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timePickerDonePressed))
        timePickerToolBar.setItems([timePickerDoneBtn], animated: true)
        birthTimeTextField.inputAccessoryView = timePickerToolBar
        
        view.addSubview(getPowerPlanetButton)
        getPowerPlanetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getPowerPlanetButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10), // Add a small space between buttons
            getPowerPlanetButton.topAnchor.constraint(equalTo: birthPlaceTextField.bottomAnchor, constant: 55)
        ])
        
        getChartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getChartButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10), // Add a small space between buttons
            getChartButton.topAnchor.constraint(equalTo: birthPlaceTextField.bottomAnchor, constant: 55)
        ])
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        
    }
    
    @objc func birthPlaceTextFieldEditingDidBegin() {
        presentAutocompleteViewController()
    }

    func makeAutocompleteViewController() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.modalPresentationStyle = .popover
        autocompleteController.modalTransitionStyle = .crossDissolve
        
        let popover = autocompleteController.popoverPresentationController
        popover?.sourceView = birthPlaceTextField
        popover?.sourceRect = birthPlaceTextField.bounds
        
        // Customize the autocomplete filter and place fields if needed
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: (UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.addressComponents.rawValue)))
        autocompleteController.placeFields = fields
        
        self.autocompleteController = autocompleteController
    }

    func presentAutocompleteViewController() {
        if let autocompleteController = autocompleteController {
            present(autocompleteController, animated: true, completion: nil)
        }
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        var city: String?
        var state: String?
        var country: String?
        if let addressComponents = place.addressComponents {
            for component in addressComponents {
                switch component.types[0] {
                case kGMSPlaceTypeLocality:
                    city = component.name
                case kGMSPlaceTypeAdministrativeAreaLevel1:
                    state = component.shortName
                case kGMSPlaceTypeCountry:
                    country = component.shortName
                default:
                    break
                }
            }
        }

        // Combine city, state, and country into a single string.
        var locationString = ""
        if let city = city {
            locationString += city
        }
        if let state = state {
            if !locationString.isEmpty {
                locationString += ", "
            }
            locationString += state
        }
        if let country = country {
            if !locationString.isEmpty {
                locationString += ", "
            }
            locationString += country
        }

        // Set the location string to the text field.
        birthPlaceTextField.text = locationString

        if let address = place.formattedAddress {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) { [self] placemarks, error in
                guard let placemark = placemarks?.first,
                      let location = placemark.location else {
                    print("Geocoding error: \(error?.localizedDescription ?? "unknown error")")
                    return
                }

                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude

                // Convert the current date to Unix timestamp
                let timestamp = Int(Date().timeIntervalSince1970)

                // Fetch the timezone for the selected place
                fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: timestamp) { timeZone in
                    DispatchQueue.main.async {
                        self.birthPlaceTimeZone = timeZone
                        self.timePicker.timeZone = timeZone
                    }
                }
            }
        }

        dismiss(animated: true, completion: nil)
    }


    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Autocomplete error: \(error.localizedDescription)")
        dismiss(animated: true, completion: nil)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func birthPlaceTextFieldDidChange() {
        updateDatePickerTimeZone()
    }

    
    @objc func showAboutViewController() {
        let aboutVC = AboutViewController()
        navigationController?.pushViewController(aboutVC, animated: true)
    }
    

    func updateDatePickerTimeZone() {
        let geocoder = CLGeocoder()
        let addressString = birthPlaceTextField.text ?? ""

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

    //    @objc func birthPlaceTextFieldDidChange() {
    //           updateDatePickerTimeZone()
    //       }
    //




    @objc func getChartButtonTapped() {

        
        
        // Initialize and push the ChartViewController
        let chartVC = ChartViewController()
        chartVC.chart = chart
        chartVC.houseScores = chart!.calculateHouseStrengths()
        chartVC.chartCake = chartCake
        //   chartVC.harmonyDiscordScores = getScoresAndDifferenceForPlanets(chart: self.chart!)
        chartVC.scores2 = getTotalPowerScoresForPlanets(chart: chart!)
        chartVC.scores = getTotalPowerScoresForPlanets2(chart: chart!)
        self.navigationController?.pushViewController(chartVC, animated: true)
        
        //        birthChartView = BirthChartView(frame: view.bounds, chartCake: chartCake!)
    }

    @objc func getPowerPlanetButtonTapped() {

        getPowerPlanetButton.isEnabled = false
        let location = birthPlaceTextField.text!
        getPowerPlanetButton.isEnabled = false

        geocoding(location: location) { latitude, longitude in
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            getTimeZone(location: coordinate) { [self] timeZone in
                guard let timeZone = timeZone else {
                    DispatchQueue.main.async {
                        self.getPowerPlanetButton.isEnabled = true
                    }
                    return
                }

                // Update the latitude and longitude values
                self.latitude = latitude
                self.longitude = longitude

                // Set the time zone of the date picker and time picker
                self.timePicker.timeZone = timeZone
                self.datePicker.timeZone = timeZone
                self.birthPlaceTimeZone = timeZone

                let chartDate = self.combinedDateAndTime()!
                self.chart = Chart(date: chartDate, latitude: latitude, longitude: longitude, houseSystem: .placidus)
                self.chartCake = ChartCake(birthDate: chartDate, latitude: latitude, longitude: longitude)
                guard let chart = self.chart else {
                    assert(false, "There is no chart")
                    return
                }

                let scores = self.chart!.getTotalPowerScoresForPlanets()
                let strongestPlanet = self.getStrongestPlanet(from: scores)

                // let signScore = self.chart.calculateTotalSignScore()
                // let houseStrengths = self.chart.calculatePlanetInHouseScores()
                // let houseScores = self.chart.calculateHouseStrengths()

                let tuple = chart.getTotalHarmonyDiscordScoresForPlanets()
                let mostDiscordantPlanet = getMostDiscordantPlanet(from: tuple)
                let mostHarmoniousPlanet = getMostHarmoniousPlanet(from: tuple)

                if strongestPlanet == Planet.sun.celestialObject {
                    strongestPlanetSign = chart.sun.sign.keyName
                } else if strongestPlanet == Planet.moon.celestialObject {
                    strongestPlanetSign = chart.moon.sign.keyName
                } else if strongestPlanet == Planet.mercury.celestialObject {
                    strongestPlanetSign = chart.mercury.sign.keyName
                } else if strongestPlanet == Planet.venus.celestialObject {
                    strongestPlanetSign = chart.venus.sign.keyName
                } else if strongestPlanet == Planet.mars.celestialObject {
                    strongestPlanetSign = chart.mars.sign.keyName
                } else if strongestPlanet == Planet.jupiter.celestialObject {
                    strongestPlanetSign = chart.jupiter.sign.keyName
                } else if strongestPlanet == Planet.saturn.celestialObject {
                    strongestPlanetSign = chart.saturn.sign.keyName
                } else if strongestPlanet == Planet.uranus.celestialObject {
                    strongestPlanetSign = chart.uranus.sign.keyName
                } else if strongestPlanet == Planet.neptune.celestialObject {
                    strongestPlanetSign = chart.neptune.sign.keyName
                } else if strongestPlanet == Planet.pluto.celestialObject {
                    strongestPlanetSign = chart.pluto.sign.keyName
                } else if strongestPlanet == LunarNode.meanSouthNode.celestialObject {
                    strongestPlanetSign = chart.southNode.sign.keyName
                }

                let sentence = generateAstroSentence(strongestPlanet: strongestPlanet.keyName,
                                                     strongestPlanetSign: strongestPlanetSign!,
                                                     sunSign: chart.sun.sign.keyName,
                                                     moonSign: chart.moon.sign.keyName,
                                                     risingSign: chart.houseCusps.ascendent.sign.keyName)

                // Initialize and push the StrongestPlanetViewController
                let strongestPlanetVC = StrongestPlanetViewController()
                strongestPlanetVC.chartCake = chartCake
                strongestPlanetVC.chart = chart
                strongestPlanetVC.strongestPlanet = getStrongestPlanet(from: scores).keyName
                //
                strongestPlanetVC.mostDiscordantPlanet = mostDiscordantPlanet.keyName
                strongestPlanetVC.mostHarmoniousPlanet = mostHarmoniousPlanet.keyName
                strongestPlanetVC.sentenceText = sentence
                self.navigationController?.pushViewController(strongestPlanetVC, animated: true)

                // ... existing code ...
                DispatchQueue.main.async {
                    self.getPowerPlanetButton.isEnabled = true
                }
            }
        } failure: { msg in
            // Also enable the button when there's a failure in geocoding
            DispatchQueue.main.async {
                self.getPowerPlanetButton.isEnabled = true
            }
        }
    }

    func fetchTimeZone(latitude: Double, longitude: Double, timestamp: Int, completion: @escaping (TimeZone?) -> Void) {
        let API_KEY = "AIzaSyA5sA9Mz9AOMdRoHy4ex035V3xsJxSJU_8"
        let url = URL(string: "https://maps.googleapis.com/maps/api/timezone/json?location=\(latitude),\(longitude)&timestamp=\(timestamp)&key=\(API_KEY)")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let timeZoneId = json["timeZoneId"] as? String {
                        let timeZone = TimeZone(identifier: timeZoneId)
                        completion(timeZone)
                    } else {
                        completion(nil)
                    }
                }
            } catch {
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

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
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


    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil
        ) }


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

}

extension ViewController: CLLocationManagerDelegate {
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")
        
        
    }
    
    @objc func timePickerDonePressed() {
        birthTimeTextField.resignFirstResponder()
    }
    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
        let selectedTime = sender.date
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        timeFormatter.timeZone = TimeZone.current
        let timeString = timeFormatter.string(from: selectedTime)
        birthTimeTextField.text = timeString
    }

    func combinedDateAndTime() -> Date? {
        let calendar = Calendar.current

        guard let birthPlaceTimeZone = birthPlaceTimeZone else {
            return nil // Return early if birthPlaceTimeZone is not set
        }

        var dateComponents = calendar.dateComponents(in: birthPlaceTimeZone, from: datePicker.date)
        let timeComponents = calendar.dateComponents(in: TimeZone.current, from: timePicker.date)

        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute

        return calendar.date(from: dateComponents)
    }
}



