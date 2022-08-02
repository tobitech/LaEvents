//
//  EventRow.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import SwiftUI

struct EventRow: View {
  @State var concert: EventCategory
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(concert.name)
          .font(.title)
        VStack(alignment: .leading) {
          ForEach(concert.events) { event in
            Divider()
            Text("City: \(event.city)")
            Text("Venue: \(event.venueName)")
            Text("Price: \(format(event.price))")
            Text("Date: \(event.date)")
          }
        }
      }
      
      Spacer()
    }
    .padding()
  }
}

struct EventRow_Preview: PreviewProvider {
  static var previews: some View {
    EventRow(concert: .sports)
      .previewLayout(.fixed(width: 360, height: 100))
  }
}

private func format(_ price: Double) -> String {
  let formatter = NumberFormatter()
  formatter.minimumFractionDigits = 2
  formatter.currencyCode = Locale.current.currencyCode
  return formatter.string(from: price as NSNumber) ?? "\(price)"
}
