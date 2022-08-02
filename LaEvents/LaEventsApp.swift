//
//  LaEventsApp.swift
//  LaEvents
//
//  Created by Oluwatobi Omotayo on 27/07/2022.
//

import SwiftUI

@main
struct LaEventsApp: App {
  var body: some Scene {
    WindowGroup {
      EventsView(viewModel: EventsViewModel(fileClient: .live))
    }
  }
}
