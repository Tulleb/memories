//
//  GalleryScreen.swift
//  Memories
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import SwiftUI

struct MemoriesScreen: View {
  private let friend: User
  private let memories: [Memory]

  init(
    friend: User,
    memories: [Memory]
  ) {
    self.friend = friend
    self.memories = memories
  }

  var body: some View {
    VStack {
      friendView
      memoriesView
    }
    .padding()
  }
}

// MARK: - Private

private extension MemoriesScreen {
  var friendView: some View {
    Text("Your memories with \(friend.firstName)")
      .font(.title)
  }

  var memoriesView: some View {
    ScrollView {
      VStack {
        ForEach(memories) { memory in
          AsyncImage(url: memory.imageURL)
        }
      }
    }
  }
}

#if DEBUG
#Preview {
  struct AsyncPreview: View {
    let user = User()
    @State var memories = [Memory]()

    var body: some View {
      Preview {
        MemoriesScreen(
          friend: user,
          memories: memories
        )
      }
      .task {
        @Inject var imagesProvider: ImagesDependency
        let imagesURLs = try! await imagesProvider.fetchImageURLs()
        self.memories = imagesURLs
          .filter { _ in
            Bool.random()
          }
          .map {
            Memory(
              id: UUID(),
              imageURL: $0
            )
          }
      }
    }
  }

  return AsyncPreview()
}
#endif
