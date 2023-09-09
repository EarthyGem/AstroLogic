import UIKit
import SwiftEphemeris

class ProgressionsMatrixViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Inside ProgressionsMatrixViewController
    var majorAspect: AspectType?
    var minorAspectsData: [AspectType: [AspectType]]?



    var chartCake: ChartCake?
    let contentTableView = UITableView()
    let minorProgressionsTableView = UITableView()
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
         
            if let major = majorAspect,
                let minorAspects = minorAspectsData?[major] {
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

        minorProgressionsTableView.delegate = self
        minorProgressionsTableView.dataSource = self
        minorProgressionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MinorProgressionCell")

        // Layout (assuming you want them stacked vertically)
        contentTableView.translatesAutoresizingMaskIntoConstraints = false
        minorProgressionsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentTableView)
        view.addSubview(minorProgressionsTableView)

        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6), // 60% height

            minorProgressionsTableView.topAnchor.constraint(equalTo: contentTableView.bottomAnchor),
            minorProgressionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            minorProgressionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            minorProgressionsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        } else { // assuming this is for minorProgressionsTableView
            if let major = majorAspect, let minorAspects = minorAspectsData?[major] {
                print("Minor Aspects Count: \(minorAspects.count)")
                return minorAspects.count
            }
            return 0
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == contentTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
            let sectionData = Array(contentData.values)[indexPath.section]
            cell.configure(with: sectionData[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MinorProgressionCell", for: indexPath)
            if let major = majorAspect,
               let minorAspects = minorAspectsData?[major] {
               cell.textLabel?.text = minorAspects[indexPath.row].aspectString
               print("Minor aspect data: \(minorAspects)")
            }
            return cell
        }
    }

    }
// Assuming you've already defined ContentCell
