import Foundation
import SwiftEphemeris
import UIKit

class HarmonyInfoViewController: UIViewController {

    var harTarot: String!
    var name: String = ""
    var infoText: String?
    let scrollView = UIScrollView()
    let contentView = UIView()
    let texts = ["Text 1"]
    let planetIntroLabel = UILabel()
    let planetImageView = UIImageView()
    var planetName: String = "" // Just an example, set this as needed
    var strongestPlanet: String!
    var mostHarmoniousPlanet: String!
    var mostDiscordantPlanet: String!
    var lastView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupScrollView()
        setupPlanetIntro()
        setupContent()
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
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    func setupPlanetIntro() {
        // Configure and add planet image view
        planetImageView.contentMode = .scaleAspectFit
        planetImageView.image = UIImage(named: mostHarmoniousPlanet.lowercased())
        contentView.addSubview(planetImageView)
        
        // Define and configure the planet name label
        let planetNameLabel = UILabel()
        planetNameLabel.textAlignment = .justified
        planetNameLabel.text = mostHarmoniousPlanet.capitalized
        planetNameLabel.textColor = .white
        planetNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(planetNameLabel)
        
        // Configure and add planet intro label
        planetIntroLabel.textAlignment = .justified
        planetIntroLabel.numberOfLines = 0
        planetIntroLabel.text = "The best planet is the one receiving the support from the rest of the chart, and thus indicates the kind of things with the greatest ability to bring luck or ease into \(name)'s life. It is important to note it, so that \(name) can associate as persistently as possible with the various things ruled by \(mostHarmoniousPlanet!) in order to increase their good 'luck'\n\n\(planetDetails(for: mostHarmoniousPlanet)!)"
        planetIntroLabel.font = UIFont.systemFont(ofSize: 15) // adjust the font size as needed
        planetIntroLabel.sizeToFit()
        view.layoutIfNeeded()

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

       
    func setupContent() {
        var lastView: UIView? = nil
        let spaceBetweenGroups: CGFloat = 200
        let initialTopPadding: CGFloat = 715
        let labelSidePadding: CGFloat = 0 // Increase padding space as needed

        for (index, text) in texts.enumerated() {
                let container = UIView()
            container.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1) // Dark grey color

                container.layer.cornerRadius = 8
                container.clipsToBounds = true
                contentView.addSubview(container)
                
            container.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? contentView.topAnchor, constant: lastView == nil ? initialTopPadding : spaceBetweenGroups),
                container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelSidePadding),
                container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelSidePadding)
                // ... other constraints ...
            ])
                
                let label = UILabel()
                label.text = planetInfo(for: mostHarmoniousPlanet)
                label.textColor = .white
                label.numberOfLines = 0
                container.addSubview(label)

                label.translatesAutoresizingMaskIntoConstraints = false
                let labelPadding: CGFloat = 10 // Add padding inside the container
                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: container.topAnchor, constant: labelPadding),
                    label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -labelPadding),
                    label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: labelPadding),
                    label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -labelPadding)
                ])

                if let last = lastView {
                    container.topAnchor.constraint(equalTo: last.bottomAnchor, constant: 20).isActive = true
                } else {
                    container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: initialTopPadding).isActive = true
                }

                lastView = container
            }

        // Setup card image
        let cardImage = UIImageView(image: UIImage(named: harTarot))
        print("Tarot: \(String(describing: harTarot))")
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardImage)

        // Setup additional label
        let additionalLabel = UILabel()
        additionalLabel.text = "Additional Information"
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(additionalLabel)

        // Setup additional button
        let additionalButton = UIButton(type: .system)
        additionalButton.setTitle("Additional Details", for: .normal)
        additionalButton.addTarget(self, action: #selector(showAdditionalDetails), for: .touchUpInside)
        additionalButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(additionalButton)

        // Setup layout constraints
        NSLayoutConstraint.activate([
            cardImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardImage.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? contentView.topAnchor, constant: 50),
            additionalLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            additionalLabel.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 20),
            additionalButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            additionalButton.topAnchor.constraint(equalTo: additionalLabel.bottomAnchor, constant: 20),
            additionalButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        lastView = additionalButton
        lastView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    @objc func showAdditionalDetails() {
        // your code to show additional details
    }
    
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
    
    func planetDetails(for planet: String) -> String? {
        switch planet {
        case "Sun":
            return Planet.sun.planetDetails
        case "Moon":
            return Planet.moon.planetDetails
        case "Mercury":
            return Planet.mercury.planetDetails
        case "Venus":
            return Planet.venus.planetDetails
        case "Mars":
            return Planet.mars.planetDetails
        case "Jupiter":
            return Planet.jupiter.planetDetails
        case "Saturn":
            return Planet.saturn.planetDetails
        case "Uranus":
            return Planet.uranus.planetDetails
        case "Neptune":
            return Planet.neptune.planetDetails
        case "Pluto":
            return Planet.pluto.planetDetails
        default:
            return nil
        }
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
