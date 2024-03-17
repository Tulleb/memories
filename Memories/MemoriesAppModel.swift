//
//  MemoriesAppModel.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

final class MemoriesAppModel: ObservableObject {
  init() {
    load()
  }
}

// MARK: - Private

private extension MemoriesAppModel {
  func load() {
    loadDependencies()
  }
  
  func loadDependencies() {
    @Provider var imagesProvider = UnsplashImageProvider() as ImagesDependency
  }
}
