//
//  ConversationScreenModel.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

final class ConversationScreenModel: ObservableObject {
  @Published var conversation: Conversation

  init(conversation: Conversation) {
    self.conversation = conversation
  }

  func sendMessage(content: Message.Content) {
    let newMessage = Message(
      id: UUID(),
      content: content,
      isSender: true)
    conversation.messages.append(newMessage)
  }
}
