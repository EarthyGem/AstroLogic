//
//  SynastryCustomTableCell.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/18/24.
//

import Foundation
//
//  CustomTableViewCell.swift
//  MVP
//
//  Created by Errick Williams on 8/24/22.
//

import UIKit

class SynastryCustomTableViewCell: UITableViewCell {

 static let identifier = "CustomTableViewCell"
    
    private let planetImageView: UIImageView = {
        let planetImageView = UIImageView()
        
        
        return planetImageView
        
    }()
    
    private let planetGlyph1: UIImageView = {
        let planetGlyph1 = UIImageView()
        
        
        return planetGlyph1
        
    }()
    
    private let planetGlyph2: UIImageView = {
        let planetGlyph2 = UIImageView()
        
        
        return planetGlyph2
        
    }()
    
    private let capsuleView: UIView = {
          let view = UIView()
          view.layer.cornerRadius = 10 // Adjust for desired curvature
          view.backgroundColor = .systemBlue // Choose your color
          return view
      }()

    private let capsuleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white // Choose your text color

        // Set the font to a bold and italic system font if available
        if let font = UIFont(name: "Helvetica-BoldOblique", size: 10) {
            label.font = font
        } else {
            // Alternatively, set to a default font
            label.font = UIFont.systemFont(ofSize: 9)
        }

        return label
    }()
    
    private let capsuleView2: UIView = {
          let view = UIView()
          view.layer.cornerRadius = 10 // Adjust for desired curvature
          view.backgroundColor = .systemBlue // Choose your color
          return view
      }()

    private let capsuleLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white // Choose your text color

        // Set the font to a bold and italic system font if available
        if let font = UIFont(name: "Helvetica-BoldOblique", size: 10) {
            label.font = font
        } else {
            // Alternatively, set to a default font
            label.font = UIFont.systemFont(ofSize: 9)
        }

        return label
    }()
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
        headerText.font = .systemFont(ofSize: 14)
        headerText.textColor = .white
        headerText.lineBreakMode = .byWordWrapping
        headerText.numberOfLines = 3
       
         contentView.addSubview(headerText)
        

        signText.text = "Gemini"
        signText.font = .systemFont(ofSize: 14)
        signText.textColor = .gray
        signText.font = UIFont.boldSystemFont(ofSize: signText.font.pointSize)
         contentView.addSubview(signText)
        
       
        planetGlyph1.image = UIImage(named: "orangeGemini")
        planetGlyph1.image?.withTintColor(UIColor.yellow)
        
        contentView.addSubview(planetGlyph1)
        planetGlyph1.backgroundColor = .clear
        
        planetGlyph2.image = UIImage(named: "orangeGemini")
        planetGlyph2.image?.withTintColor(UIColor.yellow)
        
        contentView.addSubview(planetGlyph2)
        planetGlyph2.backgroundColor = .clear
        
        
       
//        planetGlyph.image = UIImage(named: "WhiteSun")
        contentView.addSubview(planetGlyph2)
//        contentView.addSubview(planetGlyph)
//        planetGlyph.backgroundColor = .clear
        contentView.addSubview(planetGlyph1)
       
        planetImageView.backgroundColor = .clear
        
        planetImageView.image = UIImage(named: "Sun")
        planetImageView.contentMode = .scaleToFill
        capsuleView.addSubview(capsuleLabel)
             contentView.addSubview(capsuleView)
        capsuleView2.addSubview(capsuleLabel2)
             contentView.addSubview(capsuleView2)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    public func configure(planetGlyphImageName1: String, planetGlyphImageName2: String, planetImageImageName: String, signTextText: String, planetTextText: String, headerTextText: String, capsuleText: String, capsuleText2: String)  {
         // ... existing configuration code ...

         // Configure the capsule label
         capsuleLabel.text = capsuleText
        capsuleLabel2.text = capsuleText2
        planetImageView.image = UIImage(named: planetImageImageName)
//        planetGlyph.image = UIImage(named: planetGlyphImageName)
      planetGlyph1.image = UIImage(named: planetGlyphImageName1)
        planetGlyph2.image = UIImage(named: planetGlyphImageName2)
        signText.text = signTextText
        planetText.text = planetTextText
        headerText.text = headerTextText
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        planetImageView.image = nil
//        planetGlyph.image = nil
       planetGlyph1.image = nil
        planetGlyph1.image = nil
        signText.text = nil
        planetText.text = nil
        headerText.text = nil
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        planetGlyph1.frame = CGRect(x: 10, y: 20, width: 14, height: 15)
        planetGlyph2.frame = CGRect(x: 10, y: 100, width: 14, height: 15)
//        planetGlyph.frame = CGRect(x: 10, y: 44, width: 12, height: 13)
       
        signText.frame = CGRect(x: 30, y: 18, width: 300, height: 20)
        planetText.frame = CGRect(x: 10, y: 35, width: 300, height: 40)
        
        planetImageView.frame = CGRect(x: 255, y: 40, width: 55, height: 55)
        
        headerText.frame =  CGRect(x: 30, y: 98, width: 300, height: 20)
        
        let capsuleWidth: CGFloat = 65
            let capsuleHeight: CGFloat = 20
            let capsuleX: CGFloat = contentView.bounds.width - capsuleWidth - 10 // For example, 10 points from the right edge
            let capsuleY: CGFloat = 20 // Adjust the Y-coordinate as needed

        capsuleView.frame = CGRect(x: 10, y: 40, width: capsuleWidth, height: capsuleHeight)
        capsuleLabel.frame = CGRect(x: 0, y: 0, width: capsuleWidth, height: capsuleHeight)
                                        
        capsuleView2.frame = CGRect(x: 10, y: 120, width: capsuleWidth, height: capsuleHeight)
        capsuleLabel2.frame = CGRect(x: 0, y: 0, width: capsuleWidth, height: capsuleHeight)
    }

}
