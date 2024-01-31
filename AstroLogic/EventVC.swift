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
import Photos

class EventDetailsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var event: NSManagedObject! // The event object passed from the previous view controller
    var selectedDate: Date?
    var chartCake: ChartCake?
    var photoPaths: [String]!
    let eventNameTextField = UITextField()
    let eventDateLabel = UILabel()
    let journalTextView = UITextView()
    let imagesStackView = UIStackView()
    var notes: String?
    let addPhotosButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EventDetailsViewController loaded. Event: \(String(describing: event))")
        setupUI()
        displayEventDetails()
        setupAddPhotosButton()
      
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
                // Inside setupUI function
            
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
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            presentFullscreenImage(imageView.image)
        }
    }
    func setupAddPhotosButton() {
           addPhotosButton.setTitle("Add Photos", for: .normal)
           addPhotosButton.backgroundColor = .systemBlue
           addPhotosButton.addTarget(self, action: #selector(addPhotosButtonTapped), for: .touchUpInside)
           view.addSubview(addPhotosButton)

           addPhotosButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               addPhotosButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
               addPhotosButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               addPhotosButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               addPhotosButton.heightAnchor.constraint(equalToConstant: 50)
           ])
       }

       @objc func addPhotosButtonTapped() {
           let imagePickerController = UIImagePickerController()
           imagePickerController.delegate = self
           imagePickerController.sourceType = .photoLibrary
           present(imagePickerController, animated: true, completion: nil)
       }

       // UIImagePickerControllerDelegate methods
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
           guard let selectedImage = info[.originalImage] as? UIImage else { return }

           // Handle saving of photo and updating Core Data
           if let path = savePhotoToFileSystem(photo: selectedImage) {
               // Append the new path to your photoPaths array and update Core Data
               photoPaths.append(path)
               savePhotoPathsToCoreData()
               displayEventDetails() // Refresh the display
           }

           dismiss(animated: true, completion: nil)
       }
    func savePhotoPathsToCoreData() {
          guard let event = event else { return }

          let pathsString = photoPaths.joined(separator: ",")
          event.setValue(pathsString, forKey: "photoPaths")

          do {
              try event.managedObjectContext?.save()
          } catch {
              print("Error saving photo paths: \(error)")
          }
      }

    func displayEventDetails() {
        // Clear the imagesStackView before adding new image views
        imagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let event = event else {
            print("Event is nil in displayEventDetails")
            print("Photo paths: \(photoPaths)")
            return
        }
        
        if let photoPathsString = event.value(forKey: "photoPaths") as? String, !photoPathsString.isEmpty {
            let photoPaths = photoPathsString.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            let uniquePhotoPaths = Array(Set(photoPaths)) // Remove duplicates if needed
            for path in uniquePhotoPaths {
                if let image = loadImageFromPath(path) {
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    imageView.isUserInteractionEnabled = true
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                    imageView.addGestureRecognizer(tapGesture)
                    imagesStackView.addArrangedSubview(imageView)
                } else {
                    print("Could not load image at path: \(path)")
                }
            }
        }
    }
       
          func presentFullscreenImage(_ image: UIImage?) {
              let fullscreenViewController = UIViewController()
              fullscreenViewController.view.backgroundColor = UIColor.black
              let fullscreenImageView = UIImageView(image: image)
              fullscreenImageView.contentMode = .scaleAspectFit
              fullscreenImageView.frame = fullscreenViewController.view.frame
              fullscreenViewController.view.addSubview(fullscreenImageView)

              let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
              fullscreenViewController.view.addGestureRecognizer(tapGesture)

              present(fullscreenViewController, animated: true, completion: nil)
          }

          @objc func dismissFullscreenImage() {
              dismiss(animated: true, completion: nil)
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

 

    // Implement the UITextFieldDelegate method
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == eventNameTextField {
            guard let event = event, let newEventName = eventNameTextField.text, !newEventName.isEmpty else {
                return
            }
            
            // Update the event name attribute of the NSManagedObject
            event.setValue(newEventName, forKey: "eventType")
            
            // Save the CoreData context to persist the changes
            do {
                try event.managedObjectContext?.save()
                print("Event name updated to: \(newEventName)")
            } catch {
                print("Error saving event name: \(error)")
            }
        }
    }

    // ... rest of your code


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
    func savePhotoToFileSystem(photo: UIImage) -> String? {
        // Create a unique file name or identifier for the image
        let fileName = UUID().uuidString + ".jpg"

        // Get the document directory URL
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        // Create the full file URL
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        // Convert the UIImage to JPEG data
        guard let data = photo.jpegData(compressionQuality: 1.0) else {
            return nil
        }

        // Write the data to the file URL
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Error saving photo: \(error)")
            return nil
        }
    }

    }

