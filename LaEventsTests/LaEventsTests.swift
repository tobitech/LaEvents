//
//  LaEventsTests.swift
//  LaEventsTests
//
//  Created by Oluwatobi Omotayo on 29/07/2022.
//

import XCTest
@testable import LaEvents

class LaEventsTests: XCTestCase {
  
  func testExample() {
    let viewModel = EventsViewModel(fileClient: .mock)
    // viewModel.loadEvents()
    
    XCTAssertEqual(viewModel.filteredEvents, [
      .superbowl,
      .eddies,
      .grammies
    ])
  }
  
  func testEventsSearch() {
    let viewModel = EventsViewModel(fileClient: .mock)
    
    viewModel.cityQuery = "san"
    
    XCTAssertEqual(viewModel.filteredEvents, [
      .grammies
    ])
    
    viewModel.cityQuery = ""
    
    XCTAssertEqual(viewModel.filteredEvents, [
      .superbowl,
      .eddies,
      .grammies
    ])
  }
}
