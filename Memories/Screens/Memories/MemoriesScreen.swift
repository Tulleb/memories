//
//  GalleryScreen.swift
//  Memories
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import SwiftUI

struct MemoriesScreen: View {
  @StateObject private var model: MemoriesScreenModel

  init(
    friend: User,
    memories: [Memory]
  ) {
    self._model = StateObject(
      wrappedValue: MemoriesScreenModel(
        friend: friend,
        memories: memories
      )
    )
  }

  var body: some View {
    contentView
      .navigationDestination(
        item: $model.destination,
        destination: destinationView
      )
  }
}

// MARK: - Private

private extension MemoriesScreen {
  var contentView: some View {
    VStack {
      friendView
        .padding(.horizontal, 16)
      memoriesView
    }
  }

  func destinationView(for destination: MemoriesScreenModel.Destination) -> some View {
    switch destination {
    case let .conversation(memory, friend):
      ConversationScreen(
        memory: memory,
        friend: friend
      )
    }
  }

  var friendView: some View {
    Text("Your memories with \(model.friend.firstName)")
      .subtitle()
  }

  var memoriesView: some View {
    ScrollView {
      VStack {
        ForEach(model.memories) { memory in
          memoryView(for: memory)
        }
      }
    }
  }

  func memoryView(for memory: Memory) -> some View {
    GeometryReader { geometry in
      Button {
        model.didTapMemory(memory)
      } label: {
        AsyncImage(url: memory.imageURL)
      }
        Button(
          action: {
            model.didTapMemory(memory)
          }) {
            AsyncImage(url: memory.imageURL) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(y: getOffset(geometry: geometry))
                .clipped()
            } placeholder: {
              ProgressView()
            }
          }
//          .buttonStyle(PlainButtonStyle())
    }
    .frame(height: 200) // Fixed height for each image container
  }

  func getOffset(geometry: GeometryProxy) -> CGFloat {
    let offset = geometry.frame(in: .global).minY
    let height = geometry.size.height
    let speed = 20.0
    let parallax = -offset / height * speed
    return parallax
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
                imageURL: $0,
                conversation: Conversation()
              )
            }
        }
      }
    }
  }

  return AsyncPreview()
}
#endif
