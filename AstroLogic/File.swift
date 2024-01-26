import UIKit
import Photos
import SwiftEphemeris
import CoreData
import BSImagePicker






struct AstrologicalEvent {
    let name: String
    let houses: [String]
}


class EventInputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
var collectionView: UICollectionView!
    
    var selectedPhotos: [UIImage] = []
    
    let photoStackView = UIStackView()
    let eventTypePicker = UIPickerView()
    //   let eventDatePicker = UIDatePicker()
    lazy var eventDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        //     picker.preferredDatePickerStyle = .wheels
        //    picker.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        //       picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        //     picker.timeZone = TimeZone.current // Use birthPlaceTimeZone
        picker.backgroundColor = .gray
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = df.date(from: "1976-03-03 14:51:00") {
            picker.date = date
        }
        
        return picker
    }()
    let notesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5.0
        textView.text = "Notes: "
        return textView
    }()
    
    let attachPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Attach Photo", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(attachPhotoButtonTapped), for: .touchUpInside)
        return button
    }()
    
   

    
    let submitButton = UIButton()
    
    let predefinedEvents = [
        // Existing events
        AstrologicalEvent(name: "Birth of a Child", houses: ["5th", "4th"]),
        AstrologicalEvent(name: "Starting a New Business", houses: ["10th", "2nd"]),
        AstrologicalEvent(name: "Relocating to a New Home", houses: ["4th", "9th"]),
        AstrologicalEvent(name: "Beginning a New Relationship", houses: ["7th", "5th"]),
        AstrologicalEvent(name: "End of a Relationship/Breakup", houses: ["7th", "8th"]),
        AstrologicalEvent(name: "Receiving a Promotion or New Job", houses: ["10th", "6th"]),
        AstrologicalEvent(name: "Experiencing a Financial Windfall", houses: ["2nd", "8th"]),
        AstrologicalEvent(name: "Facing a Financial Crisis", houses: ["8th", "2nd"]),
        AstrologicalEvent(name: "Going on a Significant Trip", houses: ["9th", "3rd"]),
        AstrologicalEvent(name: "Returning to School or Further Education", houses: ["9th", "4th"]),
        AstrologicalEvent(name: "Dealing with a Serious Illness", houses: ["6th", "12th"]),
        AstrologicalEvent(name: "Experiencing a Spiritual Awakening", houses: ["12th", "9th"]),
        AstrologicalEvent(name: "Making a Major Purchase", houses: ["2nd", "4th"]),
        AstrologicalEvent(name: "Loss of a Loved One", houses: ["8th", "4th"]),
        AstrologicalEvent(name: "Experiencing a Legal Issue or Lawsuit", houses: ["9th", "7th"]),
        AstrologicalEvent(name: "Engagement or Decision to Marry", houses: ["7th", "5th"]),
        AstrologicalEvent(name: "Discovering a New Talent or Hobby", houses: ["5th", "3rd"]),
        AstrologicalEvent(name: "Facing a Personal Challenge or Obstacle", houses: ["1st", "8th"]),
        AstrologicalEvent(name: "Achieving a Significant Personal Goal", houses: ["1st", "10th"]),
        AstrologicalEvent(name: "Experiencing a Conflict at Work", houses: ["6th", "10th"]),
        AstrologicalEvent(name: "Making a Significant Friend", houses: ["11th", "7th"]),
        AstrologicalEvent(name: "Losing a Significant Friend", houses: ["11th", "12th"]),
        AstrologicalEvent(name: "Experiencing a Family Conflict", houses: ["4th", "10th"]),
        AstrologicalEvent(name: "Achieving Recognition or Award", houses: ["10th", "5th"]),
        AstrologicalEvent(name: "Undergoing a Major Surgery or Health Procedure", houses: ["6th", "8th"]),
        AstrologicalEvent(name: "Experiencing a Major Lifestyle Change", houses: ["1st", "9th"]),
        AstrologicalEvent(name: "Discovering a New Spiritual or Religious Path", houses: ["9th", "12th"]),
        AstrologicalEvent(name: "Undergoing a Crisis of Faith", houses: ["9th", "12th"]),
        AstrologicalEvent(name: "Meeting a Significant Mentor or Teacher", houses: ["9th", "11th"]),
        AstrologicalEvent(name: "Deciding to Start a Family", houses: ["5th", "7th"]),
        AstrologicalEvent(name: "Retirement from Career", houses: ["10th", "4th"]),
        AstrologicalEvent(name: "Starting a New Creative Project", houses: ["5th", "3rd"]),
        AstrologicalEvent(name: "Learning a New Skill or Craft", houses: ["6th", "3rd"]),
        AstrologicalEvent(name: "Volunteering or Charitable Work", houses: ["11th", "6th"]),
        AstrologicalEvent(name: "Experiencing a Major Theft or Loss", houses: ["8th", "2nd"]),
        AstrologicalEvent(name: "Winning a Competition or Award", houses: ["5th", "10th"]),
        AstrologicalEvent(name: "Dealing with an Unexpected Event", houses: ["11th", "8th"]),
        AstrologicalEvent(name: "Embarking on a Personal Fitness Journey", houses: ["6th", "1st"]),
        AstrologicalEvent(name: "Overcoming an Addiction or Bad Habit", houses: ["12th", "6th"]),
        AstrologicalEvent(name: "Reconnecting with a Long-Lost Family Member", houses: ["4th", "3rd"]),
        AstrologicalEvent(name: "Undergoing a Major Personality Change", houses: ["1st", "12th"]),
        AstrologicalEvent(name: "Achieving a Life Dream or Aspiration", houses: ["11th", "9th"]),
        AstrologicalEvent(name: "Facing a Major Decision or Crossroads", houses: ["7th", "9th"]),
        AstrologicalEvent(name: "Dealing with Identity Theft or Fraud", houses: ["8th", "3rd"]),
        AstrologicalEvent(name: "Having a Life-Changing Experience Abroad", houses: ["9th", "12th"]),
        AstrologicalEvent(name: "Discovering a Significant Ancestral Connection", houses: ["4th", "8th"]),
        AstrologicalEvent(name: "Receiving a Major Critique or Review", houses: ["10th", "3rd"]),
        AstrologicalEvent(name: "Facing a Housing or Living Situation Crisis", houses: ["4th", "12th"]),
        AstrologicalEvent(name: "Making a Significant Lifestyle or Dietary Change", houses: ["6th", "2nd"]),
        AstrologicalEvent(name: "Receiving a Significant Gift or Inheritance", houses: ["8th", "2nd"])
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        eventTypePicker.delegate = self
        eventTypePicker.dataSource = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        view.addSubview(collectionView)

            
            // Check if collectionView is not nil before registering the cell
        
    }
            

    func setupUI() {
        // Configure the event type picker
        eventTypePicker.translatesAutoresizingMaskIntoConstraints = false
        eventTypePicker.backgroundColor = UIColor.lightGray
        view.addSubview(eventTypePicker)
        photoStackView.axis = .horizontal
              photoStackView.distribution = .fillEqually
              photoStackView.alignment = .fill
              photoStackView.spacing = 10
              photoStackView.translatesAutoresizingMaskIntoConstraints = false

              view.addSubview(photoStackView)
        // Configure the event date picker
        eventDatePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventDatePicker)
        view.addSubview(notesTextView)
        // Configure the submit button
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        view.addSubview(attachPhotoButton)
        
        // Add constraints
        UIKit.NSLayoutConstraint.activate([
            // Event Type Picker constraints
            eventTypePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            eventTypePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventTypePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Event Date Picker constraints
            eventDatePicker.topAnchor.constraint(equalTo: eventTypePicker.bottomAnchor, constant: 20),
            eventDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Submit Button constraints
            submitButton.topAnchor.constraint(equalTo: eventDatePicker.bottomAnchor, constant: 20),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            notesTextView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            notesTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notesTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            notesTextView.heightAnchor.constraint(equalToConstant: 100),
            
            attachPhotoButton.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: 20),
            attachPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            attachPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            attachPhotoButton.heightAnchor.constraint(equalToConstant: 50),
    

            
                      photoStackView.topAnchor.constraint(equalTo: attachPhotoButton.bottomAnchor, constant: 20),
                      photoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                      photoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                      photoStackView.heightAnchor.constraint(equalToConstant: 100) // Adjust this as needed// Adjust the height as needed
        ])
    }
    
    
    @objc func attachPhotoButtonTapped() {
        // Dismiss any existing image picker controller before presenting a new one
        if presentedViewController is UIImagePickerController {
            dismiss(animated: true) {
                self.selectPhotos()  // Call selectPhotos after the UIImagePickerController is dismissed
            }
        } else {
            selectPhotos()
        }
    }

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return predefinedEvents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return predefinedEvents[row].name
    }
    
    // ... rest of your code
    @objc func submitButtonTapped() {
        let selectedRow = eventTypePicker.selectedRow(inComponent: 0)
        let selectedEvent = predefinedEvents[selectedRow]
        let eventDate = eventDatePicker.date
        
        // Calculate the natal and progressed aspects based on the selected event and date
        let natalAspects = calculateNatalAspects(for: selectedEvent, date: eventDate)
        let progressedAspects = calculateProgressedAspects(for: selectedEvent, date: eventDate)
        
        // Save the event data to Core Data
        saveEventDataToCoreData(eventType: selectedEvent.name, eventDate: eventDate, userId: selectedEvent.houses, natalAspects: natalAspects, progressedAspects: progressedAspects)
        
        // Navigate to the EventListViewController
        let eventListVC = EventListViewController() // Initialize your EventListViewController here
        navigationController?.pushViewController(eventListVC, animated: true)
    }
    func updatePhotoStackView() {
        // Remove all existing arranged subviews
        photoStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        // Add new image views for each selected photo
        for (index, image) in selectedPhotos.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true // Enable user interaction
            imageView.tag = index // Assign a tag to identify the image view

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)

            photoStackView.addArrangedSubview(imageView)
        }
    }

    func calculateNatalAspects(for event: AstrologicalEvent, date: Date) -> String {
        // Your logic to calculate natal aspects
        return ""
    }
    
    func calculateProgressedAspects(for event: AstrologicalEvent, date: Date) -> String {
        // Your logic to calculate progressed aspects
        return ""
    }
    func saveEventDataToCoreData(eventType: String, eventDate: Date, userId: [String], natalAspects: String, progressedAspects: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserEvent", in: managedContext)!
        let userEvent = NSManagedObject(entity: entity, insertInto: managedContext)
        
        userEvent.setValue(eventType, forKeyPath: "eventType")
        userEvent.setValue(eventDate, forKey: "eventDate")
        //  userEvent.setValue(userId, forKey: "userID")
        userEvent.setValue(natalAspects, forKey: "natalAspects")
        userEvent.setValue(progressedAspects, forKey: "progressedAspects")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    //    func fetchEventsFromCoreData() -> [UserEvent] {
    //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
    //            return []
    //        }
    //
    //        let managedContext = appDelegate.persistentContainer.viewContext
    //        let fetchRequest = NSFetchRequest<UserEvent>(entityName: "UserEvent")
    //
    //        do {
    //            let events = try managedContext.fetch(fetchRequest)
    //            return events.map { event in
    //                // Map or process the event data as needed for export
    //                // Include natalAspects and progressedAspects in the export format
    //            }
    //        } catch let error as NSError {
    //            print("Could not fetch. \(error), \(error.userInfo)")
    //            return []
    //        }
    //    }
    
    // Define a dictionary to store progressed aspects for each planet
    var planetProgressedAspectCache: [Planet: [String]] = [:]
    
    func calculateAndCacheProgressedAspects(for planet: Planet) -> [String] {
        // Check if already cached to prevent recalculation
        if let cachedAspects = planetProgressedAspectCache[planet] {
            print("Progressed aspects for \(planet) are already cached.")
            return cachedAspects
        }
        
        // Fetch and map the aspects to their string representations
        let progressedAspects = chartCake!.progressedSimpleAspectsFiltered(by: planet.celestialObject).map { $0.basicAspectString }
        
        // Store the aspects in the cache
        planetProgressedAspectCache[planet] = progressedAspects
        print("Caching progressed aspects for \(planet): \(progressedAspects)")
        
        return progressedAspects
    }
  
    
    // Add a method to handle photo selection (e.g., when a button is tapped)
    @objc func selectPhotos() {
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 5 // or any other number
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset
            // Do something with it if needed
        }, deselect: { (asset) in
            // User deselected an asset
        }, cancel: { (assets) in
            // User cancelled selection
        }, finish: { (assets) in
            // User selected assets
            self.convertAssetsToImages(assets: assets)
        })
    }
    
    func convertAssetsToImages(assets: [PHAsset]) {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .exact
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.isSynchronous = true
        
        for asset in assets {
            imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: requestOptions) { [self] (image, _) in
                if let image = image {
                    print("Number of images selected: \(selectedPhotos.count)")
                    self.selectedPhotos.append(image)
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
               guard let self = self else { return }
               self.updatePhotoStackView()
           }
       }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        let selectedImage = selectedPhotos[imageView.tag]

        let fullScreenView = UIView(frame: self.view.frame)
        fullScreenView.backgroundColor = .black
        fullScreenView.tag = 999
        fullScreenView.isUserInteractionEnabled = true

        let fullScreenImageView = UIImageView(image: selectedImage)
        fullScreenImageView.frame = fullScreenView.bounds
        fullScreenImageView.contentMode = .scaleAspectFit
        fullScreenImageView.isUserInteractionEnabled = true
        fullScreenView.addSubview(fullScreenImageView)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToDismiss(_:)))
        swipeDown.direction = .up
        fullScreenView.addGestureRecognizer(swipeDown)

        self.view.addSubview(fullScreenView)
    }


    @objc func closeFullScreenView() {
        if let fullScreenView = self.view.viewWithTag(999) {
            fullScreenView.removeFromSuperview()
        }
    }
    @objc func handleSwipeToDismiss(_ gesture: UISwipeGestureRecognizer) {
        if let fullScreenView = self.view.viewWithTag(999) {
            UIView.animate(withDuration: 0.3, animations: {
                fullScreenView.alpha = 0
            }) { _ in
                fullScreenView.removeFromSuperview()
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
        cell.imageView.image = selectedPhotos[indexPath.item]
        return cell
    }


    }

extension EventInputViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100) // Set the size you want
    }
}
