//
//  Harmony Discord BarView.swift
//  AstroLogic
//
//  Created by Errick Williams on 11/18/23.
//

import Foundation
import UIKit
import SwiftEphemeris

class HarmonyDiscordBarView: UIView {
    
    private let nameLabel = UILabel()
    private let harmonyBarView = UIView()
    private let discordBarView = UIView()
    private let netScoreLabel = UILabel()
    
    // Constants for layout
    private let barHeight: CGFloat = 5.0
    private let barSpacing: CGFloat = 2.5
    private let labelHeight: CGFloat = 20.0
    private let labelToBarSpacing: CGFloat = 10.0 // Space between label and bars
    
    var name: String = "" {
        didSet {
            nameLabel.text = "\(name)"
        }
    }
    
    var harmonyScore: Double = 0 {
        didSet {
            updateBarLayout()
        }
    }
    
    var discordScore: Double = 0 {
        didSet {
            updateBarLayout()
        }
    }
    
    var netScore: Double = 0 {
        didSet {
            netScoreLabel.text = "\(Int(netScore))"
        }
    }
    
    init(frame: CGRect, name: String, harmonyScore: Double, discordScore: Double, netScore: Double) {
        super.init(frame: frame)
        self.name = name
        self.harmonyScore = harmonyScore
        self.discordScore = discordScore
        self.netScore = netScore
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
         // Name label setup
         nameLabel.textColor = .white
         nameLabel.font = UIFont.systemFont(ofSize: 13)
         nameLabel.textAlignment = .right
         nameLabel.frame = CGRect(x: 10, y: 0, width: 50, height: labelHeight)
         self.addSubview(nameLabel)
         
         // Net score label setup
         netScoreLabel.textColor = .white
         netScoreLabel.font = UIFont.systemFont(ofSize: 13)
         netScoreLabel.textAlignment = .left
         netScoreLabel.frame = CGRect(x: nameLabel.frame.maxX + labelToBarSpacing, y: 0, width: 50, height: labelHeight)
         self.addSubview(netScoreLabel)
         
         // Harmony bar setup
         harmonyBarView.backgroundColor = .systemBlue
         self.addSubview(harmonyBarView)
         
         // Discord bar setup
         discordBarView.backgroundColor = .systemRed
         self.addSubview(discordBarView)
         
         updateBarLayout()
     }
     
     private func updateBarLayout() {
         let barStartX = nameLabel.frame.maxX + labelToBarSpacing // Start position for the bars
         
         // Width of harmony and discord bars can be adjusted as needed
         let harmonyWidth = CGFloat(harmonyScore) * 2
         let discordWidth = CGFloat(abs(discordScore)) * 2
         
         // Harmony bar layout
         harmonyBarView.frame = CGRect(
             x: barStartX,
             y: nameLabel.frame.maxY + barSpacing,
             width: harmonyWidth,
             height: barHeight
         )
         
         // Discord bar layout, placed directly below the harmony bar
         discordBarView.frame = CGRect(
             x: barStartX,
             y: harmonyBarView.frame.maxY + barSpacing,
             width: discordWidth,
             height: barHeight
         )
         
         // Adjust net score label to be at the end of the longest bar
         let longestBarWidth = max(harmonyWidth, discordWidth)
         netScoreLabel.frame = CGRect(
             x: barStartX + longestBarWidth + labelToBarSpacing,
             y: 0,
             width: 50,
             height: labelHeight
         )
     }
 }
