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
  let conversation: Conversation
}
