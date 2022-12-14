//
//  EventListViewModel.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 03/08/2022.
//

import Combine

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
  
  private var allEvents: [Event] = []
  @Published var filteredEvents: [Event] = []
  
  let fileClient: FileClient
  
  init(fileClient: FileClient) {
    self.fileClient = fileClient
    
    self.loadData()
  }
  
  func loadData() {
    let result = self.fileClient.loadData("events")
    switch result {
    case let .success(category):
      self.allEvents = self.loadEvents(concert: category)
      self.filteredEvents = self.allEvents
    case let .failure(error):
      self.alert = .init(title: "Oops!", message: error.localizedDescription)
    }
  }
  
  private func loadEvents(concert: EventCategory) -> [Event] {
    print("--event---")
    let events = concert.events
    let others = concert.children.flatMap {
      loadEvents(concert: $0)
    }
    return events + others
  }
  
  func searchEvents() {
//    if self.cityQuery.isEmpty && self.priceQuery.isEmpty {
//      self.filteredConcerts = self.allConcerts
//      return
//    }
//
//    var filteredConcerts = [EventCategory]()
//    self.allConcerts.forEach { category in
//      var filteredCategory = EventCategory(id: category.id, name: category.name, events: [], children: [])
//      category.children.forEach { child in
//        if let filteredChildCategory = filterCategory(from: child, cityQuery: self.cityQuery, priceQuery: self.priceQuery) {
//          filteredCategory.children.append(filteredChildCategory)
//        }
//      }
//
//      if !filteredCategory.children.isEmpty {
//        filteredConcerts.append(filteredCategory)
//      }
//    }
//
//    self.filteredConcerts = filteredConcerts
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
  
  func resetFilters() {
    self.cityQuery = ""
    self.priceQuery = ""
    self.filteredEvents = self.allEvents
  }
}
