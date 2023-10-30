//
//  ChartTableCell.swift
//  AstroLogic
//
//  Created by Errick Williams on 8/18/23.
//

import Foundation
import UIKit


class ChartTableViewCell: UITableViewCell {
    var planetImageView: UIImageView!
    var chart: ChartEntity!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        planetImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30)) // Adjust the frame as needed
        planetImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(planetImageView)
        
        // Adjust textLabel's position and size to be to the right of the planetImageView.
        // Ensure there's a gap of 5 points between the image and the text.
        self.textLabel?.frame.origin.x = planetImageView.frame.origin.x + planetImageView.frame.width + 5
        self.textLabel?.frame.size.width = self.contentView.frame.width - (self.textLabel?.frame.origin.x)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Adjust the frames again in case the cell is resized (e.g. due to device rotation or dynamic type)
        self.textLabel?.frame.origin.x = planetImageView.frame.origin.x + planetImageView.frame.width + 5
        self.textLabel?.frame.size.width = self.contentView.frame.width - (self.textLabel?.frame.origin.x)!
    }
}
