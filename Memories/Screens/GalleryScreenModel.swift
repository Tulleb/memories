//
//  GalleryScreenModel.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

@MainActor
final class GalleryScreenModel: ObservableObject {
  enum State {
    case loading
    case loaded([URL])
  }

  @Published var state: State = .loading

  init() {
    load()
  }
}

// MARK: - Private

private extension GalleryScreenModel {
  func load() {
    Task {
      @Inject var imagesProvider: ImagesDependency
      self.state = .loaded(try! await imagesProvider.fetchImageURLs())
    }
  }
}
