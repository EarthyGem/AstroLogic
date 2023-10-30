//
//  NatalHousesCustomCell.swift
//  MVP
//
//  Created by Errick Williams on 8/27/22.
//

import UIKit

class NatalHousesCustomCell: UITableViewCell {

    static let identifier = "NatalHousesCustomCell"

       private let firstPlanetImageView: UIImageView = {
           let firstPlanetImageView = UIImageView()


           return firstPlanetImageView

       }()

    private let secondPlanetImageView: UIImageView = {
        let secondPlanetImageView = UIImageView()


        return secondPlanetImageView

    }()

    private let firstSignGlyph: UIImageView = {
        let firstSignGlyph = UIImageView()


        return firstSignGlyph

    }()

    private let secondSignGlyph: UIImageView = {
        let secondSignGlyph = UIImageView()


        return secondSignGlyph

    }()

       private let firstPlanetGlyph: UIImageView = {
           let firstPlanetGlyph = UIImageView()


           return firstPlanetGlyph

       }()



    private let secondPlanetGlyph: UIImageView = {
        let secondPlanetGlyph = UIImageView()


        return secondPlanetGlyph

    }()

       private let firstSignText: UILabel = {
           let firstSignText = UILabel()


           return firstSignText

       }()


    private let secondSignText: UILabel = {
        let secondSignText = UILabel()


        return secondSignText

    }()

       private let firstPlanetText: UILabel = {
           let firstPlanetText = UILabel()


           return firstPlanetText

       }()

    private let secondPlanetText: UILabel = {
        let secondPlanetText = UILabel()


        return secondPlanetText

    }()

       private let firstAspectHeaderText: UILabel = {
           let firstAspectHeaderText = UILabel()


           return firstAspectHeaderText

       }()

    private let secondAspectHeaderText: UILabel = {
        let secondAspectHeaderText = UILabel()


        return secondAspectHeaderText

    }()


    private var tableCell: UIView = {
           let tableCell = UIView()


           return tableCell

       }()

   public let jupiterSunView: UIView = {
        let jupiterSunView = UIView()

        return jupiterSunView
    }()

    private let topTransitImage: UIImageView = {
        let topTransitImage = UIImageView()


        return topTransitImage

    }()


       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
           super.init(style: style, reuseIdentifier:  reuseIdentifier)



           contentView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width + 35, height: 75)

           backgroundColor = .black
           contentView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)

           tableCell.frame = CGRect(x: 0, y: 5, width: contentView.frame.width, height: 75)



   //        tableCell.backgroundColor = .darkGray
           tableCell.backgroundColor = UIColor.darkText
           tableCell.isOpaque = false

           tableCell.layer.cornerRadius = 20
           contentView.addSubview(tableCell)


           firstPlanetText.text = "Sun"
           firstPlanetText.font = .systemFont(ofSize: 13)
           firstPlanetText.textColor = .white
           firstPlanetText.numberOfLines = 0
           firstPlanetText.adjustsFontSizeToFitWidth = true
         //  firstPlanetText.font = UIFont.boldSystemFont(ofSize: firstPlanetText.font.pointSize)
            contentView.addSubview(firstPlanetText)


           firstSignText.text = "Gemini"
           firstSignText.font = .systemFont(ofSize: 14)
           firstSignText.textColor = .gray
           firstSignText.font = UIFont.boldSystemFont(ofSize: firstSignText.font.pointSize)
            contentView.addSubview(firstSignText)








           firstPlanetImageView.backgroundColor = .clear
           firstPlanetImageView.image = UIImage(named: "Moon")
           firstPlanetImageView.contentMode = .scaleToFill
           contentView.addSubview(firstPlanetImageView)

       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")

       }

    public func configure(aspectingPlanet: String, aspectingPlanetSign: String, aspectingPlanetString: String) {


        firstPlanetImageView.image = UIImage(named: aspectingPlanet
           )

        firstSignText.text = aspectingPlanetSign
           firstPlanetText.text = aspectingPlanetString


       }



       override func prepareForReuse() {
           super.prepareForReuse()
           firstPlanetImageView.image = nil
           firstSignText.text = nil
           firstPlanetText.text = nil




       }
       override func layoutSubviews() {
           super.layoutSubviews()




           firstPlanetImageView.frame = CGRect(x: 10, y: 10, width: 18, height: 18)

           firstSignText.frame = CGRect(x: 30, y: 11, width: 300, height: 20)


           firstPlanetText.frame = CGRect(x: 15, y: 13, width: 330, height: 80)




       }

   }
