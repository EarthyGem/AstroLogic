//
//  ImagePicker.swift
//  AstroLogic
//
//  Created by Errick Williams on 9/1/23.
//

import Foundation
import Photos
import UIKit

class ImagePickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedDate: Date?
    var photoAssets: [PHAsset] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100) // You can adjust this
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ImagePickerViewController did load")
        // Setup the collectionView
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Fetch and display the photos from the selected date
       // pickImage()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        let asset = photoAssets[indexPath.row]
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { (image, _) in
            cell.photoImageView.image = image
        }
        
        return cell
    }
    
    class func fetchPhotos(from date: Date, completion: @escaping ([PHAsset]) -> Void) {
        // ... rest of your code ...
    

    // In your other view controller
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                let startOfDay = Calendar.current.startOfDay(for: date)
                let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? startOfDay

                let fetchOptions = PHFetchOptions()
                fetchOptions.predicate = NSPredicate(format: "creationDate > %@ AND creationDate < %@", startOfDay as NSDate, endOfDay as NSDate)

                let assetsFetchResult = PHAsset.fetchAssets(with: fetchOptions)
                var fetchedPhotoAssets: [PHAsset] = []
                assetsFetchResult.enumerateObjects { (asset, _, _) in
                    fetchedPhotoAssets.append(asset)
                }

                DispatchQueue.main.async {
                    completion(fetchedPhotoAssets)
                }
            default:
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }

    func pickImage() {
        print("Selected date: \(String(describing: selectedDate))")

        PHPhotoLibrary.requestAuthorization { [weak self] (status) in
            guard let self = self else { return }
            switch status {
            case .authorized:
                if let date = self.selectedDate {
                    ImagePickerViewController.fetchPhotos(from: date) { photoAssets in
                        self.photoAssets = photoAssets
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            if self.photoAssets.isEmpty {
                                // Show a message to the user that there are no photos from the selected date
                                let alert = UIAlertController(title: "No Photos", message: "There are no photos from the selected date.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    // Handle error: selectedDate is not set
                }
            case .denied, .restricted: break
                // Handle denied/restricted status, perhaps by showing an alert to the user.
            case .notDetermined: break
                // Handle the not determined case, if needed.
            default: break
                // Handle any other cases.
            }
        }
    }

}
// Custom UICollectionViewCell to display photos
class PhotoCell: UICollectionViewCell {
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
