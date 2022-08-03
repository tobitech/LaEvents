//
//  FileClient.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import Combine
import Foundation

struct Event: Codable, Equatable, Identifiable {
  let id: Int
  let name: String
  let venueName: String
  let city: String
  let price: Double
  let date: String
}

#if DEBUG
extension Event {
  static let superbowl = Event(id: 1, name: "Beyonce", venueName: "o2", city: "Seattle", price: 299.99, date: "Aug 10 2022")
  static let grammies = Event(id: 2, name: "Taylor Swift", venueName: "Amex", city: "San Francisco", price: 1099.99, date: "Jul 10 2020")
  static let eddies = Event(id: 3, name: "Bellie Eilish", venueName: "Amex", city: "Texas", price: 34.99, date: "Jul 23 2020")
  static let worldcup = Event(id: 4, name: "Davido", venueName: "Davido", city: "Dubai", price: 64.99, date: "Aug 2 2022")
}
#endif

enum EventsError: Error {
  case fileNotFound
  case invalidData
  case decodingError
}

struct FileClient {
  var loadData: (String) -> Result<EventCategory, EventsError>
}

extension FileClient {
  static var live: Self {
    return Self(
      loadData: { filename in
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
          return .failure(.fileNotFound)
        }

        guard let data = try? Data(contentsOf: url) else {
          return .failure(.invalidData)
        }

        guard let categories = try? eventsDecoder.decode(EventCategory.self, from: data) else {
          return .failure(.decodingError)
        }

        return .success(categories)
      }
    )
  }
}

#if DEBUG
extension FileClient {
  static let mock = Self(
    loadData: { _ in
      return .success(.init(
        id: 343233,
        name: "Parties",
        events: [],
        children: [.awards])
      )
    }
  )
}
#endif

fileprivate var eventsDecoder: JSONDecoder {
  let decoder = JSONDecoder()
  return decoder
}
