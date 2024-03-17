//
//  GalleryScreenModel.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

@MainActor
final class GalleryScreenModel: LoadableObject {
  @Published var state: LoadingState<[URL]> = .idle

  init() {
    load()
  }

  func load() {
    Task {
      @Inject var imagesProvider: ImagesDependency
      self.state = .loaded(try! await imagesProvider.fetchImageURLs())
    }
  }
}
