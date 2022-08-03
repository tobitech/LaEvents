//
//  Models.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 03/08/2022.
//

import Foundation

import Foundation

struct EventCategory: Codable, Identifiable {
  let id: Int
  let name: String
  var events: [Event]
  var children: [EventCategory]
}

struct Event: Codable, Equatable, Identifiable {
  let id: Int
  let name: String
  let venueName: String
  let city: String
  let price: Double
  let date: String
}
