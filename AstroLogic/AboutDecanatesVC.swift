import UIKit

class AboutDecanatesViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
           setupContent()
           setupLayout()
    }

    private func setupContent() {
        let title = createLabel(withText: "Planets in Decanates: Discovering Your Dominant Trends", fontSize: 22, isBold: true)
        let intro = createLabel(withText: "In the realm of astrology, your chart reveals more than just planetary positions at the time of your birth. Beyond the zodiac signs, the decanates (each zodiac sign being divided into three decanates) add another layer of nuance, providing a richer understanding of your inherent motivations and potential life paths.")
        let understandingHeader = createLabel(withText: "Understanding Decanates", fontSize: 18, isBold: true)
        let understandingContent = createLabel(withText: "The planets, the ascendant, and the Midheaven in your birth chart are not just arbitrary placements. They are profound markers for your thoughts, feelings, and impulses toward action. These markers exist within specific decanates. The decanate occupied by a planet (or angle) links its core desire with the unique trend of influence that the decanate embodies. This influence is symbolized universally by the corresponding zodiacal constellation.")

        let decanateKeysHeader = createLabel(withText: "Delving Deeper into Keynote Decanates", fontSize: 18, isBold: true)
        let decanateKeysContent = createLabel(withText: """
        * Your Power Planet: This is your chart's powerhouse. It represents your strongest desires. The decanate housing this planet underscores its unique expression and heavily influences your life's theme.
        * Your Sun-sign Decanate: The Sun-sign resonates with the central theme of your life. The associated decanate provides the insights into how to keep your battery charged, shedding light on the source of your vitality.
        * Your Moon-sign Decanate: Representing your mentality and response to daily life, the Moon-decanate offers insights into your cognitive processes (thoughts and feelings). The related decanate specifies your mental attitude, spontaneous attractions, and how you assimilate experiences.
        * Your Ascendant-sign Decanate: This speaks about your personal demeanor and how you navigate through life. The decanate it occupies shapes your physical and personality traits, reflecting how you engage with the world.
        * Your Mercury-sign Decanate: Mercury represents your communication skills and intellectual prowess. Its decanate magnifies your thought processes, expression methods, and how you relate and convey your perceptions.
        """)

        let astrologicalMessageHeader = createLabel(withText: "Deciphering the Astrological Message", fontSize: 18, isBold: true)
        let astrologicalMessageContent = createLabel(withText: "While it's essential to discern the influence of these keynote decanates, one cannot overlook other significant decanates. Especially when a decanate houses multiple planets, its influence intensifies, sending you a potent astrological message. It's recommended to prioritize understanding the decanates that resonate with your personal journey. Immersing too much in decanates with no direct relevance might divert your attention from your actual purpose.")

        let conclusionHeader = createLabel(withText: "Conclusion", fontSize: 18, isBold: true)
        let conclusionContent = createLabel(withText: "The study of decanates invite you on a voyage of self-discovery. By understanding the nuanced messages of these decanates, you can align better with your purpose, making your journey through life more meaningful and fulfilling. Whether you're an astrology enthusiast or a novice, delving into the world of decanates can offer fresh perspectives and valuable insights into your unique life path")

        contentStackView.addArrangedSubview(title)
        contentStackView.addArrangedSubview(intro)
        contentStackView.addArrangedSubview(understandingHeader)
        contentStackView.addArrangedSubview(understandingContent)
        contentStackView.addArrangedSubview(decanateKeysHeader)
        contentStackView.addArrangedSubview(decanateKeysContent)
        contentStackView.addArrangedSubview(astrologicalMessageHeader)
        contentStackView.addArrangedSubview(astrologicalMessageContent)
        contentStackView.addArrangedSubview(conclusionHeader)
        contentStackView.addArrangedSubview(conclusionContent)
    }


    private func createLabel(withText text: String, fontSize: CGFloat = 16, isBold: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        if isBold {
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
        } else {
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
        return label
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
}
