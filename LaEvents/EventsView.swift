//
//  EventsView.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import Combine
import SwiftUI

struct EventAlert: Identifiable {
  var id: String {
    return title
  }
  
  let title: String
  let message: String
}

class EventsViewModel: ObservableObject {
  @Published var alert: EventAlert?
  @Published var query: String = ""
  
  private var loadDataCancellable: AnyCancellable?
  
  private var concerts: [EventCategory] = []
  var filteredCategories: [EventCategory] {
    return self.concerts
//    guard !query.isEmpty else {
//      return self.concerts
//    }
//
//    var filtered = [EventCategory]()
//    for item in self.concerts {
//      var category = item
//      let events = category.events.filter { $0.city.lowercased().contains(query.lowercased()) }
//      category.events = events
//      if !category.events.isEmpty {
//        filtered.append(category)
//      }
//    }
//
//    return filtered
  }
  
  let fileClient: FileClient
  
  init(fileClient: FileClient) {
    self.fileClient = fileClient
    
    self.loadEvents()
  }
  
  func loadEvents() {
    let result = self.fileClient.loadData("events")
    switch result {
    case let .success(category):
      self.concerts = category.children
    case let .failure(error):
      self.alert = .init(title: "Oops!", message: error.localizedDescription)
    }
  }
}

struct EventsView: View {
  
  @ObservedObject var viewModel: EventsViewModel
  
  var body: some View {
    NavigationView {
      List(self.viewModel.filteredCategories) { category in
        Section(header: Text(category.name)) {
          ForEach(category.children) { concert in
            EventRow(concert: concert)
          }
        }
      }
      .listStyle(.grouped)
      .alert(item: self.$viewModel.alert, content: { alert in
        Alert(
          title: Text(alert.title),
          message: Text(alert.message)
        )
      })
      .navigationTitle("Concerts")
      .searchable(text: self.$viewModel.query, prompt: "Search events...")
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
