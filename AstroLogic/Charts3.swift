import Foundation
import UIKit
import CoreData




struct PersonDetails: CustomStringConvertible {
    var name: String?
    var latitude: Double?
    var longitude: Double?
    var date: Date?

    var description: String {
        return """
        Name: \(String(describing: name))
        Latitude: \(latitude ?? 0.0)
        Longitude: \(longitude ?? 0.0)
        Date: \(String(describing: date))
        """
    }
}



func convertToDecimal(coordinate: String) -> Double? {
    let pattern = "([0-9]+)([nsew]?)"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []),
        let match = regex.firstMatch(in: coordinate, options: [], range: NSRange(location: 0, length: coordinate.utf16.count)) else {
            return nil
    }

    let degreeRange = match.range(at: 1)
    let directionRange = match.range(at: 2)

    let degreeString = (coordinate as NSString).substring(with: degreeRange)
    let directionString = (coordinate as NSString).substring(with: directionRange)

    guard let degrees = Double(degreeString) else { return nil }

    let directionMultiplier: Double
    switch directionString {
    case "s", "w":
        directionMultiplier = -1.0
    case "n", "e":
        directionMultiplier = 1.0
    default:
        return nil
    }

    let minutePart = coordinate.replacingOccurrences(of: degreeString + directionString, with: "")

    guard let minutes = Double(minutePart) else { return degrees * directionMultiplier }

    return (degrees + (minutes / 60.0)) * directionMultiplier
}


// Safely retrieve an array element
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
func dateFromString(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d.M.yyyy HH:mm"
    return dateFormatter.date(from: dateString)
}


func parseDetails(from data: String) -> [PersonDetails] {
    let lines = data.split(separator: "\n")

    var results: [PersonDetails] = []

    for i in stride(from: 0, to: lines.count, by: 3) {
        guard let nameLine = lines[safe: i],
              let latLongLine = lines[safe: i + 1] else {
            continue
        }

        // Extracting name
        let nameParts = nameLine.split(separator: ",")
        guard nameParts.count > 1 else { continue }

        let lastName = String(nameParts[1])
        let firstName = String(nameParts[0].split(separator: ":")[1])
        let fullName = "\(firstName) \(lastName)"

        // Extracting latitude and longitude
        let latLongParts = latLongLine.split(separator: ",")

        let latitudeString = String(latLongParts[1])
        let longitudeString = String(latLongParts[2])

        let latitude = convertToDecimal(coordinate: latitudeString)
        let longitude = convertToDecimal(coordinate: longitudeString)

        // Extracting date
        let dateString = String(nameParts[3]) + " " + String(nameParts[4])
        let date = dateFromString(dateString)

        let personDetails = PersonDetails(name: fullName, latitude: latitude, longitude: longitude, date: date)
        results.append(personDetails)
    }

    return results
}

let dataString = """
#A93:Miron,Errick,m,21.5.1977,13:57,San Diego,CA (US)
#B93:2443285.37292,32n43,117w09,8hw00,1
#: Astrodienst data: nhor=1 sbli=Miron,Errick,m,21,5,1977,13:57,h7w,gad,0

#A93:Rodgers [Adb],Aaron,m,2.12.1983,14:50,Chico,CA (US)
#B93:2445671.45139,39n44,121w50,8hw00,0
#: Astrodienst data: nhor=313 sbli=Rodgers [Adb],Aaron,m,2,12,1983,14:50,h8w,gas,0

#A93:*,Abbey,f,9.3.1991,15:44,Dayton,OH (US)
#B93:2448325.36389,39n46,84w12,5hw00,0
#: Astrodienst data: nhor=296 sbli=,Abbey,f,9,3,1991,15:44,h5w,gas,0

#A93:*,Abe,m,17.1.2005,8:06,Los Angeles,CA (US)
#B93:2453388.17083,34n03,118w15,8hw00,0
#: Astrodienst data: nhor=323 sbli=,Abe,m,17,1,2005,8:06,h8w,gas,0

#A93:Lincoln [Adb],Abraham,m,12.2.1809,6:54,Hodgenville,KY (US)
#B93:2381826.02565,37n34,85w44,5hw42:56,L
#: Astrodienst data: nhor=151 sbli=Lincoln [Adb],Abraham,m,12,2,1809,6:54,m85w44,gal,0

#A93:Carolla [Adb],Adam,m,27.5.1964,19:45,Los Angeles,CA (US)
#B93:2438543.61458,34n03,118w15,8hw00,1
#: Astrodienst data: nhor=280 sbli=Carolla [Adb],Adam,m,27,5,1964,19:45,h7w,gad,0

#A93:*,Aj,m,7.3.1984,23:07,Boston,MA (US)
#B93:2445767.67153,42n22,71w04,5hw00,0
#: Astrodienst data: nhor=24 sbli=,Aj,m,7,3,1984,23:07,h5w,gas,0

"""


// Add this instance variable if it doesn't exist
// Removed the global variable and passed timeZone directly through the completion handler.
func fetchTimeZone(latitude: Double, longitude: Double, timestamp: Int, completion: @escaping (TimeZone?) -> Void) {
    let API_KEY = "YOUR_API_KEY"
    let url = URL(string: "https://maps.googleapis.com/maps/api/timezone/json?location=\(latitude),\(longitude)&timestamp=\(timestamp)&key=\(API_KEY)")!

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            completion(nil)
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let timeZoneId = json["timeZoneId"] as? String {
                completion(TimeZone(identifier: timeZoneId))
            } else {
                completion(nil)
            }
        } catch {
            completion(nil)
        }
    }
    task.resume()
}


func processDetails() {
    let detailsArray = parseDetails(from: dataString)
    for details in detailsArray {
        print(details)

        if let name = details.name,
           let birthDate = details.date,
           let latitude = details.latitude,
           let longitude = details.longitude {

            // Convert the birthDate to a timestamp (seconds since 1970)
            let timestamp = Int(birthDate.timeIntervalSince1970)

            fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: timestamp) { timeZone in
                guard let timeZone = timeZone else {
                    print("Unable to fetch timezone for \(name)")
                    return
                }

                // Adjust the birthDate to the fetched timezone
                var adjustedBirthDate = birthDate
                if let birthPlaceTimeZone = birthPlaceTimeZone {
                    let interval = birthPlaceTimeZone.secondsFromGMT(for: birthDate) - TimeZone.current.secondsFromGMT(for: birthDate)
                    adjustedBirthDate = birthDate.addingTimeInterval(TimeInterval(interval))
                }

                saveChart(name: name, birthDate: adjustedBirthDate, latitude: latitude, longitude: longitude)
            }
        }
    }
}

func saveChart(name: String, birthDate: Date, latitude: Double, longitude: Double) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        print("Unable to get AppDelegate")
        return
    }

    let context = appDelegate.persistentContainer.viewContext
    // Check whether "ChartEntity" is the correct entity name in your .xcdatamodeld file.
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "ChartEntity", in: context) else {
        print("Failed to get the entity description for 'ChartEntity'")
        return
    }

    let newChart = NSManagedObject(entity: entityDescription, insertInto: context)
    newChart.setValue(name, forKey: "name")
    newChart.setValue(birthDate, forKey: "birthDate")
    newChart.setValue(latitude, forKey: "latitude")
    newChart.setValue(longitude, forKey: "longitude")

    // Try saving the context
    do {
        try context.save()
    } catch {
        print("Failed to save chart: \(error.localizedDescription)")
    }
}

// Then, initiate the parsing:



