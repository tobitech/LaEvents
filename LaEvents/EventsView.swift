//
//  EventsView.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import SwiftUI

struct Alert {
  let title: String
  let message: String
}

class EventsViewModel: ObservableObject {
  @Published var alert: Alert?
  @Published var events: [Event] = []
  
  let fileClient: FileClient
  
  init(fileClient: FileClient) {
    self.fileClient = fileClient
    
    self.loadEvents()
  }
  
  func loadEvents() {
    do {
      let data = try fileClient.loadData("events")
      let decoder = JSONDecoder()
      self.events = try decoder.decode([Event].self, from: data)
    } catch let error {
      self.alert = Alert(title: "Oops!", message: error.localizedDescription)
    }
  }
  
}

struct EventsView: View {
  
  let viewModel: EventsViewModel
  
  var body: some View {
    NavigationView {
      List(self.viewModel.events) { event in
        EventRow(event: event)
          .listRowInsets(.zero)
      }
      .navigationTitle("Events")
    }
  }
}

struct EventsView_Previews: PreviewProvider {
  static var previews: some View {
    EventsView(viewModel: EventsViewModel(fileClient: .live))
  }
}

extension EdgeInsets {
  static let zero = Self(
    top: 0,
    leading: 0,
    bottom: 0,
    trailing: 0
  )
}
