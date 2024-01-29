//
//  EventVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/25/24.
//

import Foundation
import UIKit
import CoreData
import SwiftEphemeris
class EventDetailsViewController: UIViewController, UITextFieldDelegate {

    var event: NSManagedObject! // The event object passed from the previous view controller
    var selectedDate: Date?
    var chartCake: ChartCake?
    var photoPaths: [String]!
    let eventNameTextField = UITextField()
    let eventDateLabel = UILabel()
    let journalTextView = UITextView()
    let imagesStackView = UIStackView()
    var notes: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EventDetailsViewController loaded. Event: \(String(describing: event))")
        setupUI()
        displayEventDetails()
        for path in photoPaths {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.borderColor = UIColor.red.cgColor
            imageView.layer.borderWidth = 1
            imageView.backgroundColor = UIColor.lightGray // Temporary background color

            if let image = loadImageFromPath(path) {
                imageView.image = image
            }

            imagesStackView.addArrangedSubview(imageView)
        }
    }

        // Add this code inside your EventDetailsViewController
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            saveNotes() // Save notes when the view is about to disappear
        }


            // Implement viewWillAppear to load and display the notes
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                loadNotes()
            }

        func setupUI() {
            // Setup eventNameTextField
            eventNameTextField.delegate = self
            eventNameTextField.borderStyle = .roundedRect
            if let event = event {
                eventNameTextField.text = event.value(forKey: "eventType") as? String ?? "Event"
                eventDateLabel.text = formatDate(event.value(forKey: "eventDate") as? Date ?? Date())
                displayEventDetails()
            } else {
                print("EventDetailsViewController: Event is nil")
                // Handle nil event appropriately
            }
            view.addSubview(eventNameTextField)

            // Setup eventDateLabel
            if let event = event {
                eventNameTextField.text = event.value(forKey: "eventType") as? String ?? "Event"
                eventDateLabel.text = formatDate(event.value(forKey: "eventDate") as? Date ?? Date())
                displayEventDetails()
            } else {
                print("EventDetailsViewController: Event is nil")
                // Handle nil event appropriately
            }
            view.addSubview(eventDateLabel)

            if let event = event {
                journalTextView.text = event.value(forKey: "notes") as? String ?? "notes"
                displayEventDetails()
                journalTextView.textColor = .black
                journalTextView.backgroundColor = UIColor.white
            } else {
                print("EventDetailsViewController: Event is nil")
                // Handle nil event appropriately
            }
            // Set the background color to white
            // Configure other properties of journalTextView as needed
            view.addSubview(journalTextView)



            // Setup imagesStackView
            imagesStackView.axis = .horizontal
            imagesStackView.distribution = .fillEqually
            view.addSubview(imagesStackView)

            eventNameTextField.translatesAutoresizingMaskIntoConstraints = false
            eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
            journalTextView.translatesAutoresizingMaskIntoConstraints = false
            imagesStackView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                // Event Name TextField Constraints
                eventNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                eventNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                eventNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                // Event Date Label Constraints
                eventDateLabel.topAnchor.constraint(equalTo: eventNameTextField.bottomAnchor, constant: 20),
                eventDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                eventDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                // Journal TextView Constraints
                journalTextView.topAnchor.constraint(equalTo: eventDateLabel.bottomAnchor, constant: 20),
                journalTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                journalTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                journalTextView.heightAnchor.constraint(equalToConstant: 200), // Adjust as needed

                // Images StackView Constraints
                imagesStackView.topAnchor.constraint(equalTo: journalTextView.bottomAnchor, constant: 20),
                imagesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                imagesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                imagesStackView.heightAnchor.constraint(equalToConstant: 100) // Adjust as needed
            ])
        }

        func displayEventDetails() {
            guard let event = event else {
                print("Event is nil in displayEventDetails")
                print("Photo paths: \(photoPaths)")

                // Handle nil event appropriately here, maybe with an error message to the user
                return
            }

            if let photoPathsString = event.value(forKey: "photoPaths") as? String, !photoPathsString.isEmpty {
                let photoPaths = photoPathsString.components(separatedBy: ",")
                for path in photoPaths {
                    if let image = loadImageFromPath(path.trimmingCharacters(in: .whitespacesAndNewlines)) {
                        let imageView = UIImageView(image: image)
                        imageView.contentMode = .scaleAspectFill
                        imageView.clipsToBounds = true
                        imagesStackView.addArrangedSubview(imageView)
                    } else {
                        print("Could not load image at path: \(path)")
                        // Handle the case where the image could not be loaded
                    }
                }
            } else {
                print("No photo paths available or photoPaths is not a String")
                // Handle the case where there are no photos or the data is invalid
            }
        }


        func loadImageFromPath(_ path: String) -> UIImage? {
            let fileURL = URL(fileURLWithPath: path)
            let image = UIImage(contentsOfFile: fileURL.path)
            if image == nil {
                print("Failed to load image at path: \(path)")
            }
            return image
        }

        func saveNotes() {
            guard let event = event else {
                return
            }

            // Update the notes attribute of the NSManagedObject
            event.setValue(journalTextView.text, forKey: "notes")

            // Save the CoreData context to persist the changes
            do {
                try event.managedObjectContext?.save()
            } catch {
                print("Error saving notes: \(error)")
            }
        }



        // Create a function to load and display the notes
        func loadNotes() {
            guard let event = event else {
                return
            }

            // Retrieve the notes from the NSManagedObject
            if let loadedNotes = event.value(forKey: "notes") as? String {
                notes = loadedNotes
                journalTextView.text = notes
            }
        }



        func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: date)
        }

        // Implement UITextFieldDelegate methods if needed
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // Dismiss the keyboard
            return true
        }

    }

