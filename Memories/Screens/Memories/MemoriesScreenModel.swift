//
//  GalleryScreenModel.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

@MainActor
final class MemoriesScreenModel: ObservableObject {
  enum Destination: Hashable {
    case conversation(Conversation)
  }

  @Published var friend: User
  @Published var memories: [Memory]
  @Published var destination: Destination?

  init(
    friend: User,
    memories: [Memory]
  ) {
    self.friend = friend
    self.memories = memories
  }

  func didTapMemory(_ memory: Memory) {
    self.destination = .conversation(memory.conversation)
  }
}
