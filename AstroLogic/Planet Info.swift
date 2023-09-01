import Foundation
import UIKit

class SPInfoViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    let texts = ["Text 1", "Text 2", "Text 3", "Text 4", "Text 5", "Text 6", "Text 7", "Text 8", "Text 9"] // Add as many chunks of text as you like
    var infoText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContent()
    }

    func setupScrollView() {
        // Adding scrollView
        view.addSubview(scrollView)
        
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

    func setupContent() {
        var lastView: UIView? = nil
        let spaceBetweenGroups: CGFloat = 100
        let initialTopPadding: CGFloat = 100
        
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
