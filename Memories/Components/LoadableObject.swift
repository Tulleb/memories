//
//  LoadableObject.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import Foundation

enum LoadingState<Value: Equatable>: Equatable {
  case idle
  case loading
  case failed(Error)
  case loaded(Value)

  static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle), (.loading, .loading):
      true
    case let (.loaded(lhs), .loaded(rhs)):
      lhs == rhs
    case let (.failed(lhs), .failed(rhs)):
      lhs.localizedDescription == rhs.localizedDescription
    default:
      false
    }
  }
}

@MainActor
protocol LoadableObject: ObservableObject {
  associatedtype Output: Equatable
  var state: LoadingState<Output> { get set }
  func load() async
}
