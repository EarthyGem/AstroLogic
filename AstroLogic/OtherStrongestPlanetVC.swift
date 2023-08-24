import UIKit
import SwiftEphemeris

class OthersStrongestPlanetViewController: UIViewController {
    
    var strongestPlanetName: String!
    var strongestPlanet: String!
    var mostHarmoniousPlanet: String!
    var mostDiscordantPlanet: String!
    var sentenceText: String!
    var scores: [Planet: CGFloat]?
    var chart: Chart?
    var chartCake: ChartCake?
    var selectedChart: ChartCake?
    var name: String!
    
    // Add
//    var getMinors: (() -> Date)?
//    var getMajorProgresseDate: (() -> Date)?
    
    private let bottomLabel = UILabel()
    private let imageView = UIImageView()
    private let label = UILabel()
    private let titleLabel = UILabel()
    
    private let harmoniousImageView = UIImageView()
    private let harmoniousLabel = UILabel()
    private let harmoniousTitleLabel = UILabel()

    private let discordantImageView = UIImageView()
    private let discordantLabel = UILabel()
    private let discordantTitleLabel = UILabel()
    
//    let planetTexts = [
//        "Sun": SunText,
//        "Moon": MoonText,
//        "Mercury": MercuryText,
//        "Venus": VenusText,
//        "Mars": MarsText,
//        "Jupiter": JupiterText,
//        "Saturn": SaturnText,
//        "Uranus": UranusText,
//        "Neptune": NeptuneText,
//        "Pluto": PlutoText
//    ]

    
    private let myItemsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(StrongestPlanetViewController.self, action: #selector(myItemsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
       configureStrongestImageView()
      configureStrongestLabel()
        configureStrongestTitleLabel(name: name)
        configureHarmoniousImageView()
        configureHarmoniousTitleLabel()
        configureHarmoniousLabel()
        configureDiscordantImageView()
        configureDiscordantTitleLabel()
        configureDiscordantLabel()
        configureBottomLabel()

        let myItemsButton = UIButton(type: .system)
        myItemsButton.setTitle("\(name!)'s Info", for: .normal)
        myItemsButton.addTarget(self, action: #selector(myItemsButtonTapped), for: .touchUpInside)
        myItemsButton.translatesAutoresizingMaskIntoConstraints = false

        let myItemsBarButtonItem = UIBarButtonItem(customView: myItemsButton)
        navigationItem.rightBarButtonItem = myItemsBarButtonItem
    }
     
    @objc func myItemsButtonTapped() {
        // Initialize and push the MyItemsViewController
        let relationshipItemsVC = RelationshipItemsViewController()
        relationshipItemsVC.natalChart = chartCake.self
        relationshipItemsVC.strongestPlanet = strongestPlanet.self
        relationshipItemsVC.selectedChart = chartCake.self
        relationshipItemsVC.name = name.self
        // Pass other properties if needed
        // myItemsVC.strongestPlanet = self.strongestPlanet
        // myItemsVC.getMinors = self.getMinors
        // myItemsVC.getMajorProgresseDate = self.getMajorProgresseDate
        self.navigationController?.pushViewController(relationshipItemsVC, animated: true)
    }

    // ... existing methods
    
    private func configureHarmoniousImageView() {
        guard let imageName = mostHarmoniousPlanet?.lowercased() else {
               // Handle the case when strongestPlanet is nil
               return
           }
        harmoniousImageView.image = UIImage(named: imageName)
        harmoniousImageView.contentMode = .scaleAspectFit
        harmoniousImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(harmoniousImageView)

        NSLayoutConstraint.activate([
            harmoniousImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            harmoniousImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            harmoniousImageView.widthAnchor.constraint(equalToConstant: 100),
            harmoniousImageView.heightAnchor.constraint(equalToConstant: 100)


        ])
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(harmoniousImageViewTapped))
               harmoniousImageView.addGestureRecognizer(tapGestureRecognizer)
               harmoniousImageView.isUserInteractionEnabled = true

    }

    private func configureHarmoniousTitleLabel() {
        harmoniousTitleLabel.text = "Angels"
        harmoniousTitleLabel.textColor = .white
        harmoniousTitleLabel.font = UIFont.systemFont(ofSize: 16)
        harmoniousTitleLabel.textAlignment = .center
        harmoniousTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(harmoniousTitleLabel)

        NSLayoutConstraint.activate([
            harmoniousTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            harmoniousTitleLabel.trailingAnchor.constraint(equalTo: harmoniousImageView.trailingAnchor),
            harmoniousTitleLabel.bottomAnchor.constraint(equalTo: harmoniousImageView.topAnchor, constant: -10),
        ])
    }

    private func configureStrongestImageView() {
        guard let imageName = strongestPlanet?.lowercased() else {
               // Handle the case when strongestPlanet is nil
               return
           }
           imageView.image = UIImage(named: imageName)


        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
    }

    @objc func imageViewTapped() {
        let infoViewController = InfoViewController()
        if self.strongestPlanet != nil
         {
            infoViewController.infoText = theSun
        } else {
            infoViewController.infoText = "Information not found for Strongest Planet"
        }
        self.present(infoViewController, animated: true, completion: nil)
    }
//
    @objc func harmoniousImageViewTapped() {
        let infoViewController = InfoViewController()
        if self.mostHarmoniousPlanet != nil {
          
            infoViewController.infoText = ""
        } else {
            infoViewController.infoText = "Information not found for Harmonious Planet"
        }
        self.present(infoViewController, animated: true, completion: nil)
    }

    @objc func discordantImageViewTapped() {
        let infoViewController = InfoViewController()
        if self.mostDiscordantPlanet != nil
          {
            infoViewController.infoText = ""
        } else {
            infoViewController.infoText = "Information not found for Discordant Planet"
        }
        self.present(infoViewController, animated: true, completion: nil)
    }

    
    
    private func configureStrongestTitleLabel(name: String) {
        titleLabel.text = "\(name)'s Power Planet"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -20),
        ])
    }
    
  

        
        
        // Initialize and push the ChartViewController
     
        
        //        birthChartView = BirthChartView(frame: view.bounds, chartCake: chartCake!)


    private func configureStrongestLabel() {
        label.text = strongestPlanet
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
        ])
    }

    private func configureHarmoniousLabel() {
        harmoniousLabel.text = mostHarmoniousPlanet
        harmoniousLabel.textColor = .white
        harmoniousLabel.font = UIFont.systemFont(ofSize: 16)
        harmoniousLabel.textAlignment = .center
        harmoniousLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(harmoniousLabel)

        NSLayoutConstraint.activate([
            harmoniousLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            harmoniousLabel.trailingAnchor.constraint(equalTo: harmoniousImageView.trailingAnchor),
            harmoniousLabel.topAnchor.constraint(equalTo: harmoniousImageView.bottomAnchor, constant: 10),
        ])
    }

    private func configureDiscordantImageView() {
        guard let imageName = mostDiscordantPlanet?.lowercased() else {
               // Handle the case when strongestPlanet is nil
               return
           }
        discordantImageView.image = UIImage(named: imageName)
        discordantImageView.contentMode = .scaleAspectFit
        discordantImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(discordantImageView)

        NSLayoutConstraint.activate([
            discordantImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            discordantImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20), discordantImageView.widthAnchor.constraint(equalToConstant: 100),
            discordantImageView.heightAnchor.constraint(equalToConstant: 100)
            ])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(discordantImageViewTapped))
           discordantImageView.addGestureRecognizer(tapGestureRecognizer)
           discordantImageView.isUserInteractionEnabled = true
            }


            private func configureDiscordantTitleLabel() {
                discordantTitleLabel.text = "Demons"
                discordantTitleLabel.textColor = .white
                discordantTitleLabel.font = UIFont.systemFont(ofSize: 16)
                discordantTitleLabel.textAlignment = .center
                discordantTitleLabel.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(discordantTitleLabel)

                NSLayoutConstraint.activate([
                    discordantTitleLabel.leadingAnchor.constraint(equalTo: discordantImageView.leadingAnchor),
                    discordantTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    discordantTitleLabel.bottomAnchor.constraint(equalTo: discordantImageView.topAnchor, constant: -10),
                ])
            }

            private func configureDiscordantLabel() {
                discordantLabel.text = mostDiscordantPlanet
                discordantLabel.textColor = .white
                discordantLabel.font = UIFont.systemFont(ofSize: 16)
                discordantLabel.textAlignment = .center
                discordantLabel.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(discordantLabel)

                NSLayoutConstraint.activate([
                    discordantLabel.leadingAnchor.constraint(equalTo: discordantImageView.leadingAnchor),
                    discordantLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    discordantLabel.topAnchor.constraint(equalTo: discordantImageView.bottomAnchor, constant: 10),
                ])
            }

//            func getPlanetOrSignData(planetOrSign: String) -> [String] {
//                return PlanetData.data[planetOrSign] ?? []
//            }



    
    private func configureBottomLabel() {
           bottomLabel.text = sentenceText
           bottomLabel.textColor = .white
           bottomLabel.font = UIFont.systemFont(ofSize: 18)
        bottomLabel.lineBreakMode = .byWordWrapping
        bottomLabel.numberOfLines = 0
           bottomLabel.textAlignment = .center
           bottomLabel.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(bottomLabel)
           
           NSLayoutConstraint.activate([
               bottomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               bottomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               bottomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
           ])
       }
   }
            
           
