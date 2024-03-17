//
//  ConversationScreenModel.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

final class ConversationScreenModel: ObservableObject {
  @Published var memory: Memory
  @Published var friend: User

  init(
    memory: Memory,
    friend: User
  ) {
    self.memory = memory
    self.friend = friend
  }

  func sendMessage(content: Message.Content) {
    let newMessage = Message(
      id: UUID(),
      content: content,
      isSender: true)
    memory.conversation.messages.append(newMessage)
  }
}
