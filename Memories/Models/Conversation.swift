//
//  Conversation.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import Foundation

struct Conversation: Identifiable, Equatable, Hashable {
  let id: UUID
  var messages: [Message]
}

struct Message: Identifiable, Equatable, Hashable {
  enum Content: Equatable, Hashable {
    case text(String)
    case image(URL)
  }

  let id: UUID
  let content: Content
  let isSender: Bool
}

#if DEBUG
extension Conversation {
  private static let randomMessages: [String] = [
    "Wow this image is great!",
    "I really LOVE the colors 😍",
    "Did you see we can scroll at the very top to display it back?"
  ]

  init() {
    self.id = UUID()
    self.messages = Self.randomMessages.map { textContent in
      Message(
        id: UUID(),
        content: .text(textContent),
        isSender: false
      )
    }
  }
}
#endif
