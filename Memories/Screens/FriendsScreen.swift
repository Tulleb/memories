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
    NavigationStack {
      AsyncContentView(
        source: model,
        contentView: contentView
      )
      .navigationDestination(
        item: $model.destination,
        destination: destinationView
      )
    }
  }
}

// MARK: - Private

private extension FriendsScreen {
  func contentView(for currentUser: CurrentUser) -> some View {
    VStack(alignment: .leading) {
      welcomeText(for: currentUser)
      friendsView(for: currentUser)
    }
  }

  func destinationView(for destination: FriendsScreenModel.Destination) -> some View {
    switch destination {
    case let .memories(friend, memories):
      MemoriesScreen(
        friend: friend,
        memories: memories
      )
    }
  }

  func welcomeText(for currentUser: CurrentUser) -> some View {
    Text("Welcome \(currentUser.firstName) 👋")
      .font(.title)
  }

  @ViewBuilder
  func friendsView(for currentUser: CurrentUser) -> some View {
    let columns = [
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible())
    ]

    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(currentUser.friends) { friend in
          friendView(for: friend)
        }
      }
    }
  }

  func friendView(for user: User) -> some View {
    Button {
      model.didTapFriend(user)
    } label: {
      Text(user.initials)
        .foregroundStyle(.white)
        .fontWeight(.bold)
        .padding()
        .frame(size: 64)
        .background(
          Circle()
            .fill(Color.gray)
        )
    }
  }
}

extension User {
  var initials: String {
    [
      firstName.first?.description,
      lastName.first?.description
    ].compactMap { $0 }.joined()
  }
}

#if DEBUG
#Preview {
  Preview {
    FriendsScreen()
  }
}
#endif
