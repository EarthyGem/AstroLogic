
import Foundation
import UIKit
import SwiftEphemeris

class VocationalAstrologyViewController: UIViewController {

    var chartCake: ChartCake!
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let introLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureIntroLabel()
        configureScrollViewAndStackView()
    }

    private func configureIntroLabel() {
        introLabel.text = """
        Every horoscope includes two key types of vocational indicators, vocational significators and temperament indicators. Temperament indicators are the Sun, Moon, and Ascendant signs. They primarily reveal our true interests and emotional fit for certain careers. It's not uncommon to find highly successful individuals who are profoundly unhappy in their careers. This discontent often stems from a mismatch between their temperament and their job. Have you ever felt bored, despite being proficient at something?

        Conversely, there are those who love their work but achieve little success. In these instances, the Sun, Moon, and Ascendant align with their chosen profession, but the vocational indicators may be unfavorably positioned preventing the anticipated career success.

        Four temperamental indicators are of utmost importance: the Strongest Planet which denotes our greatest aptitudes, Sun, which dictates our core essence and how we project ourselves; the Moon, an indicator of our emotional needs and how we respond to situations; and the Ascendant, representing our approach to life and initial impressions we make.
        """
        introLabel.numberOfLines = 0 // Allows for multiple lines
        introLabel.textAlignment = .center
        introLabel.textColor = UIColor.white
        introLabel.frame = CGRect(x: 15, y: 100, width: view.frame.width - 40, height:
                                    500) // Adjusted frame

        introLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(introLabel)
    }


    private func configureScrollViewAndStackView() {
        // Configure scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        view.addSubview(scrollView)

        // Configure stackView
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(stackView)

        // Add the intro label to the stack view
        stackView.addArrangedSubview(introLabel)

        // Add custom views for Sun, Moon, and Ascendant details
        let sunView = createDetailView(text: chartCake.natal.sun.sign.keyName)
        let moonView = createDetailView(text: chartCake.natal.moon.sign.moonVocation)
        let ascendantView = createDetailView(text: chartCake.natal.ascendant.sign.ascVocation)

        stackView.addArrangedSubview(sunView)
        stackView.addArrangedSubview(moonView)
        stackView.addArrangedSubview(ascendantView)

        // Constraints for scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // Constraints for stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func createDetailView(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0 // Allow for unlimited lines
        label.backgroundColor = .black
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }
}
