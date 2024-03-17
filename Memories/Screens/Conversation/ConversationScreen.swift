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
  @State private var backgroundBlurringOpacity = 1.0

  init(
    memory: Memory,
    friend: User
  ) {
    self._model = StateObject(
      wrappedValue: ConversationScreenModel(
        memory: memory,
        friend: friend
      )
    )
  }

  var body: some View {
    contentView
      .background(memoryBackgroundView)
  }
}

// MARK: - Private

private extension ConversationScreen {
  var contentView: some View {
    VStack(spacing: 4) {
      ScrollView {
        GeometryReader { geometry in
          Color.clear.preference(
            key: ScrollOffsetKey.self,
            value: geometry.frame(in: .named("scrollView")).minY
          )
        }
        .frame(height: 0)

        ForEach(model.memory.conversation.messages) { message in
          MessageView(message: message)
        }
      }
      .coordinateSpace(name: "scrollView")
      .onPreferenceChange(ScrollOffsetKey.self) { value in
        updateBackgroundOpacity(with: value)
      }

      HStack {
        TextField("Write a message...", text: $newMessage)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()

        Button(action: {
          model.sendMessage(content: .text(newMessage))
          newMessage = ""
        }) {
          Text("Send")
            .label()
        }
        .padding()
      }
      .opacity(backgroundBlurringOpacity)
    }
  }

  var memoryBackgroundView: some View {
    AsyncImage(url: model.memory.imageURL) { image in
      image
        .resizable()
        .scaledToFill()
        .overlay(
          .thinMaterial
            .opacity(backgroundBlurringOpacity)
        )
    } placeholder: {
      ProgressView()
    }
    .ignoresSafeArea()
  }

  func updateBackgroundOpacity(with scrollOffset: CGFloat) {
    let threshold: CGFloat = 100
    let opacity = min(max(1 - ((-scrollOffset) / threshold), 0), 1)
    self.backgroundBlurringOpacity = opacity
  }
}

// Preference key to pass the scroll offset
struct ScrollOffsetKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
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
        .label()
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
    memory: Memory(),
    friend: User()
  )
}
#endif
