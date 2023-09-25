import UIKit
import SwiftEphemeris
import CoreData



class ChartsViewController: UIViewController {

    var tableView: UITableView!
    var charts: [ChartEntity] = []
    var strongestPlanetSign: String?
    var birthPlace: String?
    var birthPlaceTimeZone: TimeZone?
    var chartDate: Date?
    
    @IBAction func importButtonTapped(_ sender: UIBarButtonItem) {
        // Code to navigate to the new import screen
        let importVC = ImportAAFViewController()
        self.navigationController?.pushViewController(importVC, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let importButton = UIBarButtonItem(title: "Import AAF", style: .plain, target: self, action: #selector(importButtonTapped))
           self.navigationItem.rightBarButtonItem = importButton

        processDetails()
       
        setupTableView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        charts = fetchAllCharts()
        //  deleteAllNames()
        tableView.reloadData()
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
        let API_KEY = "AIzaSyA5sA9Mz9AOMdRoHy4ex035V3xsJxSJU_8" // Note: Never hard-code API keys in production apps. Use environment variables or secure storage.
        let url = URL(string: "https://maps.googleapis.com/maps/api/timezone/json?location=\(latitude),\(longitude)&timestamp=\(timestamp)&key=\(API_KEY)")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in


            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
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
        } catch {
            print("Failed to delete chart: \(error.localizedDescription)")
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

}
// MARK: - UITableViewDataSource and UITableViewDelegate
extension ChartsViewController: UITableViewDataSource, UITableViewDelegate {

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
        _ = chart.birthPlace ?? "No BirthPlace"
        // Set the cell label

        // Set the cell image
        let imageName = strongestPlanet.keyName.lowercased()
        cell.planetImageView.image = UIImage(named: imageName)


        

        cell.textLabel?.text = "\(chart.name!) \(chart.birthDate!) \(chart.birthPlace!)"

          fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: timestamp) { timeZone in
              DispatchQueue.main.async {
                  if let timeZone = timeZone {
                      let formattedDate = self.formatDate(chartDate, withTimeZone: timeZone)
                      let dateAndPlace = "\(formattedDate) \(chart.birthPlace!)"
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
            let chartCake = ChartCake(birthDate: chartDate!, latitude: latitude, longitude: longitude)

            let scores = chart.getTotalPowerScoresForPlanets()
            let strongestPlanet = getStrongestPlanet(from: scores)



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

            // Initialize and push the StrongestPlanetViewController
            let strongestPlanetVC = StrongestPlanetViewController()
            strongestPlanetVC.chartCake = chartCake
            strongestPlanetVC.chart = chart
            strongestPlanetVC.strongestPlanet = getStrongestPlanet(from: scores).keyName
            strongestPlanetVC.name = name
            strongestPlanetVC.birthPlace = birthPlace
            //  strongestPlanetVC.combinedBirthDateTime = chartDate
            strongestPlanetVC.tarot = getStrongestPlanet(from: scores).tarot
            strongestPlanetVC.disTarot = mostDiscordantPlanet.tarot
            strongestPlanetVC.harTarot = mostHarmoniousPlanet.tarot
            strongestPlanetVC.mostDiscordantPlanet = mostDiscordantPlanet.keyName
            strongestPlanetVC.mostHarmoniousPlanet = mostHarmoniousPlanet.keyName
            strongestPlanetVC.strongestPlanetSign = strongestPlanetSign
            strongestPlanetVC.sentenceText = sentence
            self.navigationController?.pushViewController(strongestPlanetVC, animated: true)
        }

    }


