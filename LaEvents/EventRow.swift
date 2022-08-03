//
//  EventRow.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 03/08/2022.
//

import SwiftUI

struct EventRow: View {
  @State var event: Event
  
  var body: some View {
    VStack(alignment: .leading) {
      Divider()
      Text("City: \(self.event.city)")
      Text("Venue: \(self.event.venueName)")
      Text("Price: \(format(self.event.price))")
      Text("Date: \(self.event.date)")
    }
  }
}

struct EventRow_Previews: PreviewProvider {
  static var previews: some View {
    EventRow(event: .worldcup)
  }
}

private func format(_ price: Double) -> String {
  let formatter = NumberFormatter()
  formatter.minimumFractionDigits = 2
  formatter.currencyCode = Locale.current.currencyCode
  return formatter.string(from: price as NSNumber) ?? "\(price)"
}
