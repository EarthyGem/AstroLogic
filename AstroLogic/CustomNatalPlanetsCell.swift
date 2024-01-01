//
//  CustomTableViewCell.swift
//  MVP
//
//  Created by Errick Williams on 8/24/22.
//

import UIKit

class CustomNatalPlanetsTableViewCell: UITableViewCell {

 static let identifier = "CustomTableViewCell"

    private let planetImageView: UIImageView = {
        let planetImageView = UIImageView()


        return planetImageView

    }()

    private let signGlyph: UIImageView = {
        let signGlyph = UIImageView()


        return signGlyph

    }()

//    private let planetGlyph: UIImageView = {
//        let planetGlyph = UIImageView(image: #imageLiteral(resourceName: "Sun2.png"))
//
//
//        return planetGlyph
//
//    }()
//
    private let signText: UILabel = {
        let signText = UILabel()


        return signText

    }()

    private let planetText: UILabel = {
        let planetText = UILabel()


        return planetText

    }()

    private let headerText: UILabel = {
        let headerText = UILabel()


        return headerText

    }()

    private let tableCell: UIView = {
        let tableCell = UIView()


        return tableCell

    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)


        contentView.backgroundColor = .black

contentView.addSubview(tableCell)
        contentView.tintColor = . yellow

        contentView.addSubview(planetImageView)
        tableCell.frame = CGRect(x: 0, y: 5, width: 355, height: 153)

//        tableCell.backgroundColor = .darkGray
        tableCell.backgroundColor = UIColor.darkGray.withAlphaComponent(0.25)
        tableCell.isOpaque = false

        tableCell.layer.cornerRadius = 20

        planetText.text = "Sun"
        planetText.font = .systemFont(ofSize: 22)
        planetText.textColor = .white
        planetText.font = UIFont.boldSystemFont(ofSize: planetText.font.pointSize)
         contentView.addSubview(planetText)



        headerText.text = "You chose to be a Gemini: to develop a radically open mind, to perceive..."
        headerText.font = .systemFont(ofSize: 13)
        headerText.textColor = .white
        headerText.lineBreakMode = .byWordWrapping
        headerText.numberOfLines = 4

         contentView.addSubview(headerText)


        signText.text = "Gemini"
        signText.font = .systemFont(ofSize: 14)
        signText.textColor = .gray
        signText.font = UIFont.boldSystemFont(ofSize: signText.font.pointSize)
         contentView.addSubview(signText)


        signGlyph.image = UIImage(named: "orangeGemini")
        signGlyph.image?.withTintColor(UIColor.yellow)

        contentView.addSubview(signGlyph)
        signGlyph.backgroundColor = .clear



//        planetGlyph.image = UIImage(named: "WhiteSun")
        contentView.addSubview(signGlyph)
//        contentView.addSubview(planetGlyph)
//        planetGlyph.backgroundColor = .clear


        planetImageView.backgroundColor = .clear

        planetImageView.image = UIImage(named: "Sun")
        planetImageView.contentMode = .scaleToFill


    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

    public func configure(signGlyphImageName: String, planetImageImageName: String, signTextText: String, planetTextText: String, headerTextText: String)  {



        planetImageView.image = UIImage(named: planetImageImageName)
//        planetGlyph.image = UIImage(named: planetGlyphImageName)
        signGlyph.image = UIImage(named: signGlyphImageName)
        signText.text = signTextText
        planetText.text = planetTextText
        headerText.text = headerTextText


    }
    override func prepareForReuse() {
        super.prepareForReuse()
        planetImageView.image = nil
//        planetGlyph.image = nil
        signGlyph.image = nil
        signText.text = nil
        planetText.text = nil
        headerText.text = nil


    }
    override func layoutSubviews() {
        super.layoutSubviews()


        signGlyph.frame = CGRect(x: 10, y: 20, width: 14, height: 15)
//        planetGlyph.frame = CGRect(x: 10, y: 44, width: 12, height: 13)

        signText.frame = CGRect(x: 30, y: 18, width: 300, height: 20)
        planetText.frame = CGRect(x: 10, y: 35, width: 300, height: 40)

        planetImageView.frame = CGRect(x: 255, y: 40, width: 55, height: 55)

        headerText.frame = CGRect(x: 10, y: planetText.frame.minY - 5, width: 240, height: 100)

    }

}
