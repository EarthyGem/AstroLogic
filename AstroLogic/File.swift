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
    var chartCake: ChartCake!
    var selectedPhotos: [UIImage] = []
    var latitude: Double!
    var longitude: Double!
    let photoStackView = UIStackView()
    let eventTypePicker = UIPickerView()
    //   let eventDatePicker = UIDatePicker()
    lazy var eventDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.backgroundColor = .gray
        picker.date = Date() // Set the date to the current date

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
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        eventTypePicker.delegate = self
        eventTypePicker.dataSource = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        view.addSubview(collectionView)

        let eventsListButton = UIBarButtonItem(title: "Saved Events", style: .plain, target: self, action: #selector(eventsListButtonTapped))

        // Add the button to the navigation bar
        navigationItem.rightBarButtonItem = eventsListButton

            // Check if collectionView is not nil before registering the cell
        
    }

    @objc func eventsListButtonTapped() {
        let eventListVC = EventListViewController()
        eventListVC.chartCake = chartCake
        eventListVC.latitude = latitude
        eventListVC.longitude = longitude
        // Initialize your EventListViewController here
        navigationController?.pushViewController(eventListVC, animated: true)
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }

        label.text = predefinedEvents[row].name
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5 // Adjust as needed

        // Additional styling if needed
        // label.font = UIFont.systemFont(ofSize: 16)

        return label
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
        let notes = "\(notesTextView.text!)\n"
        // Handle saving of photos and get their paths
        let photoPaths = savePhotosAndGetPaths(photos: selectedPhotos)

        // Save the event data to Core Data
        saveEventDataToCoreData(eventType: selectedEvent.name, eventDate: eventDate, userId: selectedEvent.houses, natalAspects: natalAspects, progressedAspects: progressedAspects, photoPaths: photoPaths, notes: notes ?? "No Notes")

        // Navigate to the EventListViewController
        let eventListVC = EventListViewController() 
        eventListVC.chartCake = chartCake
        eventListVC.latitude = latitude
        eventListVC.longitude = longitude
        // Initialize your EventListViewController here
        navigationController?.pushViewController(eventListVC, animated: true)
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


    func savePhotosAndGetPaths(photos: [UIImage]) -> String {
        var paths: [String] = []
        for photo in photos {
            if let path = savePhotoToFileSystem(photo: photo) {
                paths.append(path)
            }
        }
        return paths.joined(separator: ",")
    }

    func saveEventDataToCoreData(eventType: String, eventDate: Date, userId: [String], natalAspects: String, progressedAspects: String, photoPaths: String, notes: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserEvent", in: managedContext)!
        let userEvent = NSManagedObject(entity: entity, insertInto: managedContext)
        
        userEvent.setValue(eventType, forKeyPath: "eventType")
        userEvent.setValue(eventDate, forKey: "eventDate")
        userEvent.setValue(natalAspects, forKey: "natalAspects")
        userEvent.setValue(progressedAspects, forKey: "progressedAspects")
        userEvent.setValue(photoPaths, forKey: "photoPaths")
        userEvent.setValue(notes, forKey: "notes")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
