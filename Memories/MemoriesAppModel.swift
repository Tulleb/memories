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
    #if DEBUG
    @Provider var databaseProvider = MockDatabaseProvider() as DatabaseDependency
    #else
    @Provider var databaseProvider = FirestoreProvider() as DatabaseDependency
    #endif

    @Provider var imagesProvider = UnsplashImageProvider() as ImagesDependency
  }
}
