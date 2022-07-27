import Foundation

struct Event: Codable {
  let id: String
  let city: String
  let artiste: String
  let price: Double
}

var events: [Event] = []

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
