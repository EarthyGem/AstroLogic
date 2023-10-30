import UIKit
import SwiftEphemeris

class TranistsMatrixViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Inside ProgressionsMatrixViewController
    var minorAspect: AspectType?
    var transitAspectsData: [AspectType: [AspectType]]?
    var transitsData: [AspectType]?



    var chartCake: ChartCake?
    let contentTableView = UITableView()
    let transitsTableView = UITableView()
    var progressedPlanets = [CelestialObject]()
    // Data arrays (placeholders, modify as per your needs)
    let contentData: [String: [String]] = [
        "Section1": ["Content1", "Content2"],
        "Section2": ["Content1"],
        "Section3": ["Content1", "Content2", "Content3"],
        // ... add more sections as required
    ]

    var minorProgressionsData = [String]() // modify as per your needs


        override func viewDidLoad() {
            super.viewDidLoad()
            print("Transits data passed: \(transitsData)")
            if let minor = minorAspect,
                let minorAspects = transitAspectsData?[minor] {
                // Assuming that you'd want to convert the minor aspects into their string representation or some other transformation
                minorProgressionsData = minorAspects.map { $0.aspectString }
             }

             setupTableViews()
         }



    // MARK: - Setup methods
    func setupTableViews() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(ContentCell.self, forCellReuseIdentifier: "ContentCell")

        transitsTableView.delegate = self
        transitsTableView.dataSource = self
        transitsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MinorProgressionCell")

        // Layout (assuming you want them stacked vertically)
        contentTableView.translatesAutoresizingMaskIntoConstraints = false
        transitsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentTableView)
        view.addSubview(transitsTableView)

        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6), // 60% height

            transitsTableView.topAnchor.constraint(equalTo: contentTableView.bottomAnchor),
            transitsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transitsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            transitsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - TableView Delegate & DataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == contentTableView {
            return contentData.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == contentTableView {
            let sectionData = Array(contentData.values)[section]
            return sectionData.count
        } else { // for transitsTableView
            return transitsData?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == contentTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
            let sectionData = Array(contentData.values)[indexPath.section]
            cell.configure(with: sectionData[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransitCell", for: indexPath) // Consider renaming the cell identifier for clarity
            if let transit = transitsData?[indexPath.row] {
               cell.textLabel?.text = transit.aspectString
               print("Transit aspect data: \(transit)")
            }
            return cell
        }
    }


    }
// Assuming you've already defined ContentCell
