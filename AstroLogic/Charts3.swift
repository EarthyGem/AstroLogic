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

func parseDetails(from data: String) -> [PersonDetails] {
    let lines = data.split(separator: "\n")

    var results: [PersonDetails] = []

    for i in stride(from: 0, to: lines.count, by: 3) {
        guard let nameLine = lines[safe: i],
              let latLongLine = lines[safe: i + 1] else {
            continue
        }

        // Extracting latitude and longitude
        let latLongParts = latLongLine.split(separator: ",")

        let latitudeString = String(latLongParts[1])
        let longitudeString = String(latLongParts[2])

        let latitude = convertToDecimal(coordinate: latitudeString)
        let longitude = convertToDecimal(coordinate: longitudeString)

        // Fetch time zone of birthplace
        var birthTimeZone: TimeZone?
        if let latitude = latitude, let longitude = longitude {
            let group = DispatchGroup()
            group.enter()
            fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: Int(Date().timeIntervalSince1970)) { timeZone in
                birthTimeZone = timeZone
                group.leave()
            }
            group.wait()
        }

        // Extracting name
        let nameParts = nameLine.split(separator: ",")
        guard nameParts.count > 1 else { continue }

        let lastName = String(nameParts[1])
        let firstName = String(nameParts[0].split(separator: ":")[1])
        let fullName = "\(firstName) \(lastName)"

        // Extracting date
        let dateString = String(nameParts[3]) + " " + String(nameParts[4])
        let date = dateFromString(dateString, timeZone: birthTimeZone)

        // Adjust birth date with time zone
        var adjustedBirthDate: Date?
        if let latitude = latitude, let longitude = longitude, let date = date {
            let group = DispatchGroup()
            group.enter()
            adjustedBirthDateWithTimeZone(latitude: latitude, longitude: longitude, birthDate: date) { adjustedDate in
                adjustedBirthDate = adjustedDate
                group.leave()
            }
            group.wait()
        }

        let personDetails = PersonDetails(name: fullName, latitude: latitude, longitude: longitude, date: adjustedBirthDate)
        results.append(personDetails)
    }

    return results
}


func dateFromString(_ dateString: String, timeZone: TimeZone?) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d.M.yyyy HH:mm"
    dateFormatter.timeZone = timeZone // Set time zone to birthplace time zone
    return dateFormatter.date(from: dateString)
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


func dateFromString(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d.M.yyyy HH:mm"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set time zone to GMT
    return dateFormatter.date(from: dateString)
}


// Add this instance variable if it doesn't exist
// Removed the global variable and passed timeZone directly through the completion handler.
func fetchTimeZone(latitude: Double, longitude: Double, timestamp: Int, completion: @escaping (TimeZone?) -> Void) {
    let API_KEY = "AIzaSyA5sA9Mz9AOMdRoHy4ex035V3xsJxSJU_8"
    let url = URL(string: "https://maps.googleapis.com/maps/api/timezone/json?location=\(latitude),\(longitude)&timestamp=\(timestamp)&key=\(API_KEY)")!

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error fetching timezone: \(error.localizedDescription)")
            completion(nil)
            return
        }

        guard let data = data else {
            print("No data returned from API")
            completion(nil)
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let timeZoneId = json["timeZoneId"] as? String {
                    let timeZone = TimeZone(identifier: timeZoneId)

                    // Print the date and time at the location of birth
                    if let timeZone = timeZone {
                        let localDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
                        let formatter = DateFormatter()
                        formatter.timeZone = timeZone
                        formatter.dateStyle = .medium
                        formatter.timeStyle = .medium
                        let localDateString = formatter.string(from: localDate)

                    }

                    completion(timeZone)
                } else if let errorMessage = json["errorMessage"] as? String {
                    print("API error: \(errorMessage)")
                    completion(nil)
                } else {
                    print("Unexpected JSON structure: \(json)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            completion(nil)
        }
    }
    task.resume()  // Don't forget to start the task.
}



func adjustedBirthDateWithTimeZone(latitude: Double, longitude: Double, birthDate: Date, completion: @escaping (Date?) -> Void) {
    fetchTimeZone(latitude: latitude, longitude: longitude, timestamp: Int(birthDate.timeIntervalSince1970)) { timeZone in
        if let timeZone = timeZone {
            // Adjust birthDate using the retrieved time zone
            var calendar = Calendar.current
            calendar.timeZone = timeZone
            let adjustedBirthDate = calendar.date(bySettingHour: calendar.component(.hour, from: birthDate),
                                                  minute: calendar.component(.minute, from: birthDate),
                                                  second: calendar.component(.second, from: birthDate),
                                                  of: birthDate)

            // Print the date and time at the location of birth
            if let adjustedBirthDate = adjustedBirthDate {
                let formatter = DateFormatter()
                formatter.timeZone = timeZone
                formatter.dateStyle = .medium
                formatter.timeStyle = .medium
                let localDateString = formatter.string(from: adjustedBirthDate)

            }

            completion(adjustedBirthDate)
        } else {

            completion(nil)
        }
    }
}


func saveChart(name: String, latitude: Double, longitude: Double, birthDate: Date) {
    adjustedBirthDateWithTimeZone(latitude: latitude, longitude: longitude, birthDate: birthDate) { adjustedBirthDate in
        if let adjustedBirthDate = adjustedBirthDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            let adjustedBirthDateString = formatter.string(from: adjustedBirthDate)

        } else {

        }
    }
}


// Then, initiate the parsing:
