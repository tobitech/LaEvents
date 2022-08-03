//
//  EventsCategory.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 29/07/2022.
//

import Foundation

struct EventCategory: Codable, Identifiable {
  let id: Int
  let name: String
  var events: [Event]
  var children: [EventCategory]
}

#if DEBUG
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
#endif
