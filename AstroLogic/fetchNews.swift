//
//  fetchNews.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/10/23.
//

import Foundation


struct NYTArchiveResponse: Codable {
    let response: NYTDocs
}

struct NYTDocs: Codable {
    let docs: [Article]
}

struct Article: Codable {
    let headline: Headline
    let pub_date: String
    let abstract: String
    // Add other fields as needed
}

struct Headline: Codable {
    let main: String
}


func fetchNYTArchive(forMonth month: Int, year: Int, apiKey: String, completion: @escaping ([Article]?) -> Void) {
    let urlString = "https://api.nytimes.com/svc/archive/v1/\(year)/\(month).json?api-key=\(apiKey)"

    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        completion(nil)
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching data: \(error)")
            completion(nil)
            return
        }

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Invalid response")
            completion(nil)
            return
        }

        guard let jsonData = data else {
            print("No data received")
            completion(nil)
            return
        }

        do {
            let decoder = JSONDecoder()
            let archiveResponse = try decoder.decode(NYTArchiveResponse.self, from: jsonData)
            completion(archiveResponse.response.docs)
        } catch {
            print("Error parsing JSON: \(error)")
            completion(nil)
        }
    }

    task.resume()
}
