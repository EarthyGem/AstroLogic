//
//  HousesCustomTableViewCell.swift
//  MVP
//
//  Created by Errick Williams on 8/27/22.
//

import UIKit

class FakeNewAspectsCustomTableViewCell: UITableViewCell {

    static let identifier = "NewAspectsCustomTableViewCell"
       
     
    private let secondPlanetText: UILabel = {
        let secondPlanetText = UILabel()
        
        
        return secondPlanetText
        
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
           
             
      
           tableCell.frame = CGRect(x: 0, y: 5, width: contentView.frame.width, height: 75)
           
          
           
   //        tableCell.backgroundColor = .darkGray
           tableCell.backgroundColor = UIColor.darkText
           tableCell.isOpaque = false

           tableCell.layer.cornerRadius = 20
           contentView.addSubview(tableCell)

          
         
           
           secondPlanetText.text = "Sun"
           secondPlanetText.font = .systemFont(ofSize: 16)
           secondPlanetText.textColor = .white
//           secondPlanetText.font = UIFont.boldSystemFont(ofSize: secondPlanetText.font.pointSize)
            contentView.addSubview(secondPlanetText)
           

        
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
           
       }
       
    public func configure(secondPlanetTextText: String) {
        
        //                   planetGlyphImageName
        //           firstSignGlyph.frame = CGRect(x: 10, y: 20, width: 14, height: 15)
        //
        //           secondSignGlyph.frame = CGRect(x: 50, y: 20, width: 14, height: 15)
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
   
           secondPlanetText.text = nil
     
           
           myTransit1.text = nil
           myTransit2.text = nil
           myTransit3.text = nil
           myTransit4.text = nil
        
            
           
       }
       override func layoutSubviews() {
           super.layoutSubviews()
           
         
           
         
           
           
           myTransit4.frame = CGRect(x: 20, y: 260, width: 325, height: 80)
           myTransit3.frame = CGRect(x: 20, y: 195, width: 325, height: 80)
           myTransit2.frame = CGRect(x: 20, y: 125, width: 325, height: 80)
           myTransit1.frame = CGRect(x: 20, y: 60, width: 325, height: 80)
        
           
           secondPlanetText.frame = CGRect(x: 20, y: 25, width: 300, height: 40)
           
     
           
           jupiterSunView.frame = CGRect(x: 0, y: 0, width: tableCell.frame.size.width, height: 300)
           
       }

   }
