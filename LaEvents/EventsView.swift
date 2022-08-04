//
//  EventsView.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import Combine
import SwiftUI

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
            
            VStack(alignment: .leading, spacing: 10) {
              Button("Search") {
                self.viewModel.searchEvents()
              }
              Button("Reset", role: .destructive) {
                self.viewModel.resetFilters()
              }
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
