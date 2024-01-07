import SwiftEphemeris
import CoreData
import UIKit
import MapKit
import CoreLocation

//import GoogleMaps

import CoreData

class DataManager {
    static let shared = DataManager()
    var charts: [ChartEntity]?

    func fetchCharts(completion: @escaping ([ChartEntity]?) -> Void) {
        // Assuming you have a Core Data stack set up
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil)
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ChartEntity>(entityName: "ChartEntity")

        do {
            let charts = try context.fetch(fetchRequest)
            self.charts = charts
            completion(charts)
        } catch {
            print("Failed to fetch charts: \(error.localizedDescription)")
            completion(nil)
        }
    }
}


class ViewController: UIViewController,  SuggestionsViewControllerDelegate, MKLocalSearchCompleterDelegate, UITextFieldDelegate  {

    var birthPlaceTimeZone: TimeZone? {
        didSet {
            datePicker.timeZone = birthPlaceTimeZone
            timePicker.timeZone = birthPlaceTimeZone
        }
    }
    let searchCompleter = MKLocalSearchCompleter()
    var suggestions: [MKLocalSearchCompletion] = [] 
     var searchRequest: MKLocalSearch.Request?

    var autocompleteSuggestions: [String] = []

    var selectedDate: Date?
    var chart: Chart?
    var birthChartView: BirthChartView?
    var strongestPlanetSign: String?
    let locationManager = CLLocationManager()
    var harmonyDiscordScores: [String: (harmony: Double, discord: Double, difference: Double)]?
    //   var aspects: [AstroAspect?] = []
    var latitude: Double?
    var longitude: Double?
    let planetsInHouses = [Int: [String]]()
    var signScore: [String : Double] = [:]
    var houseScores: [Int : Double] = [:]
    let houseCusps: [Cusp] = []
    var ascDeclination: Double?
    var mcDeclination: Double?
    var scores: [String : Double] = [:]
    var chartCake: ChartCake?
    var scores2: [CelestialObject : Double] = [:]
    
    var toggleSwitch: UISwitch!
    let aboutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("About", for: .normal)
        button.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.75, alpha: 1)
        button.addTarget(ViewController.self, action: #selector(showAboutViewController), for: .touchUpInside)
        return button
    }()



    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
     //   textField.frame = CGRect(x: 50, y: 200, width: 300, height: 45)  // Adjust y to position it above dateTextField
        return textField
    }()

    lazy var birthPlaceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Place of Birth"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
     //   textField.frame = CGRect(x: 50, y: 260, width: 300, height: 45)
        textField.addTarget(self, action: #selector(birthPlaceTextFieldEditingDidBegin), for: .editingDidBegin)
        return textField
    }()



    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date of Birth"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
   //     textField.frame = CGRect(x: 50, y: 320, width: 300, height: 45)

        return textField
    }()


    lazy var birthTimeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Time of Birth"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.textAlignment = .center // This centers the text horizontally
        textField.borderStyle = .roundedRect
//textField.frame = CGRect(x: 50, y: 380, width: 300, height: 45)
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
        button.setTitle("Who's here?", for: .normal)
        button.addTarget(self, action: #selector(getPowerPlanetButtonTapped), for: .touchUpInside)

        // Set background color to lavender
        button.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.98, alpha: 1)  // RGB values for lavender

        // Make button corners rounded
        button.layer.cornerRadius = 8.0

        // Set the title color to the color you provided
        button.setTitleColor(UIColor(red: 0.6, green: 0.6, blue: 0.75, alpha: 1), for: .normal)

        // Set font to bold and adjust the size accordingly
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17) // Adjust size to fit your needs

        return button
    }()




    lazy var scoresText: UILabel = {
        let scoresText = UILabel()
        scoresText.textColor = .white
        scoresText.numberOfLines = 0

        return scoresText

    }()

    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        picker.timeZone = TimeZone.current // Use birthPlaceTimeZone

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = df.date(from: "1976-03-03 14:51:00") {
            picker.date = date
        }

        return picker
    }()


    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.timeZone = TimeZone.current // Use birthPlaceTimeZone
        picker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        picker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = df.date(from: "1976-03-03 14:51:00") {
            picker.date = date
        }

        return picker
    }()

    func searchPlace(_ place: String) {
       let searchRequest = MKLocalSearch.Request()
       searchRequest.naturalLanguageQuery = place

       let search = MKLocalSearch(request: searchRequest)
       search.start { (response, error) in
           if let error = error {
               print("Search error: \(error.localizedDescription)")
           } else if let response = response {
               // Handle the search results
               for item in response.mapItems {
                   print(item.name)
               }
           }
       }
    }
    // When the text in the text field changes, update the queryFragment property
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        searchCompleter.queryFragment = text!
       return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        searchCompleter.delegate = self
        birthPlaceTextField.delegate = self

        view.backgroundColor = UIColor(red: 236/255, green: 239/255, blue: 244/255, alpha: 1) // Light grey background for a clean look.

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        headerView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.98, alpha: 1)

        // Create the title label
        // Create the title label
        let titleLabel = UILabel(frame: CGRect(x: 15, y: headerView.bounds.height - 50, width: self.view.bounds.width - 80, height: 40))  // adjust width to leave space for button
        titleLabel.text = "Astrologic ☿"
        titleLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.75, alpha: 1)
        if let customFont = UIFont(name: "Chalkduster", size: 30) {
            titleLabel.font = customFont
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 20)  // Backup in case the custom font fails
        }


        // Create the myChartsButton
        let myChartsButton = UIButton(type: .custom)
        myChartsButton.setImage(UIImage(systemName: "folder.fill"), for: .normal)
        myChartsButton.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.75, alpha: 1)  // RGB values for dark lavender

        // Adjust the frame
        let buttonX = titleLabel.frame.maxX + 10
        let buttonY = titleLabel.frame.minY
        myChartsButton.frame = CGRect(x: buttonX, y: buttonY, width: 40, height: 40)

        myChartsButton.addTarget(self, action: #selector(showMyCharts), for: .touchUpInside)
        headerView.addSubview(myChartsButton)  // Add the button to the headerView

        headerView.addSubview(titleLabel)

        // Add custom header to the main view BEFORE other subviews to ensure it's not overlapped
        self.view.addSubview(headerView)

        toggleSwitch = UISwitch()
       toggleSwitch.isOn = false // Set the initial state to "on"// Set the initial state as needed
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchChanged(sender:)), for: .valueChanged)

        // Create a UIBarButtonItem with the UISwitch
        view.addSubview(birthPlaceTextField)

        view.addSubview(dateTextField)
        view.addSubview(birthPlaceTextField)

        view.addSubview(birthTimeTextField)
        birthTimeTextField.inputView = timePicker
        view.addSubview(aboutButton)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(nameTextField)
           nameTextField.translatesAutoresizingMaskIntoConstraints = false

           // Add the birthPlaceTextField to the view and set up constraints
           view.addSubview(birthPlaceTextField)
           birthPlaceTextField.translatesAutoresizingMaskIntoConstraints = false

           // Add the dateTextField to the view and set up constraints
           view.addSubview(dateTextField)
           dateTextField.translatesAutoresizingMaskIntoConstraints = false

           // Add the birthTimeTextField to the view and set up constraints
           view.addSubview(birthTimeTextField)
           birthTimeTextField.translatesAutoresizingMaskIntoConstraints = false

           // Add the getPowerPlanetButton to the view and set up constraints
           view.addSubview(getPowerPlanetButton)
           getPowerPlanetButton.translatesAutoresizingMaskIntoConstraints = false

           // Set the Auto Layout constraints
           NSLayoutConstraint.activate([
               // Center the nameTextField and set its width and height
               nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150), // Adjust this constant as needed
               nameTextField.widthAnchor.constraint(equalToConstant: 300),
               nameTextField.heightAnchor.constraint(equalToConstant: 45),
               
               // Center the birthPlaceTextField and set its width and height
               birthPlaceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               birthPlaceTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20), // Space between the text fields
               birthPlaceTextField.widthAnchor.constraint(equalToConstant: 300),
               birthPlaceTextField.heightAnchor.constraint(equalToConstant: 45),
               
               // Center the dateTextField and set its width and height
               dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               dateTextField.topAnchor.constraint(equalTo: birthPlaceTextField.bottomAnchor, constant: 20), // Space between the text fields
               dateTextField.widthAnchor.constraint(equalToConstant: 300),
               dateTextField.heightAnchor.constraint(equalToConstant: 45),
               
               // Center the birthTimeTextField and set its width and height
               birthTimeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               birthTimeTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20), // Space between the text fields
               birthTimeTextField.widthAnchor.constraint(equalToConstant: 300),
               birthTimeTextField.heightAnchor.constraint(equalToConstant: 45),
               
               // Center the getPowerPlanetButton and set its width and height
               getPowerPlanetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               getPowerPlanetButton.topAnchor.constraint(equalTo: birthTimeTextField.bottomAnchor, constant: 30), // Space between the text field and the button
               getPowerPlanetButton.widthAnchor.constraint(equalToConstant: 300),
               getPowerPlanetButton.heightAnchor.constraint(equalToConstant: 45)
           ])

        dateTextField.inputView = datePicker
        view.addSubview(nameTextField)

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

        view.addSubview(birthPlaceTextField)
             birthPlaceTextField.delegate = self // Set the delegate for the birthPlaceTextField
             birthPlaceTextField.addTarget(self, action: #selector(birthPlaceTextFieldEditingDidBegin), for: .editingDidBegin) // Add this line


      // getPowerPlanetButton.frame = CGRect(x: 50, y: 440, width: 300, height: 45)
       // parseAndSaveData()
        view.addSubview(getPowerPlanetButton)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()


    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
           DataManager.shared.fetchCharts { [weak self] charts in
               guard let self = self else { return }
               // Store the charts data or pass it to RelationshipsViewController
           }
       }

    @objc func toggleSwitchChanged(sender: UISwitch) {
        // Handle switch state changes here
        // You can access sender.isOn to determine the new state (true for on, false for off)
        
        // Apply changes to all the charts based on the new switch state
        if sender.isOn {
            // Apply changes when the switch is on
        } else {
            // Apply changes when the switch is off
        }
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
    @objc func birthPlaceTextFieldEditingDidBegin() {
          let suggestionsVC = SuggestionsViewController()
          suggestionsVC.delegate = self
          present(suggestionsVC, animated: true, completion: nil)
      }

    func suggestionSelected(_ suggestion: MKLocalSearchCompletion) {
          birthPlaceTextField.text = suggestion.title
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
        birthPlaceTextField.text = place
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


    @objc func birthPlaceTextFieldDidChange() {
        updateDatePickerTimeZone()
        updateTimePickerTimeZone()
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == birthPlaceTextField {
            let suggestionsVC = SuggestionsViewController()
            suggestionsVC.delegate = self // Set the delegate
            present(suggestionsVC, animated: true, completion: nil)
            return false
        }
        return true
    }


    func updateTimePickerTimeZone() {
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
                    self.timePicker.timeZone = timeZone
                    self.dateFormatter.timeZone = timeZone
                    self.birthPlaceTimeZone = timeZone

                    // Update the timePicker's date to reflect the new timezone
                    let date = self.timePicker.date
                    let components = Calendar.current.dateComponents(in: timeZone!, from: date)
                    if let hour = components.hour, let minute = components.minute {
                        self.timePicker.setDate(Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: date)!, animated: false)
                    }
                }
            }
        }
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
                self.chartCake = ChartCake(birthDate: chartDate, latitude: latitude, longitude: longitude, transitDate: selectedDate)

                guard let chart = self.chart else {
                    assert(false, "There is no chart")
                    return
                }



//              print("get pairs1: \(chartCake?.celestialPairsFromProgressedAspects())")
//                print("get pairs2: \(chartCake?.minorProgressedAspectsForCelestialPairs())")
//                print("get pairs3: \(chartCake?.filteredMinorProgressedAspectsFromCelestialPairs())")
                let name = nameTextField.text ?? ""

            //    let phaseName = chartCake

                var bodiesArgument: [Coordinate]? = (toggleSwitch.isOn) ? chart.rickysBodies : nil

                
         
            let scores = chart.getTotalPowerScoresForPlanets(bodiesArgument)
                let strongestPlanet = self.getStrongestPlanet(from: scores)

                saveChart(name: name, birthDate: chartDate, latitude: latitude, longitude: longitude, birthPlace: birthPlaceTextField.text!, strongestPlanet: strongestPlanet.keyName)

                
                let phaseName = chartCake?.lunarPhase(for: chartCake!.natal)

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
                                                     risingSign: chart.houseCusps.ascendent.sign.keyName, name: name)


                var sortedPlanets: [CelestialObject] {
                    let scores2 = chartCake?.getTotalPowerScoresForPlanets()
                    return getPlanetsSortedByStrength(from: scores2!)
                }

     //   print("sorted scores: \((sortedPlanets))")

                // Initialize and push the StrongestPlanetViewController
                let strongestPlanetVC = StrongestPlanetViewController()
                strongestPlanetVC.chartCake = chartCake
                strongestPlanetVC.chart = chart
                strongestPlanetVC.harTarot = mostHarmoniousPlanet.tarot
                strongestPlanetVC.tarot = getStrongestPlanet(from: scores).tarot
               // strongestPlanetVC.charts = charts
                strongestPlanetVC.disTarot = mostDiscordantPlanet.tarot
                strongestPlanetVC.strongestPlanet = getStrongestPlanet(from: scores).keyName
                strongestPlanetVC.strongestPlanetArchetype = getStrongestPlanet(from: scores).archetype
                strongestPlanetVC.strongestPlanetSign = strongestPlanetSign
                strongestPlanetVC.name = nameTextField.text!
                strongestPlanetVC.phaseName = phaseName?.rawValue
                strongestPlanetVC.mostDiscordantPlanet = mostDiscordantPlanet.keyName
                strongestPlanetVC.mostHarmoniousPlanet = mostHarmoniousPlanet.keyName
                strongestPlanetVC.scores = scores
                strongestPlanetVC.mostDiscordantPlanetArchetype = mostDiscordantPlanet.archetype
                strongestPlanetVC.mostHarmoniousPlanetArchetype = mostHarmoniousPlanet.archetype
                strongestPlanetVC.sentenceText = sentence
                strongestPlanetVC.birthDate = combinedDateAndTime()
                strongestPlanetVC.sortedPlanets = getPlanetsSortedByStrength(from: scores2)
             //   print("sortedPlanets\(getPlanetsSortedByStrength(from: scores2))")
                strongestPlanetVC.birthPlace = self.birthPlaceTextField.text

                self.navigationController?.pushViewController(strongestPlanetVC, animated: true)

                resetViewController()
                nameTextField.text = ""
                 birthPlaceTextField.text = ""
                 dateTextField.text = ""
                 birthTimeTextField.text = ""

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
    func resetViewController() {
        // Clear input fields
        birthPlaceTextField.text = ""
        datePicker.setDate(Date(), animated: true)

        // Get the text from the birthPlaceTextField
        if let birthPlace = birthPlaceTextField.text {
            // Use the text to determine the time zone identifier
            let timeZone = TimeZone(identifier: birthPlace)

            // Set the timeZone property of the UIDatePicker
            timePicker.timeZone = timeZone


            func resetViewController() {
                birthPlaceTextField.text = ""
                nameTextField.text = ""
                datePicker.setDate(Date(), animated: true)
                timePicker.setDate(Date(), animated: true)

                // Reset the time zone of the UIDatePicker based on the input in the birthPlaceTextField
                if let birthPlace = birthPlaceTextField.text,
                   let timeZone = TimeZone(identifier: birthPlace) {
                    timePicker.timeZone = timeZone
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
            self.timePickerValueChanged(self.timePicker) // Assuming you have a timePicker like your datePicker
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

    @objc func timePickerDonePressed() {
        birthTimeTextField.resignFirstResponder()
    }
    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = sender.timeZone
        dateFormatter.dateFormat = "h:mm a" // Adjust this to your desired format
        birthTimeTextField.text = dateFormatter.string(from: sender.date)
    }

    func combinedDateAndTime() -> Date? {
        let calendar = Calendar.current

        guard let birthPlaceTimeZone = birthPlaceTimeZone else {
            return nil // Return early if birthPlaceTimeZone is not set
        }

        datePicker.timeZone = birthPlaceTimeZone
        timePicker.timeZone = birthPlaceTimeZone

        // Extract date components using birthPlaceTimeZone
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: datePicker.date)

        // Extract time components using the same timezone (birthPlaceTimeZone)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: timePicker.date)

        // Combine date and time components
        dateComponents.timeZone = birthPlaceTimeZone
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute

        print("Combined date and time components: \(dateComponents)")
        let date = calendar.date(from: dateComponents)!
        let offset = birthPlaceTimeZone.secondsFromGMT(for: date)
        print("Date AFTER date components conversion: \(date.toString(format: .cocoaDateTime, timeZone: .custom(offset))!)")
        return date
    }

}
