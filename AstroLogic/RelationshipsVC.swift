import UIKit
import CoreData
import SwiftEphemeris

class RelationshipsViewController: UIViewController, UITableViewDataSource, RelationshipSelectionDelegate {
    
    // Define your table view
    private var tableView: UITableView!
    var relationships: [Relationships] = []
    var selectedName: String?
    var name: String?
    var selectedChart: ChartCake?
    var natalChart: ChartCake?
    var charts: [ChartEntity] = []
    var strongestPlanetSign: String?
    var strongestPlanet: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        charts = fetchAllCharts()
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
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
    
    
    
    @objc private func addButtonTapped() {
      
        
        // Before pushing the AddRelationshipViewController
        let addViewController = AddRelationshipViewController()
        addViewController.natalChart = natalChart // Assign the value here
        navigationController?.pushViewController(addViewController, animated: true)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartTableViewCell // Assume you've created a custom cell
            
            let chart = charts[indexPath.row]
            
            let chartDate = chart.birthDate!
            let latitude = chart.latitude
            let longitude = chart.longitude
            let chartObj = Chart(date: chartDate, latitude: latitude, longitude: longitude, houseSystem: .placidus)
            let scores = chartObj.getTotalPowerScoresForPlanets()
            let strongestPlanet = getStrongestPlanet(from: scores)
            
            // Set the cell label
            cell.textLabel?.text = chart.name
            
            // Set the cell image
            let imageName = strongestPlanet.keyName.lowercased()
            cell.planetImageView.image = UIImage(named: imageName)
            
        return cell
    }
    
    // MARK: - RelationshipSelectionDelegate
    
    func didSelectRelationship(_ relationship: Relationships) {
        // Handle the selection of a relationship item
    }
}

extension RelationshipsViewController: AddRelationshipDelegate {
    func addRelationship(_ relationship: Relationships, chart: ChartCake, natalChart: ChartCake) {
      relationship.chartCake = chart
     
    
      relationships.append(relationship)
      tableView.reloadData()
  }
}
    
    // Implement any other required methods of the AddRelationshipDelegate if applicable


extension RelationshipsViewController: UITableViewDelegate {


  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChart = charts[indexPath.row]

        // We assume that your ChartEntity has properties like latitude, longitude, birthDate, name, etc.
        // Otherwise, adapt accordingly.
        let latitude = selectedChart.latitude
        let longitude = selectedChart.longitude
        let chartDate = selectedChart.birthDate
        let name = selectedChart.name ?? ""

        let chart = Chart(date: chartDate!, latitude: latitude, longitude: longitude, houseSystem: .placidus)
        let chartCake = ChartCake(birthDate: chartDate!, latitude: latitude, longitude: longitude)

        let scores = chartCake!.getTotalPowerScoresForPlanets()
        let strongestPlanet = getStrongestPlanet(from: scores)

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

        // Initialize and push the StrongestPlanetViewController
        let strongestPlanetVC = OthersStrongestPlanetViewController()
        strongestPlanetVC.chartCake = chartCake
        strongestPlanetVC.chart = chart
        strongestPlanetVC.strongestPlanet = getStrongestPlanet(from: scores).keyName
        strongestPlanetVC.name = name
     //   strongestPlanetVC.selectedName = selectedName
        //
        strongestPlanetVC.mostDiscordantPlanet = mostDiscordantPlanet.keyName
        strongestPlanetVC.mostHarmoniousPlanet = mostHarmoniousPlanet.keyName
        strongestPlanetVC.sentenceText = sentence
        self.navigationController?.pushViewController(strongestPlanetVC, animated: true)
    }
}

