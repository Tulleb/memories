//
//  FriendsScreenModel.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

@MainActor
final class FriendsScreenModel: LoadableObject {
  enum Destination: Hashable {
    case memories(User, [Memory])
  }

  @Published var state: LoadingState<CurrentUser> = .idle
  @Published var destination: Destination?

  init() {
    load()
  }

  func load() {
    Task {
      @Inject var databaseProvider: DatabaseDependency

      do {
        let currentUser = try await databaseProvider.fetchCurrentUser()
        self.state = .loaded(currentUser)
      } catch {
        self.state = .failed(error)
      }
    }
  }

  func didTapFriend(_ friend: User) {
    guard case let .loaded(currentUser) = state,
          let memories = currentUser.memories[friend] else {
      // TODO: Handle error
      return
    }

    destination = .memories(friend, memories)
  }
}
