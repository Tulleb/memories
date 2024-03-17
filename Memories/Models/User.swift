//
//  User.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import Foundation

struct User: Equatable, Identifiable, Hashable {
  let id: UUID
  let firstName: String
  let lastName: String
}

@dynamicMemberLookup
struct CurrentUser: Equatable {
  let user: User
  let friends: [User]
  let memories: [User: [Memory]]

  subscript<T>(dynamicMember keyPath: KeyPath<User, T>) -> T {
    user[keyPath: keyPath]
  }
}
