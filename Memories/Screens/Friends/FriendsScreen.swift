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
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          HStack {
            Image(.logo)
              .resizable()
              .frame(size: 40)
            Text("Memories")
              .title()
          }
        }
        ToolbarItem(placement: .bottomBar) {
          Button {
            // TODO: Implement sharing feature to create a new memory
          } label: {
            Text("Share")
              .label()
          }
        }
      }
    }
  }
}

// MARK: - Private

private extension FriendsScreen {
  func contentView(for currentUser: CurrentUser) -> some View {
    VStack(
      alignment: .center,
      spacing: 16
    ) {
      welcomeText(for: currentUser)
      friendsView(for: currentUser)
    }
    .padding()
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
    VStack(spacing: 8) {
      Text("Welcome \(currentUser.firstName) 👋")
        .subtitle()
      Text("Check your memories from...")
        .label()
    }
  }

  @ViewBuilder
  func friendsView(for currentUser: CurrentUser) -> some View {
    let columns = [
      GridItem(.flexible()),
      GridItem(.flexible())
    ]

    ScrollView {
      LazyVGrid(
        columns: columns,
        spacing: 24
      ) {
        ForEach(currentUser.friends) { friend in
          Button {
            model.didTapFriend(friend)
          } label: {
            FriendView(
              friend: friend,
              memories: currentUser.memories[friend] ?? []
            )
          }
        }
      }
    }
  }
}

struct FriendView: View {
  private let friend: User
  private let memories: [Memory]

  private let avatarSize: CGFloat = 80
  private let memorySize: CGFloat = 40

  init(
    friend: User,
    memories: [Memory]
  ) {
    self.friend = friend
    self.memories = memories
  }

  var body: some View {
    VStack(spacing: .zero) {
      ZStack(alignment: .center) {
        ForEach(Array(zip(memories.indices, memories)), id: \.0) { index, memory in
          memoryView(for: memory, at: index)
        }

        Text(friend.initials)
          .label()
          .foregroundStyle(.white)
          .fontWeight(.bold)
          .frame(size: avatarSize)
          .background(
            Circle()
              .fill(Color.gray)
          )
          .clipShape(Circle())
          .overlay(Circle().stroke(Color.white, lineWidth: 2))
      }
      .frame(size: avatarSize + memorySize * 2)

      Text(friend.firstName)
        .label()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

// MARK: - Private

private extension FriendView {
  func memoryView(
    for memory: Memory,
    at index: Int
  ) -> some View {
    // TODO: Fetch thumbnails URL here to increase performances
    AsyncImage(url: memory.imageURL) { image in
      image
        .resizable()
        .scaledToFill()
    } placeholder: {
      Color.gray
    }
    .frame(size: memorySize)
    .clipShape(Circle())
    .overlay(
      Circle()
        .stroke(Color.white, lineWidth: 1)
    )
    .position(
      x: cos(CGFloat(index) / CGFloat(memories.count) * 2 * .pi) * ((avatarSize + memorySize) / 2) + avatarSize / 2 + memorySize,
      y: sin(CGFloat(index) / CGFloat(memories.count) * 2 * .pi) * (avatarSize / 2) + avatarSize / 2 + memorySize
    )
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
