//
//  VocationTVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/6/23.
//

import Foundation
import UIKit
import SwiftEphemeris

class VocationalTableViewController: UITableViewController {
    var chartCake: ChartCake!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Single section
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // Three rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

        // Configure the cell content based on the row
        if indexPath.row == 0 {
            cell.textLabel?.text = "Temperament Indicators"
            // Customize cell for Temperament
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Harmonious Houses"
            // Customize cell for Vocational Houses
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Vocational Houses"
            // Customize cell for Timing

        } else if indexPath.row == 3 {
            cell.textLabel?.text = "Vocational Timing"
            // Customize cell for Timing
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            // Instantiate and present VocationalAstrologyViewController
            let vocationalAstrologyVC = VocationalAstrologyViewController()
            vocationalAstrologyVC.chartCake = self.chartCake // Pass the chartCake if needed
            vocationalAstrologyVC.title = "Temperament Indicators"
            self.navigationController?.pushViewController(vocationalAstrologyVC, animated: true)

        } else if indexPath.row == 1 {
            let harmonyHousesVC = HarmonyHousesViewController()
            harmonyHousesVC.chartCake = self.chartCake // Pass the chartCake if needed
            harmonyHousesVC.title = "Happy Houses"
            self.navigationController?.pushViewController(harmonyHousesVC, animated: true)
        } else if indexPath.row == 2 {
            let vocationalHousesVC = VocationalHousesViewController()
            vocationalHousesVC.chartCake = self.chartCake // Pass the chartCake if needed
            vocationalHousesVC.title = "Vocational Houses"
            self.navigationController?.pushViewController(vocationalHousesVC, animated: true)

        } else if indexPath.row == 3 {
            let vocationalAstrologyVC = VocationalAstrologyViewController()
            vocationalAstrologyVC.chartCake = self.chartCake // Pass the chartCake if needed
            vocationalAstrologyVC.title = "Vocational Timing"
            self.navigationController?.pushViewController(vocationalAstrologyVC, animated: true)
        }
    }
}
