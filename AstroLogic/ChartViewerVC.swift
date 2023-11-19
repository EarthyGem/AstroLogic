import UIKit
import DGCharts
import SwiftEphemeris


class PercentFormatter: NSObject, ValueFormatter {
    let numberFormatter = NumberFormatter()

    override init() {
        super.init()
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.numberStyle = .percent
    }

    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        return numberFormatter.string(from: NSNumber(value: value/100)) ?? ""
    }
}


class ChartViewController: UIViewController {
    var birthChartView: BirthChartView!

    var harmonyDiscordLabels: [UILabel] = []

    var harmonyDiscordScores: [String: (harmony: Double, discord: Double, difference: Double)]?
    var chart: Chart!
    var scrollView: UIScrollView!
    var scoreLabels: [UILabel] = []
    var chartCake: ChartCake!

    var scores2: [(String, Double)] = []
    var signScore: [String : Double] = [:]
    var scores = [String : Double]()
    var houseScores: [Int : Double] = [:]
    var signScore2: [String : Double] = [:]
    var signScores: [String : Double] = [:]
    var harmonyDiscordScores2: [String: (harmony: Double, discord: Double, difference: Double)]?
    var houseScores2: [String : Double] = [:]
    //    var scores = [Planet : Double] = [:]


    let planetSymbolMapping: [String: String] = [
        "Sun": "☉",
        "Moon": "☽",
        "Mercury": "☿",
        "Venus": "♀",
        "Mars": "♂",
        "Jupiter": "♃",
        "Saturn": "♄",
        "Uranus": "♅",
        "Neptune": "♆",
        "Pluto": "♇",
        "S.Node": "☋",
        // Add more planet mappings as needed
    ]

    let signSymbolMapping: [String: String] = [
        "Aries": "♈",
        "Taurus": "♉",
        "Gemini": "♊",
        "Cancer": "♋",
        "Leo": "♌",
        "Virgo": "♍",
        "Libra": "♎",
        "Scorpio": "♏",
        "Sagittarius": "♐",
        "Capricorn": "♑",
        "Aquarius": "♒",
        "Pisces": "♓",
    ]




    let planetColors: [String: UIColor] = [
        CelestialObject.planet(.sun).keyName: .orange,
        CelestialObject.planet(.moon).keyName: .green,
        CelestialObject.planet(.mercury).keyName: .purple,
        CelestialObject.planet(.venus).keyName: .yellow,
        CelestialObject.planet(.mars).keyName: .red,
        CelestialObject.planet(.jupiter).keyName: .systemIndigo,
        CelestialObject.planet(.saturn).keyName: .systemBlue,
        CelestialObject.planet(.uranus).keyName: .systemPurple,
        CelestialObject.planet(.neptune).keyName: .systemYellow,
        CelestialObject.planet(.pluto).keyName: .systemGreen,
        CelestialObject.lunarNode(.meanSouthNode).keyName: .darkGray,
        "ascendant": .white,
        "midheaven": .white
        // add more if needed...
    ]
    
    @objc func printButtonTapped() {


   //     let pdfURL = createSummaryPDF()
   //     printPDF(at: pdfURL)

    }

       
    @objc private func pieChartButton() {
       let pieChartTBC = PieChartTabBarController()
       pieChartTBC.chartCake = chartCake
       print("CHARTCAKE \(chartCake.natal.sun.sign.keyName)")
       navigationController?.pushViewController(pieChartTBC, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var chartCake = chartCake
        
        let pieChartsButton = UIBarButtonItem(title: "Pie Charts", style: .plain, target: self, action: #selector(pieChartButton))
        navigationItem.rightBarButtonItem = pieChartsButton

        view.backgroundColor = .black
        let screenWidth = UIScreen.main.bounds.width
        let birthChartView = BirthChartView(frame: CGRect(x: 0, y: 30, width: screenWidth, height: screenWidth), chartCake: chartCake!)
        
        //   birthChartView.backgroundColor = .white
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 1500))
        // Set the total height to 4000
        let totalHeight: CGFloat = 4200
        let adjustedYPos = screenWidth + 50
        // Adjust the scrollView's contentSize
        scrollView.contentSize = CGSize(width: screenWidth, height: totalHeight)
        
        scrollView.backgroundColor = .black
        view.addSubview(scrollView)
        
        
        let maxScore = scores2.map({ $0.1 }).max() ?? 1
        
        var normalizedScores: [(String, Double)] = []
        for (planet, score) in scores2 {
            let normalizedScore = (score / maxScore) * 100
            normalizedScores.append((planet, normalizedScore))
        }
        
        
        let sortedScores = scores2
        
        // Create the score labels and add them to the scrollView
        let labelHeight: CGFloat = 20
        let labelSpacing: CGFloat = 5
        let barHeight2: CGFloat = 5
        let barSpacing2: CGFloat = 2.5
        
        for (index, (planet, score)) in sortedScores.enumerated() {
            let label = UILabel(frame: CGRect(x: 10, y: labelSpacing + CGFloat(index) * (labelHeight + labelSpacing) + adjustedYPos + 40, width: screenWidth - 20, height: labelHeight))
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = "\(planet): \(Int(score))"
            scrollView.addSubview(label)
            scoreLabels.append(label)
        }
        
        let sortedHarmonyDiscordScores = chartCake!.getTotalHarmonyDiscordScoresForPlanets().sorted(by: { $0.value.net > $1.value.net }) // Sort by the net score
        let labelStartY: CGFloat = labelSpacing + CGFloat(sortedScores.count) * (labelHeight + labelSpacing) + 50
        let barStartX2: CGFloat = 110
        let _: CGFloat = 2
        
        
        
        // first try - harmony discord planet labels
        for (index, (planet, scores)) in sortedHarmonyDiscordScores.enumerated() {
            // Difference label
            let differenceLabel = UILabel(frame: CGRect(x: 10, y: labelStartY + CGFloat(index) * (labelHeight + 2 * labelSpacing) + adjustedYPos + 60, width: screenWidth - 20, height: labelHeight))
            differenceLabel.textColor = .white
            differenceLabel.font = UIFont.systemFont(ofSize: 13)
            differenceLabel.text = "\(planet.keyName) : \(Int(scores.net))" // Use net score here
            scrollView.addSubview(differenceLabel)
            
            // Harmony bar
            let harmonyBarView = UIView()
            harmonyBarView.backgroundColor = .systemBlue
            harmonyBarView.frame = CGRect(x: barStartX2, y: labelStartY + CGFloat(index) * (labelHeight + 2 * labelSpacing) + adjustedYPos + 60, width: CGFloat(scores.harmony) * 2, height: barHeight2)
            scrollView.addSubview(harmonyBarView)
            
            // Discord bar
            let discordBarView = UIView()
            discordBarView.backgroundColor = .systemRed
            discordBarView.frame = CGRect(x: barStartX2, y: labelStartY + CGFloat(index) * (labelHeight + 2 * labelSpacing) + barHeight2 + barSpacing2 + adjustedYPos + 60, width: CGFloat(scores.discord) * 2, height: barHeight2)
            scrollView.addSubview(discordBarView)
        }
        
        
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        
        let printButton = UIButton(type: .custom)
        printButton.setImage(UIImage(systemName: "printer"), for: .normal)
        printButton.tintColor = .blue
        printButton.addTarget(self, action: #selector(printButtonTapped), for: .touchUpInside)
        
        // Position the print button in the upper right corner
        printButton.frame = CGRect(x: view.bounds.width - 50, y: 80, width: 40, height: 40)
        
        // Add the print button as a subview to the view
        view.addSubview(printButton)
        
        scrollView.addSubview(birthChartView)
        // Customize the view as needed
        birthChartView.backgroundColor = .black
        
        // Update the planet positions in the view
        //    birthChartView.updateBirthChart()
        
        
        
        
        let signScores = chartCake!.calculateTotalSignScore()
        
        
        
        
        let barHeight: CGFloat = 20
        let barSpacing: CGFloat = 5
        let _: CGFloat = 100 // The width of the bars when the score is 100
        let barStartX: CGFloat = 100 // Adjust this value to set the starting position of the bars
        for (index, (planet, normalizedScore)) in normalizedScores.enumerated() {
            let barView = UIView()
            barView.backgroundColor = planetColors[planet] ?? .black // Use black as a default color
            barView.frame = CGRect(x: barStartX, y: CGFloat(index) * (barHeight + barSpacing) + adjustedYPos + 40, width: CGFloat(normalizedScore), height: barHeight)
            scrollView.addSubview(barView)
            
            
            
            
            
            
            // Create pie chart for total sign scores
            let signScores = chartCake!.calculateTotalSignScore()
   //         let signPieChartView = createPieChartView(dataEntries: generatePieChartData(scores: signScores))
      //      signPieChartView.frame = CGRect(x: 10, y: 400 + adjustedYPos, width: screenWidth - 20, height: 300)
            
        
            
            // Sign Scores Bar Chart
            let signScoresChart = BarChartView(frame: CGRect(x: 10, y: 750 + adjustedYPos, width: self.view.frame.size.width - 20, height: self.view.frame.size.height / 4))
            updateSignBarChart(chartView: signScoresChart, scores: signScores, label: "Sign Scores")
            self.scrollView.addSubview(signScoresChart)
            
            
            // House Scores Bar Chart
            let houseScoresChart = BarChartView(frame: CGRect(x: 10, y: 1050 + adjustedYPos, width: self.view.frame.size.width - 20, height: self.view.frame.size.height / 4))
            updateHouseBarChart(chartView: houseScoresChart, scores: houseScores, label: "House Scores")
            self.scrollView.addSubview(houseScoresChart)
            
            
            
            // Planet Scores Bar Chart
            let planetScoresChart = BarChartView(frame: CGRect(x: 10, y: 1350 + adjustedYPos, width: self.view.frame.size.width - 20, height: self.view.frame.size.height / 4))
            updatePlanetBarChart(chartView: planetScoresChart, scores: scores, label: "Planet Scores")
            self.scrollView.addSubview(planetScoresChart)
            
            let chartView = BarChartView()
            chartView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)  // Adjust these values to fit your needs
            view.addSubview(chartView)
            
            
            let lastYPositionOfContent = planetScoresChart.frame.origin.y + planetScoresChart.frame.size.height
            if lastYPositionOfContent > scrollView.contentSize.height {
                scrollView.contentSize.height = lastYPositionOfContent  // Adding 50 or another suitable value as a buffer space at the bottom
            }
            
            
        }
        
        func updateHouseBarChart(chartView: BarChartView, scores: [Int: Double], label: String) {
            var dataEntries: [BarChartDataEntry] = []
            
            let totalScore = scores.values.reduce(0, +)  // Calculate the total score
            
            for (index, key) in scores.keys.sorted().enumerated() {
                if let value = scores[key] {
                    let percentage = (value / totalScore) * 100  // Convert the score to a percentage of the total
                    let dataEntry = BarChartDataEntry(x: Double(index), y: percentage)
                    dataEntries.append(dataEntry)
                }
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: label)
            chartDataSet.colors = getCustomBarColors(count: dataEntries.count)  // Assign different colors to each bar
            
            // Create a number formatter for percentage style
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            
            // Enable showing values on top of the bars and set value formatter to percentage
            chartDataSet.drawValuesEnabled = true
            chartDataSet.valueFormatter = PercentFormatter()
            chartDataSet.valueColors = [UIColor.white]
            chartDataSet.valueFont = .systemFont(ofSize: 10)
            
            let chartData = BarChartData(dataSet: chartDataSet)
            chartView.data = chartData
            chartView.legend.enabled = false
            
            
            chartView.drawGridBackgroundEnabled = false
            chartView.xAxis.drawGridLinesEnabled = false
            chartView.leftAxis.drawGridLinesEnabled = false
            chartView.rightAxis.drawGridLinesEnabled = false
            chartView.leftAxis.drawAxisLineEnabled = false
            chartView.rightAxis.drawAxisLineEnabled = false
            
            
            let xAxis = chartView.xAxis
            xAxis.labelPosition = .bottom
            xAxis.setLabelCount(scores.count, force: false)
            xAxis.axisMinimum = -0.5
            xAxis.axisMaximum = Double(scores.count) - 0.5
            xAxis.valueFormatter = IndexAxisValueFormatter(values: scores.keys.sorted().map { "H\($0)" })
            xAxis.labelTextColor = .white
            xAxis.labelFont = UIFont.systemFont(ofSize: 14) // Set the font size to 14
            xAxis.yOffset = -2.0 // Move the labels up by 5 points
            chartView.extraBottomOffset = 10.0
            // Disable axis lines
            chartView.leftAxis.drawAxisLineEnabled = false
            chartView.rightAxis.drawAxisLineEnabled = false
            xAxis.drawAxisLineEnabled = false
        }
        
        func updateSignBarChart(chartView: BarChartView, scores: [Zodiac: Double], label: String) {
            let zodiacOrder = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
            let sortedZodiacs = scores.sorted {
                zodiacOrder.firstIndex(of: $0.key.keyName) ?? 0 < zodiacOrder.firstIndex(of: $1.key.keyName) ?? 0
            }
            
            var dataEntries: [BarChartDataEntry] = []
            let totalScore = scores.values.reduce(0, +)
            
            for (index, zodiacScore) in sortedZodiacs.enumerated() {
                let percentage = (zodiacScore.value / totalScore) * 100
                let dataEntry = BarChartDataEntry(x: Double(index), y: percentage)
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: label)
            chartDataSet.drawValuesEnabled = true  // Disable showing values on top of the bars
            chartDataSet.valueFormatter = PercentFormatter()
            chartDataSet.valueColors = [UIColor.white]
            chartDataSet.valueFont = .systemFont(ofSize: 10)
            chartDataSet.colors = getCustomBarColors(count: dataEntries.count)  // Assign different colors to each bar
            chartView.legend.enabled = false
            
            let chartData = BarChartData(dataSet: chartDataSet)
            chartView.data = chartData
            chartView.legend.enabled = false
            
            
            chartView.drawGridBackgroundEnabled = false
            chartView.xAxis.drawGridLinesEnabled = false
            chartView.leftAxis.drawGridLinesEnabled = false
            chartView.rightAxis.drawGridLinesEnabled = false
            chartView.leftAxis.drawAxisLineEnabled = false
            chartView.rightAxis.drawAxisLineEnabled = false
            
            
            let xAxis = chartView.xAxis
            xAxis.labelPosition = .bottom
            xAxis.setLabelCount(scores.count, force: false)
            xAxis.axisMinimum = -0.5
            xAxis.axisMaximum = Double(scores.count) - 0.5
            xAxis.valueFormatter = IndexAxisValueFormatter(values: sortedZodiacs.map { signSymbolMapping[$0.key.keyName] ?? $0.key.keyName })
            xAxis.labelTextColor = .white
            xAxis.labelFont = UIFont.systemFont(ofSize: 20) // Set the font size to 14
            xAxis.yOffset = -2.0 // Move the labels up by 5 points
            
            // Disable axis lines
            chartView.leftAxis.drawAxisLineEnabled = false
            chartView.rightAxis.drawAxisLineEnabled = false
            chartView.extraBottomOffset = 10.0 // Increase or decrease the offset as needed
            
            xAxis.drawAxisLineEnabled = false
        }
        
        func updatePlanetBarChart(chartView: BarChartView, scores: [String: Double], label: String) {
            let planetOrder = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
            var sortedPlanets = scores.sorted {
                planetOrder.firstIndex(of: $0.key) ?? 0 < planetOrder.firstIndex(of: $1.key) ?? 0
            }
            
            var dataEntries: [BarChartDataEntry] = []
            let totalScore = scores.values.reduce(0, +)
            
            if let southNodeIndex = sortedPlanets.firstIndex(where: { $0.key == "S.Node" }) {
                let southNode = sortedPlanets.remove(at: southNodeIndex)
                sortedPlanets.append(southNode)
            }
            
            for (index, planetScore) in sortedPlanets.enumerated() {
                let percentage = (planetScore.value / totalScore) * 100
                let dataEntry = BarChartDataEntry(x: Double(index), y: percentage)
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: label)
            chartDataSet.drawValuesEnabled = true
            chartDataSet.valueFormatter = PercentFormatter()
            chartDataSet.valueColors = [UIColor.white]  // Disable showing values on top of the bars
            chartDataSet.colors = getCustomPlanetColors(count: dataEntries.count)  // Assign different colors to each bar
            chartDataSet.valueFont = .systemFont(ofSize: 10) // replace 18 with your desired size
            
            chartView.legend.enabled = false
            
            
            let chartData = BarChartData(dataSet: chartDataSet)
            chartView.data = chartData
            chartView.drawGridBackgroundEnabled = false
            chartView.xAxis.drawGridLinesEnabled = false
            chartView.leftAxis.drawGridLinesEnabled = false
            chartView.rightAxis.drawGridLinesEnabled = false
            let xAxis = chartView.xAxis
            xAxis.labelPosition = .bottom
            xAxis.setLabelCount(scores.count, force: false)
            xAxis.axisMinimum = -0.5
            xAxis.axisMaximum = Double(scores.count) - 0.5
            xAxis.valueFormatter = IndexAxisValueFormatter(values: sortedPlanets.map { planetSymbolMapping[$0.key] ?? $0.key })
            xAxis.labelTextColor = .white
            xAxis.labelFont = UIFont.systemFont(ofSize: 18) // Set the font size to 14
            xAxis.yOffset = 2.0 // Move the labels up by 5 points
            chartView.extraBottomOffset = 10.0 // Increase or decrease the offset as needed
            
            // Disable axis lines
            chartView.leftAxis.drawAxisLineEnabled = false
            chartView.rightAxis.drawAxisLineEnabled = false
            xAxis.drawAxisLineEnabled = false
        }
        
        
        func getCustomBarColors(count: Int) -> [UIColor] {
            let customColors: [UIColor] = [
                // ARIES - light red
                UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
                // TAURUS - dark yellow
                UIColor(red: 0.8, green: 0.8, blue: 0.0, alpha: 1.0),
                // GEMINI - light violet
                UIColor(red: 0.7, green: 0.0, blue: 1.0, alpha: 1.0),
                // CANCER - light green
                UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0),
                // LEO - light orange
                UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0),
                // VIRGO - dark violet
                UIColor(red: 0.4, green: 0.0, blue: 0.5, alpha: 1.0),
                // LIBRA - light yellow
                UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0),
                // SCORPIO - dark red
                UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0),
                // SAGITTARIUS - light purple
                UIColor(red: 0.8, green: 0.0, blue: 0.8, alpha: 1.0),
                // CAPRICORN - dark blue
                UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0),
                // AQUARIUS - sky blue
                UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0),
                // PISCES - dark purple
                UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
            ]
            
            var barColors: [UIColor] = []
            for i in 0..<count {
                let colorIndex = i % customColors.count
                barColors.append(customColors[colorIndex])
            }
            
            return barColors
        }
        
        func getCustomPlanetColors(count: Int) -> [UIColor] {
            let customColors: [UIColor] = [
                UIColor.orange,    // SUN
                UIColor.green,     // MOON
                UIColor.purple,    // MERCURY
                UIColor.yellow,    // VENUS
                UIColor.red,       // MARS
                UIColor.systemIndigo,    // JUPITER
                UIColor.blue,      // SATURN
                UIColor.white,     // URANUS
                UIColor.systemYellow,// NEPTUNE
                UIColor.systemGreen      // PLUTO
            ]
            
            var colors: [UIColor] = []
            for i in 0..<count {
                let colorIndex = i % customColors.count
                colors.append(customColors[colorIndex])
            }
            
            return colors
        }
        
    }


    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let currentScale = gestureRecognizer.scale
            let scaleTransform = CGAffineTransform(scaleX: currentScale, y: currentScale)
            birthChartView.transform = scaleTransform
        }
    }

  

    func calculateTotalElementScores(signScores: [Zodiac: Double]) -> [Element: Double] {
        var elementScores: [Element: Double] = [.inspiration: 0, .practicality: 0, .intellect: 0, .emotion: 0]

        for (element, signs) in elementSigns {
            for sign in signs {
                if let score = signScores[sign] {
                    elementScores[element, default: 0] += score
                }
            }
        }

        return elementScores
    }

    func calculateTotalModalityScores(signScores: [Zodiac: Double]) -> [Modality: Double] {
        var modalityScores: [Modality: Double] = [.pioneer: 0, .perfector: 0, .developer: 0]

        for (modality, signs) in modalitySigns {
            for sign in signs {
                if let score = signScores[sign] {
                    modalityScores[modality, default: 0] += score
                }
            }
        }

        return modalityScores
    }

    func calculateTotalEmanationScores(signScores: [Zodiac: Double]) -> [Emanation: Double] {
        var emanationScores: [Emanation: Double] = [.liberty: 0, .modification: 0, .reserve: 0]

        for (emanation, signs) in emanationSigns {
            for sign in signs {
                if let score = signScores[sign] {
                    emanationScores[emanation, default: 0] += score
                }
            }
        }

        return emanationScores
    }

    func calculateTotalDomainScores(houseScores: [Int: Double]) -> [Domain: Double] {
        var domainScores: [Domain: Double] = [:]

        for (domain, houses) in domainHouses {
            for house in houses {
                if let score = houseScores[house] {
                    domainScores[domain, default: 0] += score
                }
            }
        }
        //  print("Domain Scores from Function: \(domainScores)")
        return domainScores
    }

    func calculateTotalTrinityScores(houseScores: [Int: Double]) -> [Trinity: Double] {
        var trinityScores: [Trinity: Double] = [:]

        for (trinity, houses) in trinityHouses {
            for house in houses {
                if let score = houseScores[house] {
                    trinityScores[trinity, default: 0] += score
                }
            }
        }
        //   print("Trinity Scores from Function: \(trinityScores)")
        return trinityScores
    }

}



func printPDF(at url: URL) {
    // Check if we can print the job
    if UIPrintInteractionController.canPrint(url) {
        // Create the print info
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = url.lastPathComponent
        printInfo.outputType = .general

        // Create the print interaction controller
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.printingItem = url

        // Present the print interaction controller
        printController.present(animated: true)
    }
}




// Function to convert a dictionary into a string
func dictToString<T>(_ dict: [T : Double]) -> String {
    var string = ""
    for (key, value) in dict {
        string.append("\(key): \(value)\n")
    }
    return string
}

// Function to convert the harmonyDiscordScores dictionary into a string
func harmonyDiscordScoresToString(_ dict: [String : (harmony: Double, discord: Double, difference: Double)]) -> String {
    var string = ""
    for (key, value) in dict {
        string.append("\(key): Harmony: \(value.harmony), Discord: \(value.discord), Difference: \(value.difference)\n")
    }
    return string
}




// Function to generate the PDF

func dictToPercentageString(_ dict: [String: Double], totalScore: Double) -> String {
    let sortedScores = dict.sorted { $0.value > $1.value } // Sort dictionary by value in descending order
    var result = ""
    for (key, score) in sortedScores {
        let percentage = (score / totalScore) * 100
        let formattedPercentage = String(format: "%.1f%%", percentage)
        result += "\(key): \(formattedPercentage)\n"
    }
    return result
}


func harmonyDiscordScoresToPercentageString(_ dict: [String: (harmony: Double, discord: Double, difference: Double)], totalHarmony: Double, totalDiscord: Double) -> String {
    var result = ""
    for (key, scores) in dict {
        let harmonyPercentage = (scores.harmony / totalHarmony) * 100
        let discordPercentage = (scores.discord / totalDiscord) * 100
        let formattedHarmonyPercentage = String(format: "%.1f%%", harmonyPercentage)
        let formattedDiscordPercentage = String(format: "%.1f%%", discordPercentage)
        result += "\(key): Harmony: \(formattedHarmonyPercentage), Discord: \(formattedDiscordPercentage)\n"
    }
    return result
}


func convertIntToKeyStringDict(_ dict: [Int: Double]) -> [String: Double] {
    var convertedDict: [String: Double] = [:]
    for (key, value) in dict {
        convertedDict[String(key)] = value
    }
    return convertedDict
}
