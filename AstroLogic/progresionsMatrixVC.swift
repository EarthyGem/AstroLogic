import UIKit
import SwiftEphemeris

// Inside your custom UITableViewCell class

struct AspectContent {
    var aspect: PlanetAspect
    var heading: String
    var detail: String
}

struct PlanetAspect {
    var contacting: String // Planet doing the contacting
    var contacted: String  // Planet being contacted
}


class AspectContentCell: UITableViewCell {
    let titleLabel = UILabel()
    let contentLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Add titleLabel and contentLabel as subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)

        // Set up constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false

        // Constraints for titleLabel
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true

        // Constraints for contentLabel
        contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        contentLabel.numberOfLines = 0

        // Additional constraints
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        contentLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        contentLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with content: AspectContent) {
           titleLabel.text = content.heading
           contentLabel.text = content.detail
       }
}


class ProgressionsMatrixViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Inside ProgressionsMatrixViewController
    var majorAspect: AspectType?
    var minorAspectsData: [AspectType: [AspectType]]?
    var minorAspect: AspectType?
    var majorAspectsDict: [String: [AspectType]] = [:]
    var selectedAspect: PlanetAspect?
    var filteredAspectContent: [AspectContent] = []



    var chartCake: ChartCake?
    let contentTableView = UITableView()
    let minorProgressionsTableView = UITableView()
    var progressedPlanets = [CelestialObject]()
    // Data arrays (placeholders, modify as per your needs)
    
  
    // Define your content as an ordered array
   
        // Add more aspects as needed
    


    var minorProgressionsData = [String]() // modify as per your needs


    override func viewDidLoad() {
        super.viewDidLoad()

        if let major = majorAspect,
           let minorAspects = minorAspectsData?[major] {
            // Assuming that you'd want to convert the minor aspects into their string representation or some other transformation
            minorProgressionsData = minorAspects.map { $0.aspectString }
        }
        majorAspectsDict = (chartCake?.constructMajorAspectDictionary2())!
        setupTableViews()
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.estimatedRowHeight = 100 // Adjust this value as needed


    }

    func updateContentForSelectedAspect() {
        guard let selectedAspect = selectedAspect else { return }
        filteredAspectContent = contentData.filter {
            $0.aspect.contacting == selectedAspect.contacting &&
            $0.aspect.contacted == selectedAspect.contacted
        }
        contentTableView.reloadData()
    }


    // MARK: - Setup methods
    func setupTableViews() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        // Register the cell class if you are not using a NIB
        contentTableView.register(AspectContentCell.self, forCellReuseIdentifier: "AspectContentCell")

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
            // You have only one section per aspect type
            return 1
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == contentTableView {
              // Return the count of your contentData array
              return filteredAspectContent.count
        } else {
            if let major = majorAspect, let minorAspects = minorAspectsData?[major] {
                print("Minor Aspects Count: \(minorAspects.count)")
                return minorAspects.count
            }
            return 0
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == contentTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AspectContentCell", for: indexPath) as! AspectContentCell
              let aspectContent = filteredAspectContent[indexPath.row]
              cell.configure(with: aspectContent)
              return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MinorProgressionCell", for: indexPath)
            if let major = majorAspect,
               let minorAspects = minorAspectsData?[major] {
                cell.textLabel?.text = minorAspects[indexPath.row].aspectString

            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == minorProgressionsTableView {
            if let major = majorAspect, let minorAspects = minorAspectsData?[major] {
                minorAspect = minorAspects[indexPath.row]
                if let selectedMinorAspect = minorAspect {
                    navigateToTransitMatrixViewController(with: selectedMinorAspect)
                }
            }
        }
        // Deselect the selected row for smooth user experience
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Moved out of the didSelectRowAt function
    func navigateToTransitMatrixViewController(with minorAspect: AspectType) {
        let transitMatrixVC = TransitsMatrixViewController() // Or instantiate from storyboard
        transitMatrixVC.chartCake = chartCake
        transitMatrixVC.minorAspect = minorAspect
        transitMatrixVC.transitAspectsData = [
            minorAspect: chartCake!.filterTransits(for: minorAspect)
        ]
        self.navigationController?.pushViewController(transitMatrixVC, animated: true)
    }
    
    func updateContentForPassedAspect(_ aspect: PlanetAspect) {
        selectedAspect = aspect
        print("Updating for aspect: \(aspect.contacting) contacting \(aspect.contacted)")
        filteredAspectContent = contentData.filter {
            $0.aspect.contacting == aspect.contacting &&
            $0.aspect.contacted == aspect.contacted
        }
        print("Filtered content count: \(filteredAspectContent.count)")
        contentTableView.reloadData()
    }

}

            extension PlanetAspect: Equatable {
                static func == (lhs: PlanetAspect, rhs: PlanetAspect) -> Bool {
                    return lhs.contacting == rhs.contacting && lhs.contacted == rhs.contacted
                }
            }
