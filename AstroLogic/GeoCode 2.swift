//
//  geocode.swift
//  Strongest Planet Generator
//
//  Created by Errick Williams on 3/23/23.
//

import Foundation
import CoreLocation


var birthPlaceTimeZone: TimeZone?

func geocoding(location: String, completion: @escaping (_ latitude: Double, _ longitude: Double) -> Void, failure: @escaping (_ msg: String) -> Void) {
    
    let geocoder = CLGeocoder()

    geocoder.geocodeAddressString(location) { (placemarks, error) in
        if let error = error {
            print("Geocoding error: \(error.localizedDescription)")
            failure(error.localizedDescription)
        }

        guard let placemark = placemarks?.first,
              let location = placemark.location else {
            print("Failed to get location")
            failure("Sorry, we can't get details for that place")
            return
        }

        birthPlaceTimeZone = placemark.timeZone
        completion(location.coordinate.latitude, location.coordinate.longitude)
    }
}

func getTimeZone(location: CLLocationCoordinate2D, completion: @escaping ((TimeZone?) -> Void)) {
    let cllLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
    let geocoder = CLGeocoder()

    geocoder.reverseGeocodeLocation(cllLocation) { placemarks, error in
        if let error = error {
            print(error.localizedDescription)
        } else {
            completion(placemarks?.first?.timeZone)
        }
    }
}
