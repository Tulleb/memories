//
//  ConversationScreen.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import Foundation

import SwiftUI

struct ConversationScreen: View {
  @StateObject private var model: ConversationScreenModel
  @State private var newMessage: String = ""

  init(conversation: Conversation) {
    self._model = StateObject(
      wrappedValue: ConversationScreenModel(conversation: conversation)
    )
  }

  var body: some View {
    contentView
  }
}

// MARK: - Private

private extension ConversationScreen {
  var contentView: some View {
    VStack(spacing: 4) {
      ScrollView {
        ForEach(model.conversation.messages) { message in
          MessageView(message: message)
        }
      }
    }
  }
}

struct MessageView: View {
  private let message: Message

  init(message: Message) {
    self.message = message
  }

  var body: some View {
    HStack {
      if message.isSender {
        Spacer()
        contentView
      } else {
        contentView
        Spacer()
      }
    }
    .padding(message.isSender ? .leading : .trailing, 50)
    .padding(.horizontal, 8)
  }
}

// MARK: - Private

private extension MessageView {
  @ViewBuilder
  var contentView: some View {
    switch message.content {
    case .text(let string):
      Text(string)
        .padding()
        .background(backgroundView)
        .foregroundColor(.white)
        .cornerRadius(8)
    case .image(let url):
      AsyncImage(url: url)
    }
  }

  var backgroundView: some View {
    message.isSender ? Color.blue : Color.gray
  }
}

#if DEBUG
#Preview {
  ConversationScreen(
    conversation: Conversation()
  )
}
#endif
