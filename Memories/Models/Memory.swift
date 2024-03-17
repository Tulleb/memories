//
//  Memory.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import Foundation

struct Memory: Identifiable, Equatable, Hashable {
  let id: UUID
  let imageURL: URL
  var conversation: Conversation
}

#if DEBUG
extension Memory {
  init() {
    self.id = UUID()
    self.imageURL = URL(string: "https://picsum.photos/1024/1024")!
    self.conversation = Conversation()
  }
}
#endif
