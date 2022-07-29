//
//  FileClient.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import Foundation

struct Event: Codable, Equatable, Identifiable {
  let id: Int
  let city: String
  let artiste: String
  let price: Double
}

#if DEBUG
extension Event {
  static let superbowl = Event(id: 1, city: "Seattle", artiste: "Beyonce", price: 299.99)
  static let grammies = Event(id: 2, city: "San Francisco", artiste: "Taylor Swift", price: 1099.99)
  static let eddies = Event(id: 3, city: "Texas", artiste: "Bellie Eilish", price: 34.99)
  static let worldcup = Event(id: 4, city: "Dubai", artiste: "Davido", price: 64.99)
}
#endif

enum EventsError: Error {
  case invalidFileName
}

struct FileClient {
  var loadData: (String) throws -> Data
}

extension FileClient {
  static var live: Self {
    return Self(
      loadData: { filename in
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
          throw EventsError.invalidFileName
        }
        
        return try Data(contentsOf: url)
      }
    )
  }
}

#if DEBUG
extension FileClient {
  static let mock = Self(
    loadData: { _ in
      return try JSONEncoder().encode([
        EventCategory.awards, .sports
      ])
    }
  )
}
#endif
