import Foundation
import SwiftEphemeris
import UIKit

class SPInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tarot: String = ""
    var name: String = ""
    var infoText: String?
    let tableView = UITableView()
    var strongestPlanetName: String! // Just an example, set this as needed
    var strongestPlanet: String!
    var mostHarmoniousPlanet: String!
    var mostDiscordantPlanet: String!
    var strongestPlanetSign: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlanetIntroCell.self, forCellReuseIdentifier: "PlanetIntroCell")
        tableView.register(ContentCell.self, forCellReuseIdentifier: "ContentCell")
        tableView.register(CardImageCell.self, forCellReuseIdentifier: "CardImageCell")
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3  // Example: 1 for planet intro, 1 for content and 1 for card image
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            guard let planetInfo = planetInfo(for: strongestPlanet) else { return 0 }
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetIntroCell", for: indexPath) as! PlanetIntroCell
            cell.configure(with: strongestPlanet, name: name)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
            if let planetInfo = planetInfo(for: strongestPlanet) {
                cell.configure(with: planetInfo)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardImageCell", for: indexPath) as! CardImageCell
            cell.configure(with: tarot)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // Here, I'm assuming you want to adjust the height of cells dynamically
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150  // Or whatever estimated height you want
    }
    
    // Retrieve the info for the selected planet
    func planetInfo(for planet: String) -> String? {
        switch planet {
        case "Sun":
            return Planet.sun.rennArchetypes
        case "Moon":
            return Planet.moon.rennArchetypes
        case "Mercury":
            return Planet.mercury.rennArchetypes
        case "Venus":
            return Planet.venus.rennArchetypes
        case "Mars":
            return Planet.mars.rennArchetypes
        case "Jupiter":
            return Planet.jupiter.rennArchetypes
        case "Saturn":
            return Planet.saturn.rennArchetypes
        case "Uranus":
            return Planet.uranus.rennArchetypes
        case "Neptune":
            return Planet.neptune.rennArchetypes
        case "Pluto":
            return Planet.pluto.rennArchetypes
        default:
            return nil
        }
    }
    
}
