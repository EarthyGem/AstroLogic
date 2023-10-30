//
//  HousesCustomTableViewCell.swift
//  MVP
//
//  Created by Errick Williams on 8/27/22.
//

import UIKit

class AspectsCustomTableViewCell: UITableViewCell {

    static let identifier = "AspectsCustomTableViewCell"
       
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
    
       
       private let tableCell: UIView = {
           let tableCell = UIView()
           
           
           return tableCell
       
       }()
       
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
           super.init(style: style, reuseIdentifier:  reuseIdentifier)
           
           
           contentView.backgroundColor = .black
           
   contentView.addSubview(tableCell)
           contentView.tintColor = . yellow
           contentView.addSubview(secondPlanetImageView)
           contentView.addSubview(firstPlanetImageView)
           tableCell.frame = CGRect(x: 0, y: 5, width: 355, height: 75)
           
   //        tableCell.backgroundColor = .darkGray
           tableCell.backgroundColor = UIColor.darkGray.withAlphaComponent(0.25)
           tableCell.isOpaque = false

           tableCell.layer.cornerRadius = 20
          
           firstPlanetText.text = "Sun"
           firstPlanetText.font = .systemFont(ofSize: 29)
           firstPlanetText.textColor = .white
           firstPlanetText.font = UIFont.boldSystemFont(ofSize: firstPlanetText.font.pointSize)
            contentView.addSubview(firstPlanetText)
           
           secondPlanetText.text = "Sun"
           secondPlanetText.font = .systemFont(ofSize: 29)
           secondPlanetText.textColor = .white
           secondPlanetText.font = UIFont.boldSystemFont(ofSize: secondPlanetText.font.pointSize)
            contentView.addSubview(secondPlanetText)
           

           secondAspectHeaderText.text = "Social Urges"
           secondAspectHeaderText.font = .systemFont(ofSize: 14)
           secondAspectHeaderText.textColor = .white
           secondAspectHeaderText.lineBreakMode = .byWordWrapping
           secondAspectHeaderText.numberOfLines = 3
          
            contentView.addSubview(secondAspectHeaderText)
           
           
          firstAspectHeaderText.text = "Power Urges"
           firstAspectHeaderText.font = .systemFont(ofSize: 14)
           firstAspectHeaderText.textColor = .white
           firstAspectHeaderText.lineBreakMode = .byWordWrapping
           firstAspectHeaderText.numberOfLines = 3
          
            contentView.addSubview(firstAspectHeaderText)
           

           firstSignText.text = "Gemini"
           firstSignText.font = .systemFont(ofSize: 14)
           firstSignText.textColor = .gray
           firstSignText.font = UIFont.boldSystemFont(ofSize: firstSignText.font.pointSize)
            contentView.addSubview(firstSignText)
           
           secondSignText.text = "Gemini"
           secondSignText.font = .systemFont(ofSize: 14)
           secondSignText.textColor = .gray
           secondSignText.font = UIFont.boldSystemFont(ofSize: secondSignText.font.pointSize)
            contentView.addSubview(secondSignText)
           
           
           firstSignGlyph.image = UIImage(named: "WhiteSun")
           
            contentView.addSubview(firstSignGlyph)
           firstSignGlyph.backgroundColor = .clear
            
           
           secondSignGlyph.image = UIImage(named: "WhiteSun")
           
            contentView.addSubview(secondSignGlyph)
           secondSignGlyph.backgroundColor = .clear
            
           
           
          
           
          
           firstPlanetGlyph.image = UIImage(named: "WhiteSun")
          
           contentView.addSubview(firstPlanetGlyph)
           firstPlanetGlyph.backgroundColor = .clear
           
           secondPlanetImageView.image = UIImage(named: "WhiteSun")
          
           contentView.addSubview(secondPlanetImageView)
           secondPlanetImageView.backgroundColor = .clear
           
          
           firstPlanetImageView.backgroundColor = .clear
           secondPlanetImageView.backgroundColor = .clear
           firstPlanetImageView.image = UIImage(named: "Moon")
           firstPlanetImageView.contentMode = .scaleToFill
           secondPlanetImageView.image = UIImage(named: "Sun")
           secondPlanetImageView.contentMode = .scaleToFill
           
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
           
       }
       
    public func configure(aspectingPlanet: String, secondPlanetImageImageName: String, firstSignTextText: String, secondSignTextText: String, secondPlanetTextText: String, firstPlanetTextText: String,firstAspectHeaderTextText: String,secondAspectHeaderTextText: String ) {
           
//                   planetGlyphImageName
//           firstSignGlyph.frame = CGRect(x: 10, y: 20, width: 14, height: 15)
//
//           secondSignGlyph.frame = CGRect(x: 50, y: 20, width: 14, height: 15)
           firstPlanetImageView.image = UIImage(named: aspectingPlanet)
           
           secondPlanetImageView.image = UIImage(named: secondPlanetImageImageName
           )
//           firstPlanetGlyph.image = UIImage(named: planetGlyphImageName)
//
//           secondPlanetGlyph.image = UIImage(named: planetGlyphImageName)
//           secondSignGlyph.image = UIImage(named: signGlyphImageName)
//
//           firstSignGlyph.image = UIImage(named: signGlyphImageName)
        firstSignText.text = firstSignTextText
           firstPlanetText.text = firstPlanetTextText
        secondSignText.text = secondSignTextText
           secondPlanetText.text = secondPlanetTextText
           firstAspectHeaderText.text = firstAspectHeaderTextText

       secondAspectHeaderText.text = secondAspectHeaderTextText

           
       }
       override func prepareForReuse() {
           super.prepareForReuse()
           firstPlanetImageView.image = nil
           secondPlanetImageView.image = nil
           firstPlanetGlyph.image = nil
           secondPlanetGlyph.image = nil
           firstSignGlyph.image = nil
          secondSignGlyph.image = nil
           firstSignText.text = nil
           firstPlanetText.text = nil
           secondSignText.text = nil
           secondPlanetText.text = nil
           firstAspectHeaderText.text = nil
           secondAspectHeaderText.text = nil
           
       }
       override func layoutSubviews() {
           super.layoutSubviews()
           
           firstSignGlyph.frame = CGRect(x: 10, y: 20, width: 14, height: 15)
        
           secondSignGlyph.frame = CGRect(x: 60, y: 20, width: 14, height: 15)
//           planetGlyph.frame = CGRect(x: 10, y: 44, width: 12, height: 13)
          
           firstSignText.frame = CGRect(x: 30, y: 18, width: 300, height: 20)
           
           
           secondSignText.frame = CGRect(x: 255, y: 18, width: 300, height: 20)
           
           firstPlanetText.frame = CGRect(x: 10, y: 35, width: 300, height: 40)
           
           
           secondPlanetText.frame = CGRect(x: 255, y: 18, width: 300, height: 20)
           
           secondPlanetText.frame = CGRect(x: 255, y: 35, width: 300, height: 40)
           
           firstPlanetImageView.frame = CGRect(x: 20, y: 75, width: 55, height: 55)
          
           secondPlanetImageView.frame = CGRect(x: 255, y: 75, width: 55, height: 55)
           
           firstAspectHeaderText.frame = CGRect(x: 10, y: 90, width: 255, height: 100)
           
           secondAspectHeaderText.frame = CGRect(x: 255, y: 90, width: 200, height: 100)
           
       }

   }
