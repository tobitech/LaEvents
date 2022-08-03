//
//  Mocks.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 03/08/2022.
//

import Foundation

extension EventCategory {
  static let awards = Self(
    id: 1207,
    name: "Entertainment Awards",
    events: [],
    children: [
      .init(
        id: 2343,
        name: "Academy",
        events: [.grammies, .eddies],
        children: []
      ),
      .sports
    ]
  )
  static let sports = Self(
    id: 783,
    name: "Sporting Events",
    events: [.superbowl, .worldcup],
    children: []
  )
}

extension Event {
  static let superbowl = Event(id: 1, name: "Beyonce", venueName: "o2", city: "Seattle", price: 299.99, date: "Aug 10 2022")
  static let grammies = Event(id: 2, name: "Taylor Swift", venueName: "Amex", city: "San Francisco", price: 1099.99, date: "Jul 10 2020")
  static let eddies = Event(id: 3, name: "Bellie Eilish", venueName: "Amex", city: "Texas", price: 34.99, date: "Jul 23 2020")
  static let worldcup = Event(id: 4, name: "Davido", venueName: "Davido", city: "Dubai", price: 64.99, date: "Aug 2 2022")
}


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
