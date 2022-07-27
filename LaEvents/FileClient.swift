//
//  FileClient.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import Foundation

struct Event: Codable, Identifiable {
  let id: String
  let city: String
  let artiste: String
  let price: Double
}

extension Event {
  static let superbowl = Event(id: "1", city: "Seattle", artiste: "Beyonce", price: 299.99)
}


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

extension FileClient {
  static let mock = Self(
    loadData: { _ in
      return try JSONEncoder().encode([Event.superbowl])
    }
  )
}
