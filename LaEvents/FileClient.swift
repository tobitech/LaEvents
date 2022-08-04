//
//  FileClient.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import Combine
import Foundation

enum EventsError: Error {
  case fileNotFound
  case invalidData
  case decodingError
}

extension EventsError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .fileNotFound: return "File not found"
    case .invalidData: return "File not valid"
    case .decodingError: return "Unable to decode data"
    }
  }
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

fileprivate var eventsDecoder: JSONDecoder {
  let decoder = JSONDecoder()
  return decoder
}
