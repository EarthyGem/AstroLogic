import UIKit
import SwiftEphemeris

struct CelestialObjectDetail {
    var title: String
    var content: String
}

struct CelestialObjectSection {
    var celestialBody: CelestialObject
    var details: [CelestialObjectDetail]
}

class ArchetypeMatrixViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Your existing properties
    var selectedCelestialObject: CelestialObject?
    let contentTableView = UITableView()
    var progressedPlanets = [CelestialObject]()
    var chartCake: ChartCake?

    var contentData: [CelestialObjectSection] {
        guard let celestialObject = selectedCelestialObject else { return [] }
        return [section(for: celestialObject)]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
    }

    // MARK: - Setup methods
    func setupTableViews() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(MyContentCell.self, forCellReuseIdentifier: "MyContentCell")

        contentTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentTableView)

        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6) // 60% height
        ])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return contentData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentData[section].details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyContentCell", for: indexPath) as! MyContentCell
        let detail = contentData[indexPath.section].details[indexPath.row]
        cell.configure(with: detail)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contentData[section].celestialBody.formatted
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Assuming you need to take some action when a row is selected in the contentTableView
        if tableView == contentTableView {
            // Handle your selection action here
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Helper functions for generating sections

    func details(for celestialObject: CelestialObject) -> [CelestialObjectDetail] {
        return [
            CelestialObjectDetail(title: "Formatted", content: celestialObject.formatted),
            CelestialObjectDetail(title: "Key Name", content: celestialObject.keyName),
            CelestialObjectDetail(title: "Transit Name", content: celestialObject.transitName),
            CelestialObjectDetail(title: "Minors Name", content: celestialObject.minorsName),
            CelestialObjectDetail(title: "Urge Types", content: celestialObject.urgeTypes),
            CelestialObjectDetail(title: "Archetype", content: celestialObject.archetype),
            CelestialObjectDetail(title: "Inner Archetypes", content: celestialObject.innerArchetypes),
            CelestialObjectDetail(title: "Archetype Descriptors", content: celestialObject.archetypeDescriptors),
            CelestialObjectDetail(title: "Planet Thought Types", content: celestialObject.planetThoughtTypes),
            CelestialObjectDetail(title: "Too Much Archetype", content: celestialObject.tooMuchArchetype),
            CelestialObjectDetail(title: "Too Little Archetype", content: celestialObject.tooLittleArchetype),
            CelestialObjectDetail(title: "Archetype Gifts", content: celestialObject.archetypeGifts),
            CelestialObjectDetail(title: "Archetype Poetry", content: celestialObject.archetypePoetry),
            CelestialObjectDetail(title: "Tarot", content: celestialObject.tarot),
            // ... Add more details as needed
        ]
    }


    func section(for celestialObject: CelestialObject) -> CelestialObjectSection {
        return CelestialObjectSection(celestialBody: celestialObject, details: details(for: celestialObject))
    }
}

class MyContentCell: UITableViewCell {

    // Declaring the labels
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16) // Choose a desired font size or type
        return label
    }()

    var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14) // Choose a desired font size or type
        label.numberOfLines = 0 // Allows the label to wrap and show multiple lines
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        // Adding labels to cell's content view
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)

        // Setting up constraints for the labels
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with detail: CelestialObjectDetail) {
        titleLabel.text = detail.title
        contentLabel.text = detail.content
    }
}
