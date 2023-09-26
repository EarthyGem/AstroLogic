//
//  EditChartVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/25/23.
//

import Foundation

import UIKit
import CoreData

import UIKit
import GooglePlaces

class EditChartViewController: UIViewController, GMSAutocompleteViewControllerDelegate {

    var chartToEdit: ChartEntity?

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        return textField
    }()

    let birthPlaceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Birth Place"
        return textField
    }()


    let dateTimeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Birth Time"
        return textField
    }()



    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        return button
    }()
    let dateTimePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        return picker
    }()


    @objc func dateTimePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
//        dateTimeTextField.text = formatter.string(from: dateTimePicker.date)
        dateTimeTextField.resignFirstResponder()
        self.view.endEditing(true)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        dateTimeTextField.inputView = dateTimePicker

        // Layout
        setupViews()

        // Populate the fields if editing
        if let chart = chartToEdit {
            nameTextField.text = chart.name
            birthPlaceTextField.text = chart.birthPlace

            fetchTimeZone(latitude: chart.latitude, longitude: chart.longitude, timestamp: Int(chart.birthDate!.timeIntervalSince1970)) { [weak self] timeZone in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    if let tz = timeZone {
                        let formattedDate = strongSelf.formattedDateString(from: chart.birthDate!, with: tz)
                        strongSelf.dateTimeTextField.text = formattedDate
                    } else {
                        // Handle the case where you don't have a timeZone, maybe use a default formatter or show an error.
                    }
                }
            }
        }

        birthPlaceTextField.addTarget(self, action: #selector(birthPlaceTextFieldEditingDidBegin), for: .editingDidBegin)

        let dateTimePicker = UIDatePicker()
        dateTimePicker.datePickerMode = .dateAndTime
        dateTimePicker.addTarget(self, action: #selector(dateTimePickerValueChanged(_:)), for: .valueChanged)
        dateTimePicker.date = (chartToEdit?.birthDate)!
        dateTimePicker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)


        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dateTimePickerDonePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneBtn], animated: true)
        toolBar.barTintColor = .lightGray
        doneBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .normal)

        dateTimeTextField.inputView = dateTimePicker
        dateTimeTextField.inputAccessoryView = toolBar
    }
//    @objc func dateTimePickerValueChanged(_ sender: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .short
//        dateTimeTextField.text = dateFormatter.string(from: sender.date)
//    }

    func formattedDateString(from date: Date, with timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: date)
    }
    @objc func dateTimePickerValueChanged(_ sender: UIDatePicker) {
        fetchTimeZone(latitude: chartToEdit?.latitude ?? 0, longitude: chartToEdit?.longitude ?? 0, timestamp: Int(sender.date.timeIntervalSince1970)) { [weak self] timeZone in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                if let tz = timeZone {
                    let formattedDate = strongSelf.formattedDateString(from: sender.date, with: tz)
                    strongSelf.dateTimeTextField.text = formattedDate
                } else {
                    // Handle the case where you don't have a timeZone, maybe use a default formatter or show an error.
                }
            }
        }
    }



    func setupViews() {
        // Sample layout, adjust as needed
        view.addSubview(nameTextField)
        view.addSubview(birthPlaceTextField)

        view.addSubview(dateTimeTextField)
        view.addSubview(saveButton)

        // Adjust frames or use AutoLayout to position elements on screen
        // This is a sample using frames:
        nameTextField.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 40)
        birthPlaceTextField.frame = CGRect(x: 20, y: 150, width: view.frame.width - 40, height: 40)
        dateTimeTextField.frame = CGRect(x: 20, y: 200, width: view.frame.width - 40, height: 40)

        saveButton.frame = CGRect(x: 20, y: 300, width: view.frame.width - 40, height: 40)
    }

    @objc func saveChanges() {
        guard let chart = chartToEdit else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        // Update the name and birthplace from their respective text fields
        chart.name = nameTextField.text
        chart.birthPlace = birthPlaceTextField.text

        // Assuming the latitude and longitude are correctly set for the chart you're editing.
        fetchTimeZone(latitude: chart.latitude, longitude: chart.longitude, timestamp: Int(Date().timeIntervalSince1970)) { [weak self] timeZone in
            DispatchQueue.main.async {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .short
                dateFormatter.timeZone = timeZone  // Use the fetched timezone

                if let newDate = dateFormatter.date(from: self?.dateTimeTextField.text ?? "") {
                    chart.birthDate = newDate
                }

                // Now, try to save the context
                do {
                    try context.save()
                } catch {
                    print("Failed to save edited chart: \(error.localizedDescription)")
                }

                self?.navigationController?.popViewController(animated: true)
            }
        }
    }

    @objc func birthPlaceTextFieldEditingDidBegin() {
        presentAutocompleteViewController()
    }

    func presentAutocompleteViewController() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }

    // MARK: - GMSAutocompleteViewControllerDelegate

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        birthPlaceTextField.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle error
        print("Error: ", error.localizedDescription)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
