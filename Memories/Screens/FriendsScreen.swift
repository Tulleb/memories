//
//  FriendsScreen.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

struct FriendsScreen: View {
  @StateObject private var model = FriendsScreenModel()

  var body: some View {
    AsyncContentView(
      source: model,
      contentView: contentView
    )
  }
}

// MARK: - Private

private extension FriendsScreen {
  func contentView(for currentUser: CurrentUser) -> some View {
    Text("Welcome \(currentUser.firstName) 👋")
      .font(.title)
  }
}

#if DEBUG
#Preview {
  @Provider var databaseProvider = MockDatabaseProvider() as DatabaseDependency

  return FriendsScreen()
}
#endif
