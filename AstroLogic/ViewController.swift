import SwiftEphemeris
import UIKit
import CoreLocation
import GooglePlaces
//import GoogleMaps



class ViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    var selectedPlace: GMSPlace?
    var birthPlaceTimeZone: TimeZone? = nil
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
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        formatter.timeZone = TimeZone.current
//        let dateComponents = DateComponents(year: 1977, month: 5, day: 21, hour: 13, minute: 57)
//        let date = Calendar.current.date(from: dateComponents)!
//        let dateString = formatter.string(from: date)
//        formatter.defaultDate = date
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
//        let dateComponents = DateComponents(year: 1977, month: 5, day: 21, hour: 13, minute: 57)
//        let date = Calendar.current.date(from: dateComponents)!

//        textField.text = dateFormatter.string(from: date)
        return textField
    }()
    
    
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

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
        datePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        datePicker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)

        // Set default time to noon
        let calendar = Calendar.current
        if let noonDate = calendar.date(bySettingHour: 14, minute: 51, second: 0, of: Date()) {
            datePicker.date = noonDate
        }

        return datePicker
    }()
    
//  func printAspectSymbols() {
//        for aspect in aspects {
//            if let symbol = aspect?.symbol {
//             //   print("Aspect Symbol: \(symbol)")
//            }
//        }
//    }
//    
//func setupView() {
//      aspects = getAllNatalAspects(birthChart: chart!, date: selectedDate!)
//        printAspectSymbols() // Print the aspect symbols
//    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
//            print("View constarints\(view.constraints)")
//            print("View constarints\(aboutButton.constraints)")
//            print(aboutButton.constraints)

//       print(nodalMadLib())
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

        
        // Set the desired location restriction if needed
        // autocompleteController.locationRestriction = ...
        
        // Set the desired country restriction if needed
        // autocompleteController.countryRestriction = ...
        
        // Rest of your code...
        
        
        
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
            guard let placemark = placemarks?.first, let timeZone = placemark.timeZone else {
                // Handle error or default timezone
                return
            }
            
            DispatchQueue.main.async {
                self.datePicker.timeZone = timeZone
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
        chartVC.chart = chart.self
        chartVC.houseScores = calculateHouseStrengths(chart: self.chart!, houseCusps: getHouseCusps2(), interceptedSigns: getInterceptedSigns(), planetsInHouses: calculatePlanetsInHouses())
        chartVC.chartCake = chartCake.self
        chartVC.harmonyDiscordScores = getScoresAndDifferenceForPlanets(chart: self.chart!)
        chartVC.scores2 = getTotalPowerScoresForPlanets(chart: chart!)
        chartVC.scores = getTotalPowerScoresForPlanets2(chart: chart!)
        self.navigationController?.pushViewController(chartVC, animated: true)
        
//        birthChartView = BirthChartView(frame: view.bounds, chartCake: chartCake!)
    }

@objc func getPowerPlanetButtonTapped() {
   
    getPowerPlanetButton.isEnabled = false
    let location = birthPlaceTextField.text
       getPowerPlanetButton.isEnabled = false
       
    geocoding(location: location!) { [self] (latitude, longitude) in
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
               
            self.ascDeclination = ascDeclination
                self.mcDeclination = mcDeclination
            self.birthPlaceTimeZone = timeZone
       
            self.chart = Chart(date: combinedDateAndTime()!, latitude: latitude, longitude: longitude, houseSystem: .placidus)
        
            self.selectedDate = self.datePicker.date // Store the selected date in a property
               
               
               

            //                datePickerValueChanged()
            // Calculate Ascendant and Midheaven declinations
//            let julianDay = selectedDate!.julianDate()
//            let obliquityOfEcliptic = obliquity(julianDay: julianDay)
//
//               let (_, ascDeclination) = eclipticToEquatorial(longitude: (self.chart?.houseCusps.ascendent.value)!, obliquity: obliquityOfEcliptic)
//               let (_, mcDeclination) = eclipticToEquatorial(longitude: (self.chart?.houseCusps.midHeaven.value)!, obliquity: obliquityOfEcliptic)

               let scores = getTotalPowerScoresForPlanets(chart: chart!)

               let filteredScores = scores.filter { tuple in
                   // Filter out the planet with name "South Node"
                   return tuple.0 != "Mean South Node"
               }
                   let strongestPlanet = getStrongestPlanet2(from: filteredScores)
//
               
             //   print("SCORES: \(scores)")
//                  let scoresTexts = getTotalPowerScoresForPlanetsText(birthChart: self.chart!, date: selectedDate!, ascDeclination: ascDeclination, mcDeclination: mcDeclination)
//                scoresText.text = scoresTexts
            
//                scoresText.frame = CGRect(x: 0, y: 300, width: 300 , height: 250)
//                view.addSubview(scoresText)

            let harmonyScoreDifferences = getHarmonyScoreDifferenceForPlanets(chart: self.chart!)
            
               _ = getScoresAndDifferenceForPlanets(chart: self.chart!)
            
               _ = calculateUnoccupiedSignStrengths(chart: self.chart!, houseCusps: getHouseCusps2(), interceptedSigns: getInterceptedSigns())
               
               let signScore = calculateTotalSignScore(chart: self.chart!, houseCusps: getHouseCusps2(), interceptedSigns: getInterceptedSigns() )
              
//               print("Total Aspect Scores \(getCompositeAspectScores())")
        //       print("Total Comp House Scores \(getHouseScoreForPlanets())")
               
         //      print("Total Comp Parallels \(getCompositeParallelAspects())")
          
         //      print("Total Comp Apects to Angles \(getCompositePlanetaryAspectsToFirstAndTenthHouses())")
               
               let bodies = self.chart!.allBodies
               for body in bodies {
               //    print(" declinations: \(body.body.keyName) \(body.declination)")
               }
               
         
               
//                   // Call the function and print the result
//                   let planetsInHouses = calculatePlanetsInHouses
//                   print("Planets in Houses: \(planetsInHouses)")
//
//
//
                        let planetsInHousesResult = calculatePlanetsInHouses()
           //             print("calculatePlanetsInHouses: \(planetsInHousesResult)")

     
               
               let houseStrengths = calculatePlanetInHouseScores(chart: self.chart!,  planetsInHouses: planetsInHousesResult)
                                                            
                //    print("calculatePlanetInHouseScores: \(houseStrengths)")
               
               let houseScores = calculateHouseStrengths(chart: self.chart!, houseCusps: getHouseCusps2(), interceptedSigns: getInterceptedSigns(), planetsInHouses: planetsInHousesResult)
               
             
            //   print("House Score: \(houseScores)")
//
               _ = calculatePlanetSignScores(chart: self.chart!)
//
        //       getAllCompositeAspectScores()
             
//
//                   print("Unoccupied Sign Scores: \(signScores)")
              
            let mostDiscordantPlanet = getMostDiscordantPlanet(from: harmonyScoreDifferences)

            let mostHarmoniousPlanet = getMostHarmoniousPlanet(from: harmonyScoreDifferences)

//                presentMainTabBarController()
               

//
              //     print("Get total for planets and angles: \(getTotalPowerScoresForPlanets2(birthChart: self.chart!, date: selectedDate!, ascDeclination: ascDeclination, mcDeclination: mcDeclination))")
               
               
                //   print("CuspParallels: \(getAllParallelAspectScoresToAngles(birthChart: self.chart!, ascDeclination: ascDeclination, mcDeclination: mcDeclination))")
               
          //     print("Cusp Scores: \(getTotalPowerScoresForAngles(birthChart: self.chart!,ascDeclination: ascDeclination, mcDeclination: mcDeclination))")
              
               
              // print("angle house score: \( calculateAngleSignScores(birthChart: self.chart!,ascDeclination: ascDeclination, mcDeclination: mcDeclination))")
             
         //      print("planet house score: \( calculatePlanetSignScores(birthChart: self.chart!, date: selectedDate!,ascDeclination: ascDeclination, mcDeclination: mcDeclination))")
             
               
            //   print("Strong Planets: \(getStrongPlanets(birthChart: self.chart!, date: selectedDate!,ascDeclination: ascDeclination, mcDeclination: mcDeclination))")
               
             //  print("CuspAspects: \(getAllCuspAspectScores2(birthChart: self.chart!))")
               
               
          //     setupView()
               
       //        print("calculate comp Aspects: \(calculateAspects())")

               
               
               
               
        //       print("positive a negative: \(getPositiveNegativeAspectScores(birthChart: self.chart!, date: selectedDate!))")
               
               
               
               if strongestPlanet == "Sun" {
                strongestPlanetSign = chart!.sun.sign.keyName
            }  else  if strongestPlanet == "Moon" {
                strongestPlanetSign = chart!.moon.sign.keyName
            }  else  if strongestPlanet == "Mercury" {
                strongestPlanetSign = chart!.mercury.sign.keyName
            }  else  if strongestPlanet == "Venus" {
                strongestPlanetSign = chart!.venus.sign.keyName
            }  else  if strongestPlanet == "Mars" {
                strongestPlanetSign = chart!.mars.sign.keyName
            }  else  if strongestPlanet == "Jupiter" {
                strongestPlanetSign = chart!.jupiter.sign.keyName
            }  else  if strongestPlanet == "Saturn" {
                strongestPlanetSign = chart!.saturn.sign.keyName
            }  else  if strongestPlanet == "Uranus" {
                strongestPlanetSign = chart!.uranus.sign.keyName
            }  else  if strongestPlanet == "Neptune" {
                strongestPlanetSign = chart!.neptune.sign.keyName
            }  else  if strongestPlanet == "Pluto" {
                strongestPlanetSign = chart!.pluto.sign.keyName
              }  else  if strongestPlanet == "Mean South Node" {
                                 strongestPlanetSign = chart!.southNode.sign.keyName
                            }
               
               
               
               let sentence = generateAstroSentence(strongestPlanet: strongestPlanet!, strongestPlanetSign: strongestPlanetSign!, sunSign: chart!.sun.sign.keyName, moonSign: chart!.moon.sign.keyName, risingSign: chart!.houseCusps.ascendent.sign.keyName)
               // Initialize and push the StrongestPlanetViewController
               let strongestPlanetVC = StrongestPlanetViewController()
               strongestPlanetVC.chartCake = chartCake.self
               strongestPlanetVC.chart = chart.self
               strongestPlanetVC.strongestPlanet = strongestPlanet.self
               strongestPlanetVC.mostDiscordantPlanet = mostDiscordantPlanet.self
               strongestPlanetVC.mostHarmoniousPlanet = mostHarmoniousPlanet.self
               strongestPlanetVC.sentenceText = sentence.self
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
                 
    

func getStrongestPlanet(from scores: [String: Double]) -> String? {
    guard !scores.isEmpty else {
        return nil
    }
    
    var strongestPlanet: String = scores.keys.first!
    var strongestScore: Double = scores[strongestPlanet] ?? Double.nan
    
    for (planet, score) in scores {
        if score > strongestScore {
            strongestPlanet = planet
            strongestScore = score
        }
    }
    
    return strongestPlanet
}
    
    func getStrongestPlanet2(from scores: [(String, Double)]) -> String? {
        return scores.first?.0
    }


    func calculatePlanetsInHouses() -> [Int: [String]] {
        guard let chart = chart else {
            return [:]
        }

        var planetsInHouses: [Int: [String]] = [:]

        for body in chart.allBodies {
          let cusp = chart.houseCusps.cusp(for: body.longitude)
                
                let houseNumber = cusp.number

                if planetsInHouses[houseNumber] == nil {
                    planetsInHouses[houseNumber] = []
                }
                
                planetsInHouses[houseNumber]?.append(body.body.keyName)
            }
        

        return planetsInHouses
    }
    private func getHouseCusps2() -> [String] {
        
        let first = chart!.houseCusps.first.sign.keyName
        let second = chart!.houseCusps.second.sign.keyName
        let third = chart!.houseCusps.third.sign.keyName
        let fourth = chart!.houseCusps.fourth.sign.keyName
        let fifth = chart!.houseCusps.fifth.sign.keyName
        let sixth = chart!.houseCusps.sixth.sign.keyName
        let seventh = chart!.houseCusps.seventh.sign.keyName
        let eighth = chart!.houseCusps.eighth.sign.keyName
        let ninth = chart!.houseCusps.ninth.sign.keyName
        let tenth = chart!.houseCusps.tenth.sign.keyName
        let eleventh = chart!.houseCusps.eleventh.sign.keyName
        let twelfth = chart!.houseCusps.twelfth.sign.keyName
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }

    
    private func getHouseCusps() -> [Zodiac] {
        
        let first = chart!.houseCusps.first.sign
        let second = chart!.houseCusps.second.sign
        let third = chart!.houseCusps.third.sign
        let fourth = chart!.houseCusps.fourth.sign
        let fifth = chart!.houseCusps.fifth.sign
        let sixth = chart!.houseCusps.sixth.sign
        let seventh = chart!.houseCusps.seventh.sign
        let eighth = chart!.houseCusps.eighth.sign
        let ninth = chart!.houseCusps.ninth.sign
        let tenth = chart!.houseCusps.tenth.sign
        let eleventh = chart!.houseCusps.eleventh.sign
        let twelfth = chart!.houseCusps.twelfth.sign
        
        return [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth]
    }

    private func getInterceptedSigns() -> [String] {
        let houseCusps = getHouseCusps()
        var interceptedSigns: [String] = []

        for i in 0..<houseCusps.count {
            var currentCusp = houseCusps[i]
            let nextCusp = houseCusps[(i + 1) % houseCusps.count]
            
            while currentCusp != nextCusp {
                let nextZodiacIndex = (currentCusp.rawValue + 1) % 12
                if let nextZodiac = Zodiac(rawValue: nextZodiacIndex), nextZodiac != nextCusp {
                    interceptedSigns.append(nextZodiac.keyName)
                }
                currentCusp = Zodiac(rawValue: nextZodiacIndex) ?? .aries // Defaulting to .aries in case of error, update this as per your need
            }
        }
        
        return interceptedSigns
    }




//    @objc func calculateButtonTapped() {
//        guard let date = dateTextField.text?.toDate()?.date, let location = birthPlaceTextField.text else {
//            showAlert(withTitle: "Error", message: "Please enter valid birth date and place")
//            return
//        }
//    }


@objc func datePickerValueChanged() {
    // Ensure that UI updates are performed on the main thread
    DispatchQueue.main.async {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        dateFormatter.timeZone = self.birthPlaceTimeZone ?? TimeZone.current

        let dateString = dateFormatter.string(from: self.datePicker.date)
        self.dateTextField.text = dateString

    }
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

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showStrongestPlanet",
//           let strongestPlanetVC = segue.destination as? StrongestPlanetViewController,
//           let planets = sender as? (String, String, String, String) {
//
//            strongestPlanetVC.strongestPlanet = planets.0
//            strongestPlanetVC.mostHarmoniousPlanet = planets.1
//            strongestPlanetVC.mostDiscordantPlanet = planets.2
//            strongestPlanetVC.sentenceText = planets.3
//            strongestPlanetVC.chart = chart // Add this line to your code
//
//            strongestPlanetVC.getMajorProgresseDate = { [weak self] in
//                guard let self = self else {
//                    return Date()
//                }
//                // Replace `latitude`, `longitude`, and `self.birthPlaceTimeZone` with your actual values or variables
//                return self.getMajorProgresseDate(latitude: self.latitude!, longitude: self.longitude!, birthTimeZone: self.birthPlaceTimeZone!)
//            }
//
//            strongestPlanetVC.getMinors = { [weak self] in
//                return self?.getMinors() ?? Date()
//            }
//        } else if segue.identifier == "showChart",
//                  let chartViewerVC = segue.destination as? ChartViewController {
//
//            let planetsInHousesResult = calculatePlanetsInHouses()
//
//            chartViewerVC.chart = chart
//            chartViewerVC.scores2 = getTotalPowerScoresForPlanets2(birthChart: self.chart!, date: selectedDate!, ascDeclination: self.ascDeclination ?? 0.0, mcDeclination: self.mcDeclination ?? 0.0)
//            chartViewerVC.ascDeclination = self.ascDeclination
//            chartViewerVC.mcDeclination = self.mcDeclination
//            chartViewerVC.selectedDate = self.selectedDate
//            chartViewerVC.signScore = self.signScore
//            chartViewerVC.harmonyDiscordScores = getScoresAndDifferenceForPlanets(birthChart: self.chart!, date: selectedDate!, ascDeclination: self.ascDeclination ?? 0.0, mcDeclination: self.mcDeclination ?? 0.0)
//            chartViewerVC.scores = getTotalPowerScoresForPlanets(birthChart: self.chart!, date: selectedDate!, ascDeclination: self.ascDeclination ?? 0.0, mcDeclination: self.mcDeclination ?? 0.0)
//            chartViewerVC.houseScores = calculateHouseStrengths(birthChart: self.chart!, date: selectedDate!, ascDeclination: self.ascDeclination ?? 0.0, mcDeclination: self.mcDeclination ?? 0.0, houseCusps: getHouseCusps2(), interceptedSigns: getInterceptedSigns(), planetsInHouses: planetsInHousesResult)
//        }
//
//    }
//func eclipticToEquatorial(longitude: Double, obliquity: Double) -> (rightAscension: Double, declination: Double) {
//    let radLongitude = longitude * Double.pi / 180
//    let radObliquity = obliquity * Double.pi / 180
//
//
//    let ra = atan2(cos(radObliquity) * sin(radLongitude), cos(radLongitude))
//    let declination = asin(sin(radObliquity) * sin(radLongitude))
//
//    return (ra * 180 / Double.pi, declination * 180 / Double.pi)
//}
//
//func obliquity(julianDay: Double) -> Double {
//    let eps = UnsafeMutablePointer<Double>.allocate(capacity: 1)
//    swe_calc(julianDay, SE_ECL_NUT, 0, eps, nil)
//    let obliquity = eps.pointee
//    eps.deallocate()
//    return obliquity
//}

func getMostDiscordantPlanet(birthChart: Chart) -> String {
    let scoreDifferences = getHarmonyScoreDifferenceForPlanets(chart: chart!)
    
    var mostDiscordantPlanet: String = ""
    var maxScoreDifference = 0.0
    
    for (planet, scoreDifference) in scoreDifferences {
        if scoreDifference > maxScoreDifference {
            mostDiscordantPlanet = planet
            maxScoreDifference = scoreDifference
        }
    }
    
    return mostDiscordantPlanet
}

func getMostHarmoniousPlanet(from harmonyScoreDifferences: [String: Double]) -> String? {
    guard !harmonyScoreDifferences.isEmpty else {
        return nil
    }
    
    var mostHarmoniousPlanet: String = harmonyScoreDifferences.keys.first!
    var mostHarmoniousScore: Double = harmonyScoreDifferences[mostHarmoniousPlanet] ?? Double.nan
    
    for (planet, scoreDifference) in harmonyScoreDifferences {
        if scoreDifference > mostHarmoniousScore {
            mostHarmoniousPlanet = planet
            mostHarmoniousScore = scoreDifference
        }
    }
    
    return mostHarmoniousPlanet
}

func getMostDiscordantPlanet(from harmonyScoreDifferences: [String: Double]) -> String? {
    guard !harmonyScoreDifferences.isEmpty else {
        return nil
    }
    
    var mostDiscordantPlanet: String = harmonyScoreDifferences.keys.first!
    var mostDiscordantScore: Double = harmonyScoreDifferences[mostDiscordantPlanet] ?? Double.nan
    
    for (planet, scoreDifference) in harmonyScoreDifferences {
        if scoreDifference < mostDiscordantScore {
            mostDiscordantPlanet = planet
            mostDiscordantScore = scoreDifference
        }
    }
    
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

//func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    guard locations.last != nil else { return }
//    let rulingPlanet = rulingPlanet(at: Date(), location: locations.last!)
//
//    let planetaryHours: () = printPlanetaryHoursForTheDay(date: Date(), location: locations.first!)
//   //     print("Planetary Hour: \(rulingPlanet)")
//  //  print("Planetary Hour: \(planetaryHours)")
//}

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
    timeFormatter.timeZone = sender.timeZone // Use the timePicker's timezone
    let timeString = timeFormatter.string(from: selectedTime)
    birthTimeTextField.text = timeString
}


func combinedDateAndTime() -> Date? {
    let calendar = Calendar.current

    guard let birthPlaceTimeZone = birthPlaceTimeZone else {
        return nil // Return early if birthPlaceTimeZone is not set
    }

    var dateComponents = calendar.dateComponents(in: birthPlaceTimeZone, from: datePicker.date)
    let timeComponents = calendar.dateComponents(in: birthPlaceTimeZone, from: timePicker.date)

    dateComponents.hour = timeComponents.hour
    dateComponents.minute = timeComponents.minute

    return calendar.date(from: dateComponents)
}


func convertToLocalTime(fromDate date: Date, timeZone: TimeZone) -> Date {
    let localTimeZone = TimeZone.current

    let sourceOffset = TimeInterval(timeZone.secondsFromGMT(for: date)) / 60
    let localOffset = TimeInterval(localTimeZone.secondsFromGMT(for: date)) / 60

    let adjustedDate = date.addingTimeInterval((localOffset - sourceOffset) * 60)
    return adjustedDate
}


//func getDates() async -> BodiesRequest {
//
//    let request = BodiesRequest(body: Planet.moon.celestialObject)
//
//    // Asynchronously returns an array of `.sun` `Coordinate`s for every hour between now and 720 hours in the future.
//    _ = request.fetch(start: combinedDateAndTime()! - 1.days, end: combinedDateAndTime()! + 1.days, interval: 7200)
//    // Some async code
//    return BodiesRequest(body: Planet.moon.celestialObject)
//}



//func getMinors() -> Date {
//
//
//    let ProgressedDateInSec = Date().timeIntervalSince1970
//    let BirthDateInSec = combinedDateAndTime()!.timeIntervalSince1970
//
//
//    let minorProgressedTimeDifference = ProgressedDateInSec - BirthDateInSec
//
//    let minorPreLimitingDate = (minorProgressedTimeDifference * 27.3) / 365.25
//
//
//
//var minProgDateComponent = DateComponents()
//minProgDateComponent.second = Int(minorPreLimitingDate)
//
//    let minorProgDate = combinedDateAndTime()! + minProgDateComponent
////
//
//
//    return minorProgDate
//}

//func getMajorProgresseDate(latitude: Double, longitude: Double, birthTimeZone: TimeZone) -> Date {
//    //            let latitude = Double(placemark.location!.coordinate.longitude)
//    //            let longitude = Double(placemark.location!.coordinate.longitude)
//    
//    //    var birthTimeZone = TimeZone.current
//    let secondsFromGMT = birthTimeZone.secondsFromGMT(for: combinedDateAndTime()!)
//
//    //  let noonAtGMT = noonOnDob
//    let timeZone = secondsFromGMT / 60 / 60
//    //          let datePicker = datePicker
//    //          datePicker.timeZone = TimeZone(identifier:  birthTimeZone.description)
//    //  let datePicker = myBirthDate()
//    _ = timeZone
//
//    let birthTimeMeridian = -timeZone * 15
//
//
//    //  The Dominant Factor
//
//    //  Find LMT (Local Mean Time)
//
//    //Rule 8. When Standard Time is given to find the L.M.T. at a place WEST of a Standard Meridian multiply the ° distant from the standard by 4, calling the result minutes, multiply
//
//    //    Standard Time = 1:30 am
//    //      distance from Standard Meridian = 105 degrees
//    //    105 x 4 = 420 minutes
//
//
//    let standardTimeAtBirth = combinedDateAndTime()!
//    let standardMeridian = 0
//    let birthLongitude = longitude - Double(standardMeridian)
//    _ = birthLongitude * 4
//    
//    let meridianOffSet = Double(birthTimeMeridian) - birthLongitude
//    let egmt = meridianOffSet * 4
//    
//    let timeZoneAtBirth = (birthTimeMeridian / 15) * 60
//    
//    
//    let  preLMToffset = meridianOffSet * 4
//
//    let EGMTIntervals = standardTimeAtBirth + timeZoneAtBirth.hours
//    
//    let LMToffset =  preLMToffset * 60
//    
//    _ = standardTimeAtBirth + Int(LMToffset).seconds
//    
//
//
//    //          Step IV. How to Find the E.G.M.T. INTERVAL
//
//
//    //          Rule 14. To find the difference in time between the place of birth and Greenwich, multiply the ° distant in longitude from Greenwich by 4, calling the product minutes, and multiply the ′ by 4, calling the product seconds. Convert into hours and minutes.
//    
//    //    420 minutes  = 7 hours
//
//
//    let distanceFromGMTInSeconds = (longitude * 4) * 60
//
//    _ = distanceFromGMTInSeconds / 60 / 60
//
//    //  Rule 15. Divide the ° by 15. The quotient is hours, the remainder multiplied by 4 is minutes.
//
//
//    _ = longitude / 15
//
//
//    _ = egmt.formatted // May 26, 2022, 8:16 PM          newFormatter.timeZone =  TimeZone(abbreviation: "UTC")
//
//
//
//    //          If the EGMT Interval of birth is minus, add the calendar interval thus found to the year and month of birth. If the EGMT Interval of birth is plus, subtract the calendar interval thus found from the year, month and day of birth. The L.D. thus found is the calendar starting point from which all major-progressed aspects and positions are calculated.
//
//    let noonOnDobInput = combinedDateAndTime()!
//    let NoonInterval = noonOnDobInput.dateBySet(hour: 12, min: 00, secs: 00)
//
//    // convert Date to TimeInterval (typealias for Double)
//    let timeInterval1 = NoonInterval
//
//    // convert to Integer
//    _ = timeInterval1
//
//
//    let timeInterval2 = NoonInterval!.timeIntervalSince1970
//
//    // convert to Integer
//    _ = Int(timeInterval2)
//
//
//    let EGMTInterval = NoonInterval!.timeIntervalSince1970 - EGMTIntervals.timeIntervalSince1970
//
//    
//    _ = NoonInterval! - EGMTIntervals
//    
//    //
//    //          Finding the Limiting Date
//
//    //  The Limiting Date (abbreviated L.D.) is the date in calendar time corresponding to the major-progressed positions of the planets on the day of birth as they are shown in the ephemeris. Convert the EGMT Interval of birth into months and days of calendar time by dividing the hours by 2 and calling the result months, and dividing the minutes by 4 and calling the result days.
//
//
//    let LDinSeconds = Double(EGMTInterval/2) * 730.0
//
//
//    _ = EGMTInterval
//
//    //
//    //            var LimitingDate = limitingDateNumber * 60
//
//    let limitingDate = Date(timeInterval: LDinSeconds, since: combinedDateAndTime()!)
//
//
//    let timeCorrectionMins = abs(timeZone) * 60
//
//    _ = abs(timeCorrectionMins) * 60
//
//
//
//    //          The Major Progression Date (abbreviated Map.D.) is the ephemeris day which shows the major-progressed positions of the planets for the month and day of the Limiting Date, but for some calendar year.
//
//
//    //          To find the Map.D. for any calendar year, count ahead in the ephemeris from the day of birth as many days as complete years have elapsed since the Limiting Date. The ephemeris day so located is the required Map.D.
//
//
//    let progressionDate = Date().timeIntervalSince1970
//    let natalDate = combinedDateAndTime()!.timeIntervalSince1970
//    let progressedDifference = progressionDate - natalDate
//
//    //
//    let preLimitingDate = progressedDifference / 365.25
//    _ = progressedDifference * 0.000011574074074
//
//    var dateComponent = DateComponents()
//    dateComponent.day = 1
//    let futureDate = Calendar.current.date(byAdding: dateComponent, to: limitingDate)
//
//
//    var birthDateComponent = DateComponents()
//    birthDateComponent.second = Int(preLimitingDate)
//    let dayAfterBirth = Calendar.current.date(byAdding: birthDateComponent, to: combinedDateAndTime()!)
//
//    _ = futureDate
//
//   
//    let MapD = dayAfterBirth
//
// 
//    
//    return MapD!
//}
//


}



