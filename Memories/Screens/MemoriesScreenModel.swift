//
//  GalleryScreenModel.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

@MainActor
final class MemoriesScreenModel: LoadableObject {
  @Published var state: LoadingState<[Memory]> = .idle

  private let friend: User

  init(friend: User) {
    self.friend = friend
  }

  func load() {
    Task {
      do {
        @Inject var databaseDependency: DatabaseDependency
        let memories = try await databaseDependency.fetchMemories(with: friend)
        self.state = .loaded(memories)
      } catch {
        self.state = .failed(error)
      }
    }
  }
}
