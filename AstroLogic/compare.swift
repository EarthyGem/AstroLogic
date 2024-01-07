import UIKit
import CoreData
import SwiftEphemeris

class RelationshipsViewController2: UIViewController, UITableViewDataSource, RelationshipSelectionDelegate {


    private var tableView: UITableView!
    var relationships: [Relationships] = []
    var selectedName: String?
    var name: String?
    var otherChart: ChartCake?
    var otherName: String?
    var charts: [ChartEntity]?
    var strongestPlanetSign: String?
    var strongestPlanet: String?
    var chartCake: ChartCake?
    var shouldRefreshData = true
    var birthDate: Date!


    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()


            // Data has not been pre-fetched
            charts = fetchAllCharts()


        // Reload the table view with either pre-fetched or freshly fetched data
        tableView.reloadData()
    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: "chartCell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(tableView)
    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if shouldRefreshData {
            fetchAllCharts()
            shouldRefreshData = false
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
        addViewController.otherName = otherName
        navigationController?.pushViewController(addViewController, animated: true)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charts!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartTableViewCell // Assume you've created a custom cell

        let selectedChart = charts![indexPath.row]

            let chartDate = selectedChart.birthDate!
            let latitude = selectedChart.latitude
        let longitude = selectedChart.longitude
        let otherName = selectedChart.name
        otherChart = ChartCake(birthDate: chartDate, latitude: latitude, longitude: longitude)
        let scores = otherChart!.getTotalPowerScoresForPlanets()
            let strongestPlanet = getStrongestPlanet(from: scores)

            // Set the cell label
            cell.textLabel?.text = otherName

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

extension RelationshipsViewController2: AddRelationshipDelegate {
    func addRelationship(_ relationship: Relationships, chart: ChartCake, chartCake: ChartCake) {
      relationship.chartCake = chartCake


      relationships.append(relationship)
      tableView.reloadData()
  }
}


extension RelationshipsViewController2: UITableViewDelegate {



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntity = charts![indexPath.row]

        // We assume that your ChartEntity has properties like latitude, longitude, birthDate, name, etc.
        // Otherwise, adapt accordingly.
        let latitude = selectedEntity.latitude
        let longitude = selectedEntity.longitude
        let chartDate = selectedEntity.birthDate!
        let otherName = selectedEntity.name ?? ""

        let otherChart = ChartCake(birthDate: chartDate, latitude: latitude, longitude: longitude)
        let synastry = SynastryChartCake(birthDate: chartDate, otherBirthDate: birthDate, latitude: latitude, longitude: longitude, name1: "\(name)", name2: "\(otherName)'s")



        // Initialize and push the StrongestPlanetViewController
        let strongestPlanetVC = OthersStrongestPlanetViewController()
        strongestPlanetVC.chartCake = chartCake
        strongestPlanetVC.otherChart = otherChart
        //  strongestPlanetVC.strongestPlanet = getStrongestPlanet(from: scores).keyName
        strongestPlanetVC.otherName = otherName
        strongestPlanetVC.name = name
        strongestPlanetVC.birthDate = birthDate
        //   strongestPlanetVC.selectedName = selectedName
        //
        //        strongestPlanetVC.mostDiscordantPlanet = mostDiscordantPlanet.keyName
        //        strongestPlanetVC.mostHarmoniousPlanet = mostHarmoniousPlanet.keyName
        //        strongestPlanetVC.sentenceText = sentence
        strongestPlanetVC.synastry = synastry
        self.navigationController?.pushViewController(strongestPlanetVC, animated: true)
    }

}
