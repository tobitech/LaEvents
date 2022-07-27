//
//  EventRow.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import SwiftUI

struct EventRow: View {
  @State var event: Event
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(event.artiste)
          .font(.title)
        
        Text("City : \(event.city)")
        Text("Price: \(format(event.price))")
      }
      
      Spacer()
    }
    .padding()
  }
}

struct EventRow_Preview: PreviewProvider {
  static var previews: some View {
    EventRow(event: .superbowl)
      .previewLayout(.fixed(width: 360, height: 100))
  }
}

private func format(_ price: Double) -> String {
  let formatter = NumberFormatter()
  formatter.minimumFractionDigits = 2
  formatter.currencyCode = Locale.current.currencyCode
  return formatter.string(from: price as NSNumber) ?? "\(price)"
}
