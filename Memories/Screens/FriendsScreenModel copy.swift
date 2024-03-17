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
    case memories(User)
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

  func didTapFriend(_ user: User) {
    destination = .memories(user)
  }
}
