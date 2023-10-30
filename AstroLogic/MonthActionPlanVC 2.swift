//
//  MonthActionPlanVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import UIKit

class MonthActionPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let intentionLabel = UILabel()
    let actionStepsTableView = UITableView()
    let addActionStepButton = UIButton()
    let yearlyProgressTracker = UIProgressView()

    var actionSteps: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Month of Action"

        actionStepsTableView.delegate = self
        actionStepsTableView.dataSource = self

        setupUI()
    }

    func setupUI() {
        // Set up intentionLabel
        intentionLabel.translatesAutoresizingMaskIntoConstraints = false
        intentionLabel.text = "Your Wish/Intention: ..."
        intentionLabel.numberOfLines = 0
        view.addSubview(intentionLabel)

        // Set up actionStepsTableView
        actionStepsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionStepsTableView)

        // Set up addActionStepButton
        addActionStepButton.translatesAutoresizingMaskIntoConstraints = false
        addActionStepButton.setTitle("Add Action Step", for: .normal)
        addActionStepButton.backgroundColor = .blue
        addActionStepButton.addTarget(self, action: #selector(addActionStep), for: .touchUpInside)
        view.addSubview(addActionStepButton)

        // Set up yearlyProgressTracker
        yearlyProgressTracker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yearlyProgressTracker)

        setupConstraints()
    }

    func setupConstraints() {
        // Use Auto Layout to set up constraints
        NSLayoutConstraint.activate([
            intentionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            intentionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            intentionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),

            actionStepsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionStepsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionStepsTableView.topAnchor.constraint(equalTo: intentionLabel.bottomAnchor, constant: 16),

            addActionStepButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addActionStepButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addActionStepButton.topAnchor.constraint(equalTo: actionStepsTableView.bottomAnchor, constant: 16),
            addActionStepButton.heightAnchor.constraint(equalToConstant: 50),

            yearlyProgressTracker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            yearlyProgressTracker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            yearlyProgressTracker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
        ])
    }

    @objc func addActionStep() {
        // Here you might want to push a new ViewController to collect the action step
        // or present a modal view
    }

    // MARK: - TableView Delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionSteps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionStepCell", for: indexPath)
        cell.textLabel?.text = actionSteps[indexPath.row]
        return cell
    }
}
