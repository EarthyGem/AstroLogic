import Foundation
import UIKit

class SPInfoViewController: UIViewController {

  
    var infoText: String?
    let scrollView = UIScrollView()
    let contentView = UIView()
    let texts = ["Text 1", "Text 2", "Text 3", "Text 4", "Text 5", "Text 6", "Text 7", "Text 8", "Text 9"]
    let planetIntroLabel = UILabel()
    let planetImageView = UIImageView()
    var planetName: String = "" // Just an example, set this as needed
    var strongestPlanet: String!
    var mostHarmoniousPlanet: String!
    var mostDiscordantPlanet: String!
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
        planetImageView.image = UIImage(named: strongestPlanet.lowercased())
        contentView.addSubview(planetImageView)
        
        // Define and configure the planet name label
        let planetNameLabel = UILabel()
        planetNameLabel.textAlignment = .center
        planetNameLabel.text = strongestPlanet.capitalized
        planetNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(planetNameLabel)
        
        // Configure and add planet intro label
        planetIntroLabel.textAlignment = .center
        planetIntroLabel.numberOfLines = 0
        planetIntroLabel.text = "This is an introduction to \(strongestPlanet)."
        planetIntroLabel.textColor = .black
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
        let initialTopPadding: CGFloat = 230
        
        for (index, text) in texts.enumerated() {
            let label = UILabel()
            label.text = text
            label.textColor = .white
            label.backgroundColor = UIColor(red: 148/255, green: 0, blue: 211/255, alpha: 1) // Dark lavender color
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            label.textAlignment = .center
            label.numberOfLines = 0
            
            contentView.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
            
            if let last = lastView {
                if index == 5 {  // We check if it's the start of the next group
                    label.topAnchor.constraint(equalTo: last.bottomAnchor, constant: spaceBetweenGroups).isActive = true
                } else {
                    label.topAnchor.constraint(equalTo: last.bottomAnchor, constant: 20).isActive = true
                }
            } else {
                label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: initialTopPadding).isActive = true
            }
            
            lastView = label
        }
        
        lastView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
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
