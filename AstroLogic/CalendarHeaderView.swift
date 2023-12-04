//
//  CalendarHeaderView.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/3/23.
//

import Foundation
import SwiftEphemeris
import UIKit


class CustomCalendarHeaderView: UIView {
    let monthLabel = UILabel()
    let sunSignLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        monthLabel.textAlignment = .center
        monthLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(monthLabel)

        sunSignLabel.textAlignment = .center
        sunSignLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(sunSignLabel)

        // Layout constraints or frames
        // For simplicity, using frames here
        monthLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 20)
        sunSignLabel.frame = CGRect(x: 0, y: 20, width: self.bounds.width, height: 20)
    }

    func updateHeader(for month: Date, sunSign: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // "MMMM" for full month name
        monthLabel.text = dateFormatter.string(from: month)

        sunSignLabel.text = "Sun in \(sunSign)"
    }
}
