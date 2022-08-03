//
//  EventRow.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import SwiftUI

class ChildConcertViewModel: ObservableObject {
  @Published var concert: EventCategory
  
  init(concert: EventCategory) {
    self.concert = concert
  }
}

struct ChildConcert: View {
  @ObservedObject var viewModel: ChildConcertViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(self.viewModel.concert.name)
        .font(.title)
      ForEach(self.viewModel.concert.events) { event in
        EventRow(event: event)
      }
    }
  }
}

struct ChildConcert_Preview: PreviewProvider {
  static var previews: some View {
    ChildConcert(viewModel: .init(concert: .sports))
      .previewLayout(.fixed(width: 360, height: 100))
  }
}
