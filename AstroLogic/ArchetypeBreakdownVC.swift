import UIKit
import SwiftEphemeris

class ArchetypeMatrixViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Your existing properties
    var selectedCelestialObject: CelestialObject?
    let contentTableView = UITableView()
    var progressedPlanets = [CelestialObject]()
    var chartCake: ChartCake?
    // This computed property will simplify your TableView DataSource methods
    var contentData: [String: [String]] {
        return [
            "Section1": [selectedCelestialObject?.archetypeDescriptors ?? "No descriptor"],
            // ... add more sections as required
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
    }

    // MARK: - Setup methods
    func setupTableViews() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(ContentCell.self, forCellReuseIdentifier: "ContentCell")

       

        // Layout (assuming you want them stacked vertically)
        contentTableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(contentTableView)


        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6), // 60% height


        ])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return contentData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = Array(contentData.values)[section]
        return sectionData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        let sectionData = Array(contentData.values)[indexPath.section]
        cell.configure(with: sectionData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Assuming you need to take some action when a row is selected in the contentTableView
        if tableView == contentTableView {
            // Handle your selection action here
        }

        // Deselect the selected row for smooth user experience
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

