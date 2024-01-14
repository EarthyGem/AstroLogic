//
//  HouseKeywordsVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/13/24.
//

import Foundation
import UIKit
import SwiftEphemeris

protocol KeywordSelectionViewControllerDelegate: AnyObject {
    func keywordsSelected(_ keywords: [String])
}

class KeywordSelectionViewController: UIViewController {

    weak var delegate: KeywordSelectionViewControllerDelegate?

       // Change this to 'var' so it can be modified from outside
       var keywords = ["Education", "Philosophy", "Adventure", "Travel", "Faith", "Wisdom"]
       

    var selectedKeywords = Set<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupKeywordCapsules()
        setupDoneButton()
    }

    private func setupKeywordCapsules() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        for keyword in keywords {
            let button = createKeywordButton(with: keyword)
            stackView.addArrangedSubview(button)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func createKeywordButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(keywordButtonTapped(_:)), for: .touchUpInside)
        return button
    }

    @objc private func keywordButtonTapped(_ sender: UIButton) {
        guard let keyword = sender.title(for: .normal) else { return }

        if selectedKeywords.contains(keyword) {
            selectedKeywords.remove(keyword)
            sender.backgroundColor = .lightGray
        } else {
            selectedKeywords.insert(keyword)
            sender.backgroundColor = .darkGray
        }
    }

    private func setupDoneButton() {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneSelectingKeywords), for: .touchUpInside)

        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc private func doneSelectingKeywords() {
        delegate?.keywordsSelected(Array(selectedKeywords))
        dismiss(animated: true)
    }
}
