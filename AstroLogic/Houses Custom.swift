//
//  HousesCustomTableViewCell.swift
//  MVP
//
//  Created by Errick Williams on 8/27/22.
//

import UIKit

class HousesCustomTableViewCell: UITableViewCell {

    static let identifier = "HousesCustomTableViewCell"
       
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
    
    
//    private let firstSignText: UILabel = {
//        let firstSignText = UILabel()
//
//
//        return firstSignText
//
//    }()
//
    private let myTransit1: UILabel = {
        let myTransit1 = UILabel()
        
        
        return myTransit1
        
    }()
    
    private let myTransit2: UILabel = {
        let myTransit2 = UILabel()
        
        
        return myTransit2
        
    }()
    
    
    private let myTransit3: UILabel = {
        let myTransit3 = UILabel()
        
        
        return myTransit3
        
    }()
    
    
    
    
    private let myTransit4: UILabel = {
        let myTransit1 = UILabel()
        
        
        return myTransit1
        
    }()
    
    public let dropDown: UIView = {
        let dropDown = UIView()
       
        return dropDown
    }()
    
    
    
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
           super.init(style: style, reuseIdentifier:  reuseIdentifier)
           
           
           
           contentView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width + 35, height: 75)
           
           backgroundColor = .black
           contentView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.20)
           
             
           contentView.addSubview(secondPlanetImageView)
           contentView.addSubview(firstPlanetImageView)
           tableCell.frame = CGRect(x: 0, y: 5, width: contentView.frame.width, height: 75)
           
          
           
   //        tableCell.backgroundColor = .darkGray
           tableCell.backgroundColor = UIColor.darkText
           tableCell.isOpaque = false

           tableCell.layer.cornerRadius = 20
           contentView.addSubview(tableCell)

          
           firstPlanetText.text = "Sun"
           firstPlanetText.font = .systemFont(ofSize: 16)
           firstPlanetText.textColor = .white
           firstPlanetText.font = UIFont.boldSystemFont(ofSize: firstPlanetText.font.pointSize)
            contentView.addSubview(firstPlanetText)
           
           secondPlanetText.text = "Sun"
           secondPlanetText.font = .systemFont(ofSize: 16)
           secondPlanetText.textColor = .white
//           secondPlanetText.font = UIFont.boldSystemFont(ofSize: secondPlanetText.font.pointSize)
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
            
           
//
//           myTransit1.frame = CGRect(x: 20, y: 0, width: 325, height: 100)
//            myTransit1.text = "Any aspect of the Sun affects the vitality, the significance, and the authority."
//            myTransit1.textColor = .white
//            myTransit1.font = .systemFont(ofSize: 13)
//           contentView.addSubview(myTransit1)
//            myTransit1.lineBreakMode = .byWordWrapping
//            myTransit1.numberOfLines = 0
//
//
//           myTransit1.text = "The Opportunity: The ability to alter basic values and priorities, thereby allowing one’s actual behavior to reflect developments in his or her evolving inner life."
//           myTransit1.textColor = .white
//           myTransit1.font = .systemFont(ofSize: 13)
//           contentView.addSubview(myTransit1)
//           myTransit1.lineBreakMode = .byWordWrapping
//           myTransit1.numberOfLines = 0
//
//            myTransit2.text = "The Challenge: Are you strong enough to change the very basis of your identity, allowing yourself the freedom to become what you have never been before"
//            myTransit2.textColor = .white
//            myTransit2.font = .systemFont(ofSize: 13)
//           contentView.addSubview(myTransit2)
//            myTransit2.lineBreakMode = .byWordWrapping
//            myTransit2.numberOfLines = 0
//           myTransit4.frame = CGRect(x: 20, y: 260, width: 325, height: 80)
//           myTransit3.frame = CGRect(x: 20, y: 195, width: 325, height: 80)
//            myTransit3.text = "The Trap: The pitfall of over-centralizing ego in one’s self-image, ignoring the needs of the larger psyche, infringing on the rights of others, and flattering one’s self into foolish overextension."
//            myTransit3.textColor = .white
//            myTransit3.font = .systemFont(ofSize: 13)
//           contentView.addSubview(myTransit3)
//            myTransit3.lineBreakMode = .byWordWrapping
//            myTransit3.numberOfLines = 0
//
//
//            myTransit4.text = "The Lie: You are the center of the universe. The Lie: You are the center of the universe."
//            myTransit4.textColor = .white
//            myTransit4.font = .systemFont(ofSize: 13)
//           contentView.addSubview(myTransit4)
//            myTransit4.lineBreakMode = .byWordWrapping
//            myTransit4.numberOfLines = 0
//
//
           
          
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
    
    
    public func dropDownText(transit1: String, transit2: String, transit3: String, transit4: String, myTableCell: UIView) {
           
//
        myTransit1.text = transit1
        myTransit2.text = transit2
        myTransit3.text = transit3
        myTransit4.text = transit4
        tableCell = dropDown
         
           
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
           
           myTransit1.text = nil
           myTransit2.text = nil
           myTransit3.text = nil
           myTransit4.text = nil
        
            
           
       }
       override func layoutSubviews() {
           super.layoutSubviews()
           
         
           
           firstSignGlyph.frame = CGRect(x: 10, y: 20, width: 14, height: 15)
        
           secondSignGlyph.frame = CGRect(x: 60, y: 20, width: 14, height: 15)
//           planetGlyph.frame = CGRect(x: 10, y: 44, width: 12, height: 13)
          
           firstSignText.frame = CGRect(x: 30, y: 18, width: 300, height: 20)
           
           
           secondSignText.frame = CGRect(x: 255, y: 18, width: 300, height: 20)
           
           firstPlanetText.frame = CGRect(x: 40, y: 0, width: 300, height: 40)
           
           
           myTransit4.frame = CGRect(x: 20, y: 260, width: 325, height: 80)
           myTransit3.frame = CGRect(x: 20, y: 195, width: 325, height: 80)
           myTransit2.frame = CGRect(x: 20, y: 125, width: 325, height: 80)
           myTransit1.frame = CGRect(x: 20, y: 60, width: 325, height: 80)
        
           
           secondPlanetText.frame = CGRect(x: 50, y: 22, width: 300, height: 40)
           
           firstPlanetImageView.frame = CGRect(x: 20, y: 75, width: 55, height: 55)
          
           secondPlanetImageView.frame = CGRect(x: 15, y: 25, width: 30, height: 30)
           
           firstAspectHeaderText.frame = CGRect(x: 10, y: 90, width: 255, height: 100)
           
           secondAspectHeaderText.frame = CGRect(x: 255, y: 90, width: 200, height: 100)
           
           jupiterSunView.frame = CGRect(x: 0, y: 0, width: tableCell.frame.size.width, height: 300)
           
       }

   }
