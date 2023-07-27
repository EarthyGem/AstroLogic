//
//import SwiftEphemeris
//import UIKit
//import CoreLocation
//import CSwissEphemeris
//
//import GooglePlaces
////import GoogleMaps
//
//
//
//class ViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
//    var selectedPlace: GMSPlace?
//    var birthPlaceTimeZone: TimeZone? = nil
//    var selectedDate: Date?
//    var chartCake: ChartCake?
//    var chart: Chart?
//        var birthChartView: BirthChartView?
//    var strongestPlanetSign: String?
//    let locationManager = CLLocationManager()
//    var harmonyDiscordScores: [String: (harmony: Double, discord: Double, difference: Double)]?
//    //    var aspects: [AstroAspect?] = []
//    var latitude: Double?
//    var longitude: Double?
//    let planetsInHouses: [Int: [String]] = [:]
//    var signScore: [String : Double] = [:]
//    var planetHouseScores: [Int : Double] = [:]
//    let houseCusps: [Cusp] = []
//    var ascDeclination: Double?
//    var mcDeclination: Double?
//    var scores: [(String, Double)] = []
//
//    let aboutButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("About", for: .normal)
//        button.addTarget(ViewController.self, action: #selector(showAboutViewController), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var birthPlaceTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Place of Birth"
//        textField.font = UIFont.systemFont(ofSize: 15)
//        textField.borderStyle = .roundedRect
//        textField.frame = CGRect(x: 25, y: 200, width: 250, height: 35)
//        textField.addTarget(self, action: #selector(birthPlaceTextFieldEditingDidBegin), for: .editingDidBegin)
//        return textField
//    }()
//
//    var autocompleteController: GMSAutocompleteViewController? // Add this line
//
//
//
//
//
//
//    lazy var birthTimeTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Time of Birth"
//        textField.font = UIFont.systemFont(ofSize: 15)
//        textField.borderStyle = .roundedRect
//        textField.frame = CGRect(x: 25, y: 250, width: 250, height: 35)
//        return textField
//    }()
//
//
//    let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM dd, yyyy"
//        formatter.timeZone = TimeZone.current
//        //        let dateComponents = DateComponents(year: 1977, month: 5, day: 21, hour: 13, minute: 57)
//        //        let date = Calendar.current.date(from: dateComponents)!
//        //        let dateString = formatter.string(from: date)
//        //        formatter.defaultDate = date
//        return formatter
//    }()
//
//        lazy var getPowerPlanetButton: UIButton = {
//            let button = UIButton(type: .system)
//            button.setTitle("Get Power Planet", for: .normal)
//            button.addTarget(self, action: #selector(getPowerPlanetButtonTapped), for: .touchUpInside)
//            return button
//        }()
//
//        lazy var getChartButton: UIButton = {
//            let chartButton = UIButton(type: .system)
//            chartButton.setTitle("Get ChartCake", for: .normal)
//            chartButton.addTarget(self, action: #selector(getChartButtonTapped), for: .touchUpInside)
//            return chartButton
//
//        }()
//
//    lazy var scoresText: UILabel = {
//        let scoresText = UILabel()
//        scoresText.textColor = .white
//        scoresText.numberOfLines = 0
//
//        return scoresText
//
//    }()
//
//    lazy var dateTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Date of Birth"
//        textField.font = UIFont.systemFont(ofSize: 15)
//        textField.borderStyle = .roundedRect
//        textField.frame = CGRect(x: 25, y: 150, width: 250, height: 35)
//        //        let dateComponents = DateComponents(year: 1977, month: 5, day: 21, hour: 13, minute: 57)
//        //        let date = Calendar.current.date(from: dateComponents)!
//
//        //        textField.text = dateFormatter.string(from: date)
//        return textField
//    }()
//
//
//    lazy var datePicker: UIDatePicker = {
//        let datePicker = UIDatePicker()
//
//        datePicker.datePickerMode = .date
//        datePicker.preferredDatePickerStyle = .wheels
//        datePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
//        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
//
//        // Set default date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy/MM/dd"
//        if let date = dateFormatter.date(from: "1978/03/03") {
//            datePicker.date = date
//        }
//
//        return datePicker
//    }()
//
//
//    lazy var timePicker: UIDatePicker = {
//        let datePicker = UIDatePicker()
//        datePicker.preferredDatePickerStyle = .wheels
//        datePicker.datePickerMode = .time
//        datePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
//        datePicker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
//
//        // Set default time to noon
//        let calendar = Calendar.current
//        if let noonDate = calendar.date(bySettingHour: 14, minute: 51, second: 0, of: Date()) {
//            datePicker.date = noonDate
//        }
//
//        return datePicker
//    }()
//
//    //  func printAspectSymbols() {
//    //        for aspect in aspects {
//    //            if let symbol = aspect?.symbol {
//    //             //   print("Aspect Symbol: \(symbol)")
//    //            }
//    //        }
//    //    }
//    //
//    //func setupView() {
//    //      aspects = getAllNatalAspects(birthChart: chart!, date: selectedDate!)
//    //        printAspectSymbols() // Print the aspect symbols
//    //    }
//    //
//    @objc func getChartButtonTapped() {
//        guard let chart = chart else {
//            // Show an error message if the chart is not available
//            return
//        }
//        birthChartView = BirthChartView(frame: view.bounds, chartCake: chartCake!)
//
//        // Initialize and push the ChartViewController
//        let chartVC = ChartViewController()
//        chartVC.chart = chart.self
//        chartVC.chartCake = chartCake.self
//        chartVC.harmonyDiscordScores = getScoresAndDifferenceForPlanets(chart: chart)
//        chartVC.scores = getTotalPowerScoresForPlanets2(chart: chart)
//        self.navigationController?.pushViewController(chartVC, animated: true)
//    }
//
//    func getStrongestPlanet2(from scores: [(String, Double)]) -> String? {
//        return scores.first?.0
//    }
//
//    @objc func getPowerPlanetButtonTapped() {
//
//        getPowerPlanetButton.isEnabled = false
//        let location = birthPlaceTextField.text
//        getPowerPlanetButton.isEnabled = false
//
//        geocoding(location: location!) { [self] (latitude, longitude) in
//            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            getTimeZone(location: coordinate) { [self] timeZone in
//                guard let timeZone = timeZone else {
//                    DispatchQueue.main.async {
//                        self.getPowerPlanetButton.isEnabled = true
//                    }
//                    return
//                }
//
//                // Update the latitude and longitude values
//                self.latitude = latitude
//                self.longitude = longitude
//
//                // Set the time zone of the date picker and time picker
//                self.timePicker.timeZone = timeZone
//                self.datePicker.timeZone = timeZone
//
//                self.ascDeclination = ascDeclination
//                self.mcDeclination = mcDeclination
//                self.birthPlaceTimeZone = timeZone
//
//
//                self.selectedDate = self.datePicker.date //
//
//                self.chartCake = ChartCake(birthDate: combinedDateAndTime()!, latitude: latitude, longitude: longitude)
//                self.chart = Chart(date: combinedDateAndTime()!, latitude: latitude, longitude: longitude, houseSystem: .placidus)
//               var sunAspects = chart!.aspects(for: chart!.sun, on: Date())
//                print("planet powers: \(getTotalPowerScoresForPlanets(chart: chart!))")
//
//
//                let harmonyScoreDifferences = getHarmonyScoreDifferenceForPlanets(chart: chart!)
//
//                let mostDiscordantPlanet = getMostDiscordantPlanet(from: harmonyScoreDifferences)
//
//                let mostHarmoniousPlanet = getMostHarmoniousPlanet(from: harmonyScoreDifferences)
//
//
//
//                let scores = getTotalPowerScoresForPlanets(chart: chart!)
//
//                   let strongestPlanet = getStrongestPlanet2(from: scores)
//
//

//
//    func getMostDiscordantPlanet(chart: Chart) -> String {
//        let scoreDifferences = getHarmonyScoreDifferenceForPlanets(chart: chart)
//
//        var mostDiscordantPlanet: String = ""
//        var maxScoreDifference = 0.0
//
//        for (planet, scoreDifference) in scoreDifferences {
//            if scoreDifference > maxScoreDifference {
//                mostDiscordantPlanet = planet
//                maxScoreDifference = scoreDifference
//            }
//        }
//
//        return mostDiscordantPlanet
//    }
//
//    func getMostHarmoniousPlanet(from harmonyScoreDifferences: [String: Double]) -> String? {
//        guard !harmonyScoreDifferences.isEmpty else {
//            return nil
//        }
//
//        var mostHarmoniousPlanet: String = harmonyScoreDifferences.keys.first!
//        var mostHarmoniousScore: Double = harmonyScoreDifferences[mostHarmoniousPlanet] ?? Double.nan
//
//        for (planet, scoreDifference) in harmonyScoreDifferences {
//            if scoreDifference > mostHarmoniousScore {
//                mostHarmoniousPlanet = planet
//                mostHarmoniousScore = scoreDifference
//            }
//        }
//
//        return mostHarmoniousPlanet
//    }
//
//    func getMostDiscordantPlanet(from harmonyScoreDifferences: [String: Double]) -> String? {
//        guard !harmonyScoreDifferences.isEmpty else {
//            return nil
//        }
//
//        var mostDiscordantPlanet: String = harmonyScoreDifferences.keys.first!
//        var mostDiscordantScore: Double = harmonyScoreDifferences[mostDiscordantPlanet] ?? Double.nan
//
//        for (planet, scoreDifference) in harmonyScoreDifferences {
//            if scoreDifference < mostDiscordantScore {
//                mostDiscordantPlanet = planet
//                mostDiscordantScore = scoreDifference
//            }
//        }
//
//        return mostDiscordantPlanet
//    }
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//        //            print("View constarints\(view.constraints)")
//        //            print("View constarints\(aboutButton.constraints)")
//        //            print(aboutButton.constraints)
//
//        //       print(nodalMadLib())
//        view.addSubview(getChartButton)
//        view.backgroundColor = .black
//
//        view.addSubview(birthPlaceTextField)
//
//        makeAutocompleteViewController()
//
//        view.addSubview(dateTextField)
//        view.addSubview(birthPlaceTextField)
//        birthPlaceTextField.addTarget(self, action: #selector(birthPlaceTextFieldDidChange), for: .editingChanged)
//
//        view.addSubview(birthTimeTextField)
//
//        birthTimeTextField.inputView = timePicker
//
//        view.addSubview(aboutButton)
//        aboutButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            aboutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            aboutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//
//        dateTextField.inputView = datePicker
//
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDonePressed))
//        toolBar.setItems([doneBtn], animated: true)
//        dateTextField.inputAccessoryView = toolBar
//
//        let timePickerToolBar = UIToolbar()
//        timePickerToolBar.sizeToFit()
//        let timePickerDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timePickerDonePressed))
//        timePickerToolBar.setItems([timePickerDoneBtn], animated: true)
//        birthTimeTextField.inputAccessoryView = timePickerToolBar
//
//        view.addSubview(getPowerPlanetButton)
//        getPowerPlanetButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            getPowerPlanetButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10), // Add a small space between buttons
//            getPowerPlanetButton.topAnchor.constraint(equalTo: birthPlaceTextField.bottomAnchor, constant: 55)
//        ])
//
//        getChartButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            getChartButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10), // Add a small space between buttons
//            getChartButton.topAnchor.constraint(equalTo: birthPlaceTextField.bottomAnchor, constant: 55)
//        ])
//
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//
//
//    }
//
//    @objc func birthPlaceTextFieldEditingDidBegin() {
//        presentAutocompleteViewController()
//    }
//
//    func makeAutocompleteViewController() {
//        let autocompleteController = GMSAutocompleteViewController()
//        autocompleteController.delegate = self
//        autocompleteController.modalPresentationStyle = .popover
//        autocompleteController.modalTransitionStyle = .crossDissolve
//
//        let popover = autocompleteController.popoverPresentationController
//        popover?.sourceView = birthPlaceTextField
//        popover?.sourceRect = birthPlaceTextField.bounds
//
//        // Customize the autocomplete filter and place fields if needed
//        let filter = GMSAutocompleteFilter()
//        filter.type = .city
//        autocompleteController.autocompleteFilter = filter
//
//        let fields: GMSPlaceField = GMSPlaceField(rawValue: (UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.addressComponents.rawValue)))
//        autocompleteController.placeFields = fields
//
//
//        // Set the desired location restriction if needed
//        // autocompleteController.locationRestriction = ...
//
//        // Set the desired country restriction if needed
//        // autocompleteController.countryRestriction = ...
//
//        // Rest of your code...
//
//
//
//        self.autocompleteController = autocompleteController
//    }
//
//    func presentAutocompleteViewController() {
//        if let autocompleteController = autocompleteController {
//            present(autocompleteController, animated: true, completion: nil)
//        }
//    }
//
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        var city: String?
//        var state: String?
//        var country: String?
//        if let addressComponents = place.addressComponents {
//            for component in addressComponents {
//                switch component.types[0] {
//                case kGMSPlaceTypeLocality:
//                    city = component.name
//                case kGMSPlaceTypeAdministrativeAreaLevel1:
//                    state = component.shortName
//                case kGMSPlaceTypeCountry:
//                    country = component.shortName
//                default:
//                    break
//                }
//            }
//        }
//
//        // Combine city, state, and country into a single string.
//        var locationString = ""
//        if let city = city {
//            locationString += city
//        }
//        if let state = state {
//            if !locationString.isEmpty {
//                locationString += ", "
//            }
//            locationString += state
//        }
//        if let country = country {
//            if !locationString.isEmpty {
//                locationString += ", "
//            }
//            locationString += country
//        }
//
//        // Set the location string to the text field.
//        birthPlaceTextField.text = locationString
//
//        dismiss(animated: true, completion: nil)
//    }
//
//
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        print("Autocomplete error: \(error.localizedDescription)")
//        dismiss(animated: true, completion: nil)
//    }
//
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    @objc func birthPlaceTextFieldDidChange() {
//        updateDatePickerTimeZone()
//    }
//
//
//    @objc func showAboutViewController() {
//        let aboutVC = AboutViewController()
//        navigationController?.pushViewController(aboutVC, animated: true)
//    }
//
//
//    func updateDatePickerTimeZone() {
//        let geocoder = CLGeocoder()
//        let addressString = birthPlaceTextField.text ?? ""
//
//        geocoder.geocodeAddressString(addressString) { placemarks, error in
//            guard let placemark = placemarks?.first, let timeZone = placemark.timeZone else {
//                // Handle error or default timezone
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.datePicker.timeZone = timeZone
//            }
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showStrongestPlanet",
//           let strongestPlanetVC = segue.destination as? StrongestPlanetViewController,
//           let planets = sender as? (String, String, String, String) {
//            strongestPlanetVC.chartCake = chartCake
//            strongestPlanetVC.chart = chart // Add this line
//        } else if segue.identifier == "showChart",
//                  let chartViewerVC = segue.destination as? ChartViewController {
//
//
//            chartViewerVC.chartCake = chartCake
//        }
//
//    }
//
//
//    @objc func datePickerValueChanged() {
//        // Ensure that UI updates are performed on the main thread
//        DispatchQueue.main.async {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMMM dd, yyyy"
//            dateFormatter.timeZone = self.birthPlaceTimeZone ?? TimeZone.current
//
//            let dateString = dateFormatter.string(from: self.datePicker.date)
//            self.dateTextField.text = dateString
//
//        }
//    }
//
//    @objc func datePickerDonePressed() {
//        // Set the time zone for the date picker
//
//        dateTextField.resignFirstResponder()
//    }
//
//
//    func showAlert(withTitle title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil
//        ) }
//}
//
//extension ViewController: CLLocationManagerDelegate {
//
//    func startUpdatingLocation() {
//        locationManager.startUpdatingLocation()
//    }
//
//    func stopUpdatingLocation() {
//        locationManager.stopUpdatingLocation()
//    }
//
//    //func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    //    guard locations.last != nil else { return }
//    //    let rulingPlanet = rulingPlanet(at: Date(), location: locations.last!)
//    //
//    //    let planetaryHours: () = printPlanetaryHoursForTheDay(date: Date(), location: locations.first!)
//    //   //     print("Planetary Hour: \(rulingPlanet)")
//    //  //  print("Planetary Hour: \(planetaryHours)")
//    //}
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Location update failed: \(error.localizedDescription)")
//
//
//    }
//
//    @objc func timePickerDonePressed() {
//        birthTimeTextField.resignFirstResponder()
//    }
//
//    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
//        let selectedTime = sender.date
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = "h:mm a"
//        timeFormatter.timeZone = sender.timeZone // Use the timePicker's timezone
//        let timeString = timeFormatter.string(from: selectedTime)
//        birthTimeTextField.text = timeString
//    }
//
//
//    func combinedDateAndTime() -> Date? {
//        let calendar = Calendar.current
//
//        guard let birthPlaceTimeZone = birthPlaceTimeZone else {
//            return nil // Return early if birthPlaceTimeZone is not set
//        }
//
//        var dateComponents = calendar.dateComponents(in: birthPlaceTimeZone, from: datePicker.date)
//        let timeComponents = calendar.dateComponents(in: birthPlaceTimeZone, from: timePicker.date)
//
//        dateComponents.hour = timeComponents.hour
//        dateComponents.minute = timeComponents.minute
//
//        return calendar.date(from: dateComponents)
//    }
//
//
//    func convertToLocalTime(fromDate date: Date, timeZone: TimeZone) -> Date {
//        let localTimeZone = TimeZone.current
//
//        let sourceOffset = TimeInterval(timeZone.secondsFromGMT(for: date)) / 60
//        let localOffset = TimeInterval(localTimeZone.secondsFromGMT(for: date)) / 60
//
//        let adjustedDate = date.addingTimeInterval((localOffset - sourceOffset) * 60)
//        return adjustedDate
//    }
//}
