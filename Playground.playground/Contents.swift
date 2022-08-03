import Foundation

/*
func createEvents() {
  for i in 1...10 {
    events.append(
      Event(
        id: "\(i)",
        city: "city\(i)",
        artiste: "artiste\(i)",
        price: Double(i)
      )
    )
  }
}

createEvents()

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

do {
  let data = try encoder.encode(events)
  print(String(data: data, encoding: .utf8)!)
} catch let error {
  print(error.localizedDescription)
}
*/





struct EventCategory: Codable, Identifiable {
  let id: Int
  let name: String
  var events: [Event]
  let children: [EventCategory]
}

struct Event: Codable {
  let id: String
  let city: String
  let artiste: String
  let price: Double
}

extension EventCategory {
  static let awards = Self(
    id: 1207,
    name: "Entertainment Awards",
    events: [.grammies, .eddies],
    children: []
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


