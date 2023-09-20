//
//  ActionSteps.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/19/23.
//

import Foundation
import UIKit

class ActionStepViewController: UIViewController {

    let intentionLabel = UILabel()
    let actionStepTextField = UITextField()
    let saveActionButton = UIButton()
    let progressTracker = UIProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Monthly Action Steps"

        setupUI()
    }

    func setupUI() {
        // Set up intentionLabel
        intentionLabel.translatesAutoresizingMaskIntoConstraints = false
        intentionLabel.text = "Your Wish/Intention: ..."
        intentionLabel.numberOfLines = 0
        view.addSubview(intentionLabel)

        // Set up actionStepTextField
        actionStepTextField.translatesAutoresizingMaskIntoConstraints = false
        actionStepTextField.placeholder = "Write your action step here..."
        actionStepTextField.borderStyle = .roundedRect
        view.addSubview(actionStepTextField)

        // Set up saveActionButton
        saveActionButton.translatesAutoresizingMaskIntoConstraints = false
        saveActionButton.setTitle("Save Action", for: .normal)
        saveActionButton.backgroundColor = .blue
        saveActionButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        view.addSubview(saveActionButton)

        // Set up progressTracker
        progressTracker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressTracker)

        setupConstraints()
    }

    func setupConstraints() {
        // Use Auto Layout to set up constraints

        NSLayoutConstraint.activate([
            intentionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            intentionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            intentionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),

            actionStepTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionStepTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionStepTextField.topAnchor.constraint(equalTo: intentionLabel.bottomAnchor, constant: 16),

            saveActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveActionButton.topAnchor.constraint(equalTo: actionStepTextField.bottomAnchor, constant: 16),
            saveActionButton.heightAnchor.constraint(equalToConstant: 50),

            progressTracker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressTracker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            progressTracker.topAnchor.constraint(equalTo: saveActionButton.bottomAnchor, constant: 32),
        ])
    }

    @objc func saveAction() {
        // Save action step and update progress if needed
        if let actionText = actionStepTextField.text, !actionText.isEmpty {
            // Save the action (you can add a function for this using UserDefaults or CoreData)
            saveActionStep(actionStep: actionText)

            // Clear the text field after saving
            actionStepTextField.text = ""
        }
    }

    func saveActionStep(actionStep: String) {
        // Here, we're using an array to store multiple action steps
        var savedActions = UserDefaults.standard.array(forKey: "userActions") as? [String] ?? []
        savedActions.append(actionStep)
        UserDefaults.standard.set(savedActions, forKey: "userActions")
    }

    func retrieveActionSteps() -> [String] {
        return UserDefaults.standard.array(forKey: "userActions") as? [String] ?? []
    }

}
