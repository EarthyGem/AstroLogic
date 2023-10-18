


import SwiftEphemeris
import UIKit
import CoreLocation

class CycleChartsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var minorProgressedSigns: [String] = []
    var getMinors: (() -> Date)?
    var minorsChartView: MinorsBiWheelChartView!
    var chart: Chart?
    var chartCake: ChartCake?

    // Location manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var transitSigns: [String] = []
    var cyclePlanets: [Coordinate] = []
    var selectedDate: Date?


    static var currentDate: Date {
        let dobDate = Date()
        return dobDate
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            manager.stopUpdatingLocation()
        }
    }

    // Error handling
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }

    // transitChart now uses the device's current location


    var planetGlyphs = ["sun","moon","mercury","venus","mars","jupiter","saturn","uranus","neptune","pluto","southnode","ascendant", "midheaven"]

    func setupTransitSigns() -> [String] {
        transitSigns = [
            chartCake?.natal.sun.sign.keyName,
            chartCake?.natal.moon.sign.keyName,
            chartCake?.natal.mercury.sign.keyName,
            chartCake?.natal.venus.sign.keyName,
            chartCake?.natal.mars.sign.keyName,
            chartCake?.natal.jupiter.sign.keyName,
            chartCake?.natal.saturn.sign.keyName,
            chartCake?.natal.uranus.sign.keyName,
            chartCake?.natal.neptune.sign.keyName,
            chartCake?.natal.pluto.sign.keyName,
            chartCake?.natal.southNode.sign.keyName,
            chartCake?.natal.ascendant.sign.keyName,
            chartCake?.natal.midheaven.sign.keyName
        ].compactMap { $0 } // This will remove any nil values from the array



        // This will remove any nil values from the array

        return minorProgressedSigns
    }

    func getTransitPositions() -> [String] {
        minorProgressedSigns = [
            chartCake?.natal.sun.formatted,
            chartCake?.natal.moon.formatted,
            chartCake?.natal.ascendant.formatted,
            chartCake?.natal.mercury.formatted,
            chartCake?.natal.venus.formatted,
            chartCake?.natal.mars.formatted,
            chartCake?.natal.jupiter.formatted,
            chartCake?.natal.saturn.formatted,
            chartCake?.natal.uranus.formatted,
            chartCake?.natal.neptune.formatted,
            chartCake?.natal.pluto.formatted,
            chartCake?.natal.southNode.formatted,
            chartCake?.natal.ascendant.formatted,
            chartCake?.natal.midheaven.formatted
        ].compactMap { $0 } // This will remove any nil values from the array



        // This will remove any nil values from the array

        return minorProgressedSigns
    }

    let mundaneAstrologyImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 130, width: 380, height: 400))
        imageView.contentMode = .scaleAspectFit // Adjust content mode as needed
        imageView.image = UIImage(named: "mundaneAstrology")
        return imageView
    }()



    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return table
    }()

    private let MP_Planets: [String]

    // Init

    init(MP_Planets: [String]) {
        self.MP_Planets = MP_Planets
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        let screenWidth = UIScreen.main.bounds.width

        view.addSubview(mundaneAstrologyImageView)

        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        view.frame = CGRect(x: 0, y: 0, width: 400, height: 2000)
        view.addSubview(tableView)
        //  view.addSubview(minorsChartView)

        var cyclePlanets = [chartCake?.natal.pluto, chartCake?.natal.neptune, chartCake?.natal.uranus,  chartCake?.natal.saturn, chartCake?.natal.jupiter, chartCake?.natal.mars]

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let yOffset: CGFloat = 550
        let tableViewHeight = view.bounds.height - yOffset - 20  // Adjust this as per your requirements
        tableView.frame = CGRect(x: 10, y: yOffset, width: view.bounds.width - 20, height: tableViewHeight)



        //  adding date labet
        //    let formatted = selectedDate!.formatted(date: .complete, time: .omitted)

        let todaysDate = UILabel(frame: CGRect(x: 100, y: 535, width: 300, height: 20))
        todaysDate.text = ""
        todaysDate.font = .systemFont(ofSize: 13)
        todaysDate.textColor = .white
        todaysDate.font = UIFont.boldSystemFont(ofSize: todaysDate.font.pointSize)


        view.addSubview(todaysDate)
    }

    @objc func navigateToTimeChangeVC() {
        let timeChangeVC = MinorsPlanetsTimeChangeViewController()
        self.navigationController?.pushViewController(timeChangeVC, animated: true)
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8


    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        var cyclePlanets = ["pluto","neptune","uranus","saturn","jupiter","mars","sun","moon"]

        let planetIdeas: [String: [String]] = [
            "sun": [
                "politics.",
                "executive work and administration.",
                "bosses and the ruling class."
            ],
            "moon": [
                "the family and home.",
                "groceries and other commodities.",
                "women and the common people."
            ],

            "mars": [
                "mechanics.",
                "manufacturing and the military profession.",
                "militarism."
            ],
            "jupiter": [
                "religion and philosophy.",
                "finances and commerce.",
                "capitalism."
            ],
            "saturn": [
                "orthodoxy.",
                "land and basic utilities.",
                "conservatism, the farmer and the miner."
            ],
            "uranus": [
                "the occult and ultra-progressive.",
                "invention and unusual methods.",
                "the radical element."
            ],
            "neptune": [
                "the mystical and psychic.",
                "promotion and stock companies.",
                "the ideal."
            ],
            "pluto": [
                "spirituality or inversion, and the influence of invisible intelligences.",
                "group activity, either for the selfish advantage of the group or for universal good.",
                "compulsory cooperation."
            ]
        ]

        let planetName = cyclePlanets[indexPath.row]
        let ideas = planetIdeas[planetName] ?? []
        let headerText = ideas.joined(separator: "\n") // Join ideas into one line, separated by line breaks

        cell.configure(
            signGlyphImageName: planetName,
            planetImageImageName: planetName,
            signTextText: planetName,
            planetTextText: planetName,
            headerTextText: headerText
        )

        return cell
    }





    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected planet name


        var selectedPlanets = [chartCake?.natal.pluto,chartCake?.natal.neptune,chartCake?.natal.uranus,chartCake?.natal.saturn,chartCake?.natal.jupiter,chartCake?.natal.mars,chartCake?.natal.sun,chartCake?.natal.moon]

        let planetName = selectedPlanets[indexPath.row]?.body.keyName
        var selectedPlanet = selectedPlanets[indexPath.row]
        print("selectedPlanet: \(selectedPlanet?.body.keyName)")
        // Instantiate the CycleChartTableViewController
        let cycleChartVC = CycleChartTableViewController()

        // Pass the selected planet name to the CycleChartTableViewController
        cycleChartVC.selectedPlanetName = planetName
        cycleChartVC.selectedPlanet = selectedPlanet
        // Push the CycleChartTableViewController onto the navigation stack
        self.navigationController?.pushViewController(cycleChartVC, animated: true)
    }


}


