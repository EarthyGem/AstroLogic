//
//  AboutViewController.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 4/8/23.
//

import UIKit

class AboutViewController: UIViewController {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text =
       " Do you ever wonder why you feel like certain areas of your life are particularly fortunate or challenging? Our app can provide insight into these patterns by analyzing your birth chart and identifying your most dominant planet, best planet, and worst planet. With just a few taps, you can have access to valuable information about yourself that can help you make better decisions and navigate life's challenges with greater ease.\n\nOur app is simple and user-friendly. All you need to do is enter your birth time and place, and with the press of a button, you will be taken to a screen displaying the glyph of your most dominant planet, an image of your best planet, and an image of your worst planet. Tapping on each glyph will take you to a tableview with items that provide in-depth information about each planet, so you can better understand their influence on your life.\n\nWith this app, you will have the power to recognize patterns in your life and make more informed choices. You can learn to harness the energy of your best planet to attract good fortune, and avoid situations associated with your worst planet to minimize misfortune. The knowledge provided by this app can help you make sense of your life and take control of your destiny."
       
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isSelectable = false
        textView.textAlignment = .justified
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}
