//
//  GalleryScreen.swift
//  Memories
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import SwiftUI

struct MemoriesScreen: View {
  @StateObject private var model: MemoriesScreenModel

  init(friend: User) {
    self._model = StateObject(
      wrappedValue: MemoriesScreenModel(friend: friend)
    )
  }

  var body: some View {
    AsyncContentView(
      source: model,
      contentView: contentView
    )
  }
}

// MARK: - Private

private extension MemoriesScreen {
  func contentView(with memories: [Memory]) -> some View {
    ScrollView {
      VStack {
        ForEach(memories) { memory in
          AsyncImage(url: memory.imageURL)
        }
      }
    }
    .padding()
  }
}

#if DEBUG
#Preview {
  Preview {
    MemoriesScreen(friend: User())
  }
}
#endif
