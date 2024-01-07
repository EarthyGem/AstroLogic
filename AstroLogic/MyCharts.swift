import UIKit
import SwiftEphemeris
import CoreData
import SystemConfiguration



class ChartsViewController: UIViewController {

    var tableView: UITableView!
    var charts: [ChartEntity] = []
    var strongestPlanetSign: String?
    var birthPlace: String?
    var birthPlaceTimeZone: TimeZone?
    var chartDate: Date?
 
    var toggleSwitch: UISwitch!
    @IBAction func importButtonTapped(_ sender: UIBarButtonItem) {
        // Code to navigate to the new import screen
        let importVC = ImportAAFViewController()
        self.navigationController?.pushViewController(importVC, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Create and configure the UISwitch
         toggleSwitch = UISwitch()
        toggleSwitch.isOn = false // Set the initial state to "on"// Set the initial state as needed
         toggleSwitch.addTarget(self, action: #selector(toggleSwitchChanged(sender:)), for: .valueChanged)

         // Create a UIBarButtonItem with the UISwitch
         let switchBarButtonItem = UIBarButtonItem(customView: toggleSwitch)
        switchBarButtonItem.title = "Include SN"

         // Set the UIBarButtonItem as the right bar button item
         navigationItem.rightBarButtonItem = switchBarButtonItem

       

//        let importButton = UIBarButtonItem(title: "Import AAF", style: .plain, target: self, action: #selector(importButtonTapped))
//           self.navigationItem.rightBarButtonItem = importButton

       // processDetails()
            //deleteAllNames()
        setupTableView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        charts = fetchAllCharts()
        //  deleteAllNames()
        tableView.reloadData()
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


    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: "chartCell")

        // Adjust constraints if you have navigation bars, tab bars, etc.
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.view.addSubview(tableView)
    }
    func fetchTimeZone(latitude: Double, longitude: Double, timestamp: Int, completion: @escaping (TimeZone?) -> Void) {
        // Check for network availability
        if !isNetworkAvailable() {
            completion(nil)
            return
        }

        let API_KEY = "AIzaSyA5sA9Mz9AOMdRoHy4ex035V3xsJxSJU_8" // Note: Never hard-code API keys in production apps. Use environment variables or secure storage.
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/timezone/json?location=\(latitude),\(longitude)&timestamp=\(timestamp)&key=\(API_KEY)") else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }

            if let error = error {
                // Handle the error, e.g., no internet connection
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
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
                print("JSON parsing error: \(error.localizedDescription)")
                self.birthPlaceTimeZone = nil
                completion(nil)
            }
        }
        task.resume()
    }

    // Utility function to check network availability
    func isNetworkAvailable() -> Bool {
       var zeroAddress = sockaddr_in()
       zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
       zeroAddress.sin_family = sa_family_t(AF_INET)

       let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
           $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
               SCNetworkReachabilityCreateWithAddress(nil, $0)
           }
       }

       var flags: SCNetworkReachabilityFlags = []
       if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
           return false
       }
       let isReachable = flags.contains(.reachable)
       let needsConnection = flags.contains(.connectionRequired)

       if !(isReachable && !needsConnection) {
           DispatchQueue.main.async {
               let alertController = UIAlertController(title: "No Network Connection", message: "This app requires a network connection to work correctly. Please disable Airplane Mode or connect to Wi-Fi.", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alertController.addAction(okAction)
               self.present(alertController, animated: true, completion: nil)
           }
       }

       return (isReachable && !needsConnection)
    }

    func deleteAllNames() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext

        // 1. Delete all entities from Core Data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChartEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)

            // 2. Update the `charts` array
            charts = []

            // 3. Reload the table view
            tableView.reloadData()
        } catch {
            print("Failed to delete all charts: \(error.localizedDescription)")
        }
    }


    func fetchAllCharts() -> [ChartEntity] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ChartEntity>(entityName: "ChartEntity")

        do {
            let charts = try context.fetch(fetchRequest)
            return charts
        } catch {
            print("Failed to fetch charts: \(error.localizedDescription)")
            return []
        }
    }

    func deleteChart(at indexPath: IndexPath) {
           let chartToDelete = charts[indexPath.row]
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
           let context = appDelegate.persistentContainer.viewContext
           context.delete(chartToDelete)
           do {
               try context.save()
               charts.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)

           } catch {
               print("Failed to delete chart: \(error.localizedDescription)")
           }
       }


    func getStrongestPlanet(from scores: [CelestialObject: Double]) -> CelestialObject {
        // Exclude the South Node from consideration
        var filteredScores = scores
        filteredScores.removeValue(forKey: LunarNode.meanSouthNode.celestialObject)

        let sorted = filteredScores.sorted { $0.value > $1.value }
        let strongestPlanet = sorted.first!.key

        return strongestPlanet
    }

    func getMostHarmoniousPlanet(from scores: [CelestialObject: (harmony: Double, discord: Double, net: Double)]) -> CelestialObject {
        // Exclude the South Node from consideration
        var filteredScores = scores
        filteredScores.removeValue(forKey: LunarNode.meanSouthNode.celestialObject)

        let sorted = filteredScores.sorted { $0.value.net > $1.value.net }
        let mostHarmoniousPlanet = sorted.first!.key

        return mostHarmoniousPlanet
    }

    func getMostDiscordantPlanet(from scores: [CelestialObject: (harmony: Double, discord: Double, net: Double)]) -> CelestialObject {
        // Exclude the South Node from consideration
        var filteredScores = scores
        filteredScores.removeValue(forKey: LunarNode.meanSouthNode.celestialObject)

        let sorted = filteredScores.sorted { $0.value.net < $1.value.net }
        let mostDiscordantPlanet = sorted.first!.key

        return mostDiscordantPlanet
    }


}
// MARK: - UITableViewDataSource and UITableViewDelegate
extension ChartsViewController: UITableViewDataSource, UITableViewDelegate {

    func navigateToEditScreen(for chart: ChartEntity?) {
          // Here, you would instantiate the view controller responsible for editing a ChartEntity,
          // then push it onto the navigation stack.

          guard let chart = chart else { return }

          let editVC = EditChartViewController() // assuming you have a view controller named EditChartViewController
          editVC.chartToEdit = chart // assuming you have a property in EditChartViewController to hold the chart being edited

          self.navigationController?.pushViewController(editVC, animated: true)
      }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartTableViewCell // Assume you've created a custom cell

        let chart = charts[indexPath.row]



        let chartDate = chart.birthDate!
        let latitude = chart.latitude
        let longitude = chart.longitude
        let timestamp = Int(chartDate.timeIntervalSince1970)
        let chartObj = Chart(date: chartDate, latitude: latitude, longitude: longitude, houseSystem: .placidus)
        
        let scores = chartObj.getTotalPowerScoresForPlanets()
        let strongestPlanet = getStrongestPlanet(from: scores)
        let place = chart.birthPlace ?? "No BirthPlace"
        // Set the cell label

        // Set the cell image
        let imageName = strongestPlanet.keyName.lowercased()
        cell.planetImageView.image = UIImage(named: imageName)




       cell.textLabel?.text = "\(chart.name!) \(chart.birthDate!)"

          fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: timestamp) { timeZone in
              DispatchQueue.main.async {
                  if let timeZone = timeZone {
                      let formattedDate = self.formatDate(chartDate, withTimeZone: timeZone)
                      let dateAndPlace = "\(formattedDate)"
                      let nameString = NSAttributedString(string: "\(chart.name!) ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
                      let dateAndPlaceString = NSAttributedString(string: dateAndPlace, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])

                      let combinedAttributedString = NSMutableAttributedString()
                      combinedAttributedString.append(nameString)
                      combinedAttributedString.append(dateAndPlaceString)

                      cell.textLabel?.attributedText = combinedAttributedString
                      cell.layoutIfNeeded()  // Force layout update
                  }
              }
          }

          return cell
      }
    func formatDate(_ date: Date, withTimeZone timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: date)
    }

    // Your other tableView functions like didSelectRowAt can remain the same...


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let otherChart = charts[indexPath.row]

        // We assume that your ChartEntity has properties like latitude, longitude, birthDate, name, etc.
        // Otherwise, adapt accordingly.
        let latitude = otherChart.latitude
        let longitude = otherChart.longitude
        let chartDate = otherChart.birthDate
        let name = otherChart.name ?? ""
        let birthPlace = otherChart.birthPlace ?? "No BirthPlace"
        let chart = Chart(date: chartDate!, latitude: latitude, longitude: longitude, houseSystem: .placidus)
        let chartCake = ChartCake(birthDate: chartDate!, latitude: latitude, longitude: longitude)!
        let timestamp = Int(chartDate?.timeIntervalSince1970 ?? 34)

        var bodiesArgument: [Coordinate]? = (toggleSwitch.isOn) ? chart.rickysBodies : nil

        
 
    let scores = chart.getTotalPowerScoresForPlanets(bodiesArgument)
        let signHarmonyScores = chart.calculateTotalSignHarmonyDiscord(bodiesArgument)
        
        let houseHarmonyScores = chart.calculateHouseHarmonyDiscord(bodiesArgument)
        let houseScores = chart.calculateHouseStrengths(bodiesArgument)
        let signScores = chart.calculateTotalSignScore(bodiesArgument)
        // Comment this next line out when the toggleSwitch is wired up
      //  let scores = chart.getTotalPowerScoresForPlanets()
        let strongestPlanet = getStrongestPlanet(from: scores)

        fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: timestamp) { [self] timeZone in
            DispatchQueue.main.async { [self] in
                if let timeZone = timeZone {
                    let formattedDate = self.formatDate(chartDate!, withTimeZone: timeZone)
                    let dateAndPlace = "\(formattedDate)"
                    let nameString = NSAttributedString(string: "\(name) ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
                    let dateAndPlaceString = NSAttributedString(string: dateAndPlace, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])

                    let combinedAttributedString = NSMutableAttributedString()
                    combinedAttributedString.append(nameString)
                    combinedAttributedString.append(dateAndPlaceString)


                    let tuple = chart.getTotalHarmonyDiscordScoresForPlanets(bodiesArgument)
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

                    // Initialize and push the StrongestPlanetViewController
                    let strongestPlanetVC = StrongestPlanetViewController()
                    strongestPlanetVC.chartCake = chartCake
                    strongestPlanetVC.chart = chart
                    strongestPlanetVC.strongestPlanet = getStrongestPlanet(from: scores).keyName
                    strongestPlanetVC.strongestPlanetArchetype = getStrongestPlanet(from: scores).archetype
                    strongestPlanetVC.name = name
                    strongestPlanetVC.harmonyDiscordtuple = tuple
                    strongestPlanetVC.scores = scores
                    strongestPlanetVC.charts = charts
                    strongestPlanetVC.birthPlace = birthPlace
                    strongestPlanetVC.birthDate = chartDate
                    //  strongestPlanetVC.combinedBirthDateTime = chartDate
                    strongestPlanetVC.tarot = getStrongestPlanet(from: scores).tarot
                    strongestPlanetVC.disTarot = mostDiscordantPlanet.tarot
                    strongestPlanetVC.harTarot = mostHarmoniousPlanet.tarot
                    strongestPlanetVC.mostDiscordantPlanet = mostDiscordantPlanet.keyName
                    strongestPlanetVC.mostHarmoniousPlanet = mostHarmoniousPlanet.keyName
                    strongestPlanetVC.mostDiscordantPlanetArchetype = mostDiscordantPlanet.archetype
                    strongestPlanetVC.mostHarmoniousPlanetArchetype = mostHarmoniousPlanet.archetype
                    strongestPlanetVC.strongestPlanetSign = strongestPlanetSign
                    strongestPlanetVC.signHarmonyDisharmony = signHarmonyScores
                    strongestPlanetVC.houseHarmonyDisharmony = houseHarmonyScores
                    strongestPlanetVC.houseScores = houseScores
                    strongestPlanetVC.signScores = signScores
                    strongestPlanetVC.sentenceText = sentence
                    strongestPlanetVC.dateString = dateAndPlace
                    strongestPlanetVC.latitude = latitude
                    strongestPlanetVC.longitude = longitude
                    self.navigationController?.pushViewController(strongestPlanetVC, animated: true)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let editAction = UIContextualAction(style: .normal, title: "Edit") { [self] (contextualAction, view, success: @escaping (Bool) -> Void) in
            editChart(at: indexPath)
            success(true)
        }
        editAction.backgroundColor = .blue  // or any color you prefer for edit

        return UISwipeActionsConfiguration(actions: [editAction])
    }




      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

          let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, success: @escaping (Bool) -> Void) in
                self.deleteChart(at: indexPath)
                success(true)
            }
            deleteAction.backgroundColor = .red  // or any color you prefer for delete

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }



    func editChart(at indexPath: IndexPath) {
        let chartToEdit = charts[indexPath.row]
        let editChartVC = EditChartViewController()
        editChartVC.chartToEdit = chartToEdit
        self.navigationController?.pushViewController(editChartVC, animated: true)
    }


    }
