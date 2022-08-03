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
  @Published var cityQuery = ""
  @Published var priceQuery = ""
  
  private var loadDataCancellable: AnyCancellable?
  
  private var allConcerts: [EventCategory] = []
  @Published var filteredConcerts: [EventCategory] = []
  
  func searchEvents() {
    if self.cityQuery.isEmpty && self.priceQuery.isEmpty {
      self.filteredConcerts = self.allConcerts
      return
    }
    
    var filteredConcerts = [EventCategory]()
    self.allConcerts.forEach { category in
      var filteredCategory = EventCategory(id: category.id, name: category.name, events: [], children: [])
      category.children.forEach { child in
        if let filteredChildCategory = filterCategory(from: child, cityQuery: self.cityQuery, priceQuery: self.priceQuery) {
          filteredCategory.children.append(filteredChildCategory)
        }
      }
      
      if !filteredCategory.children.isEmpty {
        filteredConcerts.append(filteredCategory)
      }
    }
    
    self.filteredConcerts = filteredConcerts
  }
  
  private func filterCategory(from category: EventCategory, cityQuery: String, priceQuery: String) -> EventCategory? {
    var newCategory = category
    
    if !cityQuery.isEmpty, !priceQuery.isEmpty, let priceValue = Double(priceQuery) {
      
      newCategory.events = category.events.filter { event in
        event.city.lowercased().contains(cityQuery.lowercased()) && event.price <= priceValue
      }
    } else if !cityQuery.isEmpty {
      newCategory.events = category.events.filter { event in
        event.city.lowercased().contains(cityQuery.lowercased())
      }
    } else if !priceQuery.isEmpty, let priceValue = Double(priceQuery) {
      newCategory.events = category.events.filter { event in
        event.price <= priceValue
      }
    } else {
      return nil
    }
    
    return newCategory.events.isEmpty ? nil : newCategory
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
      self.allConcerts = category.children
      self.filteredConcerts = self.allConcerts
    case let .failure(error):
      self.alert = .init(title: "Oops!", message: error.localizedDescription)
    }
  }
}

struct EventsView: View {
  @ObservedObject var viewModel: EventsViewModel
  
  var body: some View {
    NavigationView {
      VStack {
        Divider()
        
        VStack(alignment: .leading, spacing: 0) {
          HStack {
            VStack {
              TextField("Enter city name", text: self.$viewModel.cityQuery)
              
              Divider()
              
              TextField("Enter price", text: self.$viewModel.priceQuery)
                .keyboardType(.numberPad)
            }
            Button("Search") {
              self.viewModel.searchEvents()
            }
          }
          .padding(.horizontal)
        }
        
        List(self.viewModel.filteredConcerts) { category in
          Section(header: Text(category.name)) {
            ForEach(category.children) { child in
              ChildConcert(viewModel: .init(concert: child))
            }
          }
        }
      }
      .alert(item: self.$viewModel.alert, content: { alert in
        Alert(
          title: Text(alert.title),
          message: Text(alert.message)
        )
      })
      .navigationBarTitle("Concerts", displayMode: .inline)
    }
  }
}

struct EventsView_Previews: PreviewProvider {
  static var previews: some View {
    EventsView(viewModel: EventsViewModel(fileClient: .mock))
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
