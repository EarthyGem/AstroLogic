//
//  CalendarCell.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/3/23.
//

import Foundation
import FSCalendar
import UIKit



class CustomCalendarCell: FSCalendarCell {
    weak var signImageView: UIImageView!
    weak var sunSignImageView: UIImageView!
    weak var celestialBodyImageView: UIImageView!
    weak var houseLabel: UILabel!
    override init!(frame: CGRect) {
        super.init(frame: frame)

        let signImageView = UIImageView()
        signImageView.contentMode = .scaleAspectFit // Adjust as needed
        self.contentView.addSubview(signImageView)
        self.signImageView = signImageView

        let sunSignImageView = UIImageView()
        sunSignImageView.contentMode = .scaleAspectFit // Adjust as needed
        self.contentView.addSubview(sunSignImageView)
        self.sunSignImageView = sunSignImageView
        
        let celestialBodyImageView = UIImageView()
        celestialBodyImageView.contentMode = .scaleAspectFit // Adjust as needed
        self.contentView.addSubview(celestialBodyImageView)
        self.celestialBodyImageView = celestialBodyImageView
        
        let houseLabel = UILabel()
               houseLabel.textAlignment = .center
               houseLabel.font = UIFont.systemFont(ofSize: 10) // Adjust the font size as needed
               self.contentView.addSubview(houseLabel)
               self.houseLabel = houseLabel
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Adjust the frame of the image views based on the cell's layout
        // Example: placing them at the bottom of each cell
        let imageSize: CGFloat = 20
        let imageSize2: CGFloat = 5
        signImageView.frame = CGRect(x: 5, y: self.bounds.height - imageSize - 5, width: imageSize, height: imageSize)
        
        sunSignImageView.frame = CGRect(x: 0, y: self.bounds.height - imageSize2 - 5, width: imageSize2, height: imageSize2)
        celestialBodyImageView.frame = CGRect(x: self.bounds.width - imageSize - 5, y: self.bounds.height - imageSize - 5, width: imageSize, height: imageSize)
        let labelSize: CGFloat = 20
               houseLabel.frame = CGRect(x: self.bounds.width - labelSize - 5, y: self.bounds.height - labelSize - 5, width: labelSize, height: labelSize)
           }
       
}
