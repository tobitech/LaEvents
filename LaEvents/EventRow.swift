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
      // Divider()
      Text("City: \(self.event.city)")
      Text("Venue: \(self.event.venueName)")
      Text("Price: \(format(self.event.price))")
      Text("Date: \(self.event.date)")
      
      Rectangle()
        .frame(maxWidth: .infinity, idealHeight: 0, maxHeight: 0)
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
  formatter.locale = Locale.current
  formatter.numberStyle = .currency
  return formatter.string(from: price as NSNumber) ?? "\(price)"
}
