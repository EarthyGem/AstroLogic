import Foundation
import SwiftEphemeris
import UIKit

class SPInfoViewController: UIViewController {
    var tarot: String = ""
    var name: String = ""
    var infoText: String?
    let scrollView = UIScrollView()
    let contentView = UIView()
//   let texts = ["Text 1", "Text 2", "Text 3", "Text 4", "Text 5", "Text 6", "Text 7", "Text 8", "Text 9"]
    let planetIntroLabel = UILabel()
    let planetImageView = UIImageView()
    var strongestPlanetName: String! // Just an example, set this as needed
    var strongestPlanet: String!
    var mostHarmoniousPlanet: String!
    var mostDiscordantPlanet: String!
    var strongestPlanetSign: String!
    override func viewDidLoad() {
        super.viewDidLoad()


        setupScrollView()
        setupPlanetIntro()
        setupContent(selectedPlanet: strongestPlanet)
        updateContentSize()
    }

    func setupScrollView() {
        // Adding scrollView
        view.addSubview(scrollView)
        scrollView.backgroundColor = .black
        // Setting up scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        // Adding contentView
        scrollView.addSubview(contentView)

        // Setting up contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.height),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let lastSubview = contentView.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last else { return }

        let bottomPadding: CGFloat = 20
        let contentHeight = lastSubview.frame.maxY + bottomPadding
        scrollView.contentSize = CGSize(width: contentView.frame.width, height: contentHeight)
    }


    func setupPlanetIntro() {
        // Configure and add planet image view
        planetImageView.contentMode = .scaleAspectFit
        planetImageView.image = UIImage(named: strongestPlanet.lowercased())
        contentView.addSubview(planetImageView)

        // Define and configure the planet name label
        let planetNameLabel = UILabel()
        planetNameLabel.textAlignment = .center
        planetNameLabel.text = strongestPlanet.capitalized
        planetNameLabel.textColor = .white
        planetNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(planetNameLabel)

        // Configure and add planet intro label
        planetIntroLabel.textAlignment = .justified
        planetIntroLabel.numberOfLines = 0
        planetIntroLabel.text = "The dominant planet of the chart is the most important factor. As the most influential planet in the chart, more of its particular quality of energy flows through \(name)'s chart than any other. Thus \(name)'s temperament and disposition manifest \(strongestPlanet!) energy most powerfully."
        planetIntroLabel.font = UIFont.systemFont(ofSize: 15) // adjust the font size as needed

        planetIntroLabel.textColor = .white
        contentView.addSubview(planetIntroLabel)

        // Setting up constraints for the imageView, name label, and intro label
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        planetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        planetIntroLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            planetImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            planetImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            planetImageView.widthAnchor.constraint(equalToConstant: 30), // Smaller size
            planetImageView.heightAnchor.constraint(equalToConstant: 30), // Smaller size

            planetNameLabel.topAnchor.constraint(equalTo: planetImageView.bottomAnchor, constant: 10),
            planetNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            planetIntroLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor, constant: 10),
            planetIntroLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            planetIntroLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            planetIntroLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    func updateContentSize() {
        guard let lastSubview = contentView.subviews.last else { return }
        let contentHeight = lastSubview.frame.maxY + 20 // Add some padding at the bottom
        scrollView.contentSize = CGSize(width: contentView.frame.width, height: contentHeight)
    }

    // Call this method after adding all subviews in setupContent()

    func setupContent(selectedPlanet: String) {
        var lastView: UIView? = nil
        let spaceBetweenGroups: CGFloat = 200
        let initialTopPadding: CGFloat = 250
        let textPadding: CGFloat = 20 // Padding inside the label background

        var planetInfo: [String]?

        switch selectedPlanet {
        case "Sun":
            planetInfo = sunInfo
        case "Moon":
            planetInfo = moonInfo
        case "Mercury":
            planetInfo = mercuryInfo
        case "Venus":
            planetInfo = venusInfo
        case "Mars":
            planetInfo = marsInfo
        case "Jupiter":
            planetInfo = jupiterInfo
        case "Saturn":
            planetInfo = saturnInfo
        case "Uranus":
            planetInfo = uranusInfo
        case "Neptune":
            planetInfo = neptuneInfo
        // Add cases for other planets as needed
        default:
            break
        }

        guard let selectedPlanetInfo = planetInfo else {
            return
        }

        for (index, text) in selectedPlanetInfo.enumerated() {
            let containerView = UIView() // Container view to hold the label
            contentView.addSubview(containerView)

            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])

            if let last = lastView {
                if index == 0 {
                    containerView.topAnchor.constraint(equalTo: last.bottomAnchor, constant: spaceBetweenGroups).isActive = true
                } else {
                    containerView.topAnchor.constraint(equalTo: last.bottomAnchor, constant: 20).isActive = true
                }
            } else {
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: initialTopPadding).isActive = true
            }

            // Create the label and add it to the container view
            let label = UILabel()
            label.text = text
            label.textColor = .white
            label.backgroundColor = UIColor(red: 148/255, green: 0, blue: 211/255, alpha: 1) // Dark lavender color
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            label.textAlignment = .justified
            label.font = UIFont.systemFont(ofSize: 15)
            label.numberOfLines = 0
            containerView.addSubview(label)

            // Set up constraints for the label inside the container view
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: textPadding),
                label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -textPadding)
            ])

            lastView = containerView
        }
        

        let labelBetweenSections = UILabel()
           labelBetweenSections.textColor = .white
           labelBetweenSections.numberOfLines = 0
           labelBetweenSections.text = """
           Having covered briefly what \(strongestPlanet!) energy is like if it is dominant, we can then say that such an attitude will predominate in \(name) regardless of what sign or house it is in. The sign will indicate the method by which \(name)'s \(strongestPlanet!) expresses, and the house which area of life the dominant desire will most often express in.
           """
        labelBetweenSections.textAlignment = .justified
           contentView.addSubview(labelBetweenSections)

           // Set up constraints for the label between sections
           labelBetweenSections.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               labelBetweenSections.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? contentView.topAnchor, constant: 300),
               labelBetweenSections.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               labelBetweenSections.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
           ])


        // Setup card image
        let cardImage = UIImageView(image: UIImage(named: tarot))
        print("Tarot: \(tarot)")
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardImage)

        // Setup additional label
        let additionalLabel = UILabel()
        additionalLabel.text = ""
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(additionalLabel)

        // Setup additional button
        let additionalButton = UIButton(type: .system)
        additionalButton.setTitle("", for: .normal)
        additionalButton.addTarget(self, action: #selector(showAdditionalDetails), for: .touchUpInside)
        additionalButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(additionalButton)

        let desiredWidth = 100.0
        let desiredHeight = 175.0
        // Setup layout constraints
        NSLayoutConstraint.activate([
            cardImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardImage.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? contentView.topAnchor, constant: 50),
            // Adjust the width and height constraints as needed
            cardImage.widthAnchor.constraint(equalToConstant: desiredWidth),
            cardImage.heightAnchor.constraint(equalToConstant: desiredHeight)
        ])

        let planetImage = UIImage(named: strongestPlanet.lowercased())
        let planetImageView = UIImageView(image: planetImage)
        planetImageView.contentMode = .scaleAspectFit
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(planetImageView)

        // Add sign image
        let signImage = UIImage(named: strongestPlanetSign)
        let signImageView = UIImageView(image: signImage)
        signImageView.contentMode = .scaleAspectFit
        signImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signImageView)

        // Add house emoji
        let houseEmoji = "🏠" // You can replace this with an appropriate house emoji
        let houseLabel = UILabel()
        houseLabel.text = houseEmoji
        houseLabel.font = UIFont.systemFont(ofSize: 40)
        houseLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(houseLabel)

        // Set up constraints for planet, sign, and house images
        NSLayoutConstraint.activate([
            planetImageView.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor),
            planetImageView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -20),
            planetImageView.widthAnchor.constraint(equalToConstant: desiredWidth),
            planetImageView.heightAnchor.constraint(equalToConstant: desiredHeight),

            signImageView.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor),
            signImageView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20),
            signImageView.widthAnchor.constraint(equalToConstant: desiredWidth),
            signImageView.heightAnchor.constraint(equalToConstant: desiredHeight),

            houseLabel.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor),
            houseLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            houseLabel.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10)
        ])

            lastView = houseLabel

        lastView = additionalButton
        lastView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    @objc func showAdditionalDetails() {
        // your code to show additional details
    }
}
//
//    The SUN on the Birthchart
//    -------------------------
//
//    - **Power Urge in the Unconscious Mind**: Corresponds to the Sun on the birthchart.
//    - **Desire for Significance**: Represents the urge for one's importance and significance.
//
//    Expressions of Power Urge:
//    --------------------------
//    - **Positive**: Assertive expressions, desires to be obeyed, constantly striving for control.
//    - **Desire for Significance**: The core of individuality that seeks admiration and approval, wanting the best in the chosen field.
//
//    Expressions - Beneficial vs. Detrimental:
//    -----------------------------------------
//    - **Harmonious Aspects**: Promote beneficial power thinking; kind, respectful, proud, dignified, and more.
//    - **Best Quality**: Rulership; exercising authority constructively.
//    - **Discordant Aspects**: Lead to detrimental power thinking; domineering, arrogant, pretentious, etc.
//    - **Worst Quality**: Dictativeness; inconsiderate and overbearing authority.
//
//    Desires and Needs Associated with Power:
//    ----------------------------------------
//    - Desire to exercise authority and control.
//    - Need for respect and admiration from others.
//    - Drive for power and high achievement.
//    - Strength to survive.
//
//    Birthchart & Its Psychological & Environmental Correspondences:
//    --------------------------------------------------------------
//    Personal significance is gauged by standard of living, societal position, accomplishments, and work. The astrological Sun propels behaviors that maintain or elevate significance levels.
//
//    Power and Leadership:
//    ---------------------
//    Throughout evolution, exercising authority had its advantages: territory dominance, securing mates, and community establishment. The drive for significance then evolved into wanting respect and obedience.
//
//    Significance:
//    -------------
//    - Gained through comparison and competition.
//    - Routes to personal significance: education, work, financial achievements, social status, physical appearance, and parenthood.
//    - True self-esteem is achieved by winning approval and admiration.
//
//    Past Experiences and their Influence:
//    -------------------------------------
//    All experiences related to power, authority, praise, or criticism are stored in the unconscious mind. The Sun's position on the birthchart maps these experiences, their volume, associated environments, and their success rate.
//
//    Sun Energy Characteristics:
//    ---------------------------
//    - Managerial skills and leadership abilities.
//    - Power struggles, shifts, and plays.
//    - Achievement, praise, moments of glory.
//    - Feelings of self-esteem and personal satisfaction.
//
//"""
//
