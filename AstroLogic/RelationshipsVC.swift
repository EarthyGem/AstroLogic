import UIKit
import CoreData
import SwiftEphemeris

class RelationshipsViewController: UIViewController, UITableViewDataSource, RelationshipSelectionDelegate {


    private var tableView: UITableView!
    var relationships: [Relationships] = []
    var selectedName: String?
    var name: String?
    var otherChart: ChartCake?
    var charts: [ChartEntity] = []
    var strongestPlanetSign: String?
    var strongestPlanet: String?
    var chartCake: ChartCake?
    var shouldRefreshData = true
    var birthDate: Date!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
        
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
        addViewController.otherChart = otherChart // Assign the value here
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

            let selectedChart = charts[indexPath.row]

            let chartDate = selectedChart.birthDate!
            let latitude = selectedChart.latitude
        let longitude = selectedChart.longitude
        let name = selectedChart.name
        otherChart = ChartCake(birthDate: chartDate, latitude: latitude, longitude: longitude)
        let scores = otherChart!.getTotalPowerScoresForPlanets()
            let strongestPlanet = getStrongestPlanet(from: scores)

            // Set the cell label
            cell.textLabel?.text = name

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
    func addRelationship(_ relationship: Relationships, chart: ChartCake, chartCake: ChartCake) {
      relationship.chartCake = chartCake


      relationships.append(relationship)
      tableView.reloadData()
  }
}


extension RelationshipsViewController: UITableViewDelegate {



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntity = charts[indexPath.row]

        // We assume that your ChartEntity has properties like latitude, longitude, birthDate, name, etc.
        // Otherwise, adapt accordingly.
        let latitude = selectedEntity.latitude
          let longitude = selectedEntity.longitude
          let chartDate = selectedEntity.birthDate!
          let name = selectedEntity.name ?? ""

        let otherChart = ChartCake(birthDate: chartDate, latitude: latitude, longitude: longitude)
        let synastry = SynastryChartCake(birthDate: chartDate, otherBirthDate: birthDate, latitude: latitude, longitude: longitude)

        let scores = otherChart!.getTotalPowerScoresForPlanets()
        let strongestPlanet = getStrongestPlanet(from: scores)

        // let signScore = self.chart.natal.calculateTotalSignScore()
        // let houseStrengths = self.chart.natal.calculatePlanetInHouseScores()
        // let houseScores = self.chart.natal.calculateHouseStrengths()

        let tuple = otherChart!.getTotalHarmonyDiscordScoresForPlanets()
        let mostDiscordantPlanet = getMostDiscordantPlanet(from: tuple)
        let mostHarmoniousPlanet = getMostHarmoniousPlanet(from: tuple)

        if strongestPlanet == Planet.sun.celestialObject {
            strongestPlanetSign = otherChart!.natal.sun.sign.keyName
        } else if strongestPlanet == Planet.moon.celestialObject {
            strongestPlanetSign = otherChart!.natal.moon.sign.keyName
        } else if strongestPlanet == Planet.mercury.celestialObject {
            strongestPlanetSign = otherChart!.natal.mercury.sign.keyName
        } else if strongestPlanet == Planet.venus.celestialObject {
            strongestPlanetSign = otherChart!.natal.venus.sign.keyName
        } else if strongestPlanet == Planet.mars.celestialObject {
            strongestPlanetSign = otherChart!.natal.mars.sign.keyName
        } else if strongestPlanet == Planet.jupiter.celestialObject {
            strongestPlanetSign = otherChart!.natal.jupiter.sign.keyName
        } else if strongestPlanet == Planet.saturn.celestialObject {
            strongestPlanetSign = otherChart!.natal.saturn.sign.keyName
        } else if strongestPlanet == Planet.uranus.celestialObject {
            strongestPlanetSign = otherChart!.natal.uranus.sign.keyName
        } else if strongestPlanet == Planet.neptune.celestialObject {
            strongestPlanetSign = otherChart!.natal.neptune.sign.keyName
        } else if strongestPlanet == Planet.pluto.celestialObject {
            strongestPlanetSign = otherChart!.natal.pluto.sign.keyName
        } else if strongestPlanet == LunarNode.meanSouthNode.celestialObject {
            strongestPlanetSign = otherChart!.natal.southNode.sign.keyName
        }

        let sentence = generateAstroSentence(strongestPlanet: strongestPlanet.keyName,
                                             strongestPlanetSign: strongestPlanetSign!,
                                             sunSign: otherChart!.natal.sun.sign.keyName,
                                             moonSign: otherChart!.natal.moon.sign.keyName,
                                             risingSign: otherChart!.natal.houseCusps.ascendent.sign.keyName, name: name)

        // Initialize and push the StrongestPlanetViewController
        let strongestPlanetVC = OthersStrongestPlanetViewController()
        strongestPlanetVC.chartCake = chartCake
        strongestPlanetVC.otherChart = otherChart
        strongestPlanetVC.strongestPlanet = getStrongestPlanet(from: scores).keyName
        strongestPlanetVC.name = name
        strongestPlanetVC.birthDate = birthDate
     //   strongestPlanetVC.selectedName = selectedName
        //
        strongestPlanetVC.mostDiscordantPlanet = mostDiscordantPlanet.keyName
        strongestPlanetVC.mostHarmoniousPlanet = mostHarmoniousPlanet.keyName
        strongestPlanetVC.sentenceText = sentence
        strongestPlanetVC.synastry = synastry
        self.navigationController?.pushViewController(strongestPlanetVC, animated: true)
    }
}
