//
//  User.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import Foundation

struct User: Equatable {
  let id: String
  let firstName: String
  let lastName: String
}

@dynamicMemberLookup
struct CurrentUser: Equatable {
  let user: User
  let friends: [User]

  subscript<T>(dynamicMember keyPath: KeyPath<User, T>) -> T {
    user[keyPath: keyPath]
  }
}

#if DEBUG
extension User {
  static let randomNames: [String] = [
    "Taylor",
    "Jordan",
    "Morgan",
    "Ryan",
    "Parker",
    "Casey",
    "Cameron",
    "Kelly",
    "Jamie",
    "Alex",
    "Bailey",
    "Blair",
    "Quinn",
    "Peyton",
    "Avery",
    "Riley",
    "Kennedy",
    "Ellis",
    "Harper",
    "Carter",
    "Lee",
    "Reed",
    "Brooks",
    "Mackenzie",
    "Sawyer",
    "Kendall",
    "Carson",
    "Tyler",
    "Spencer",
    "Mason"
  ]

  init() {
    self.id = UUID().uuidString
    self.firstName = Self.randomNames.randomElement()!
    self.lastName = Self.randomNames.randomElement()!
  }
}

extension CurrentUser {
  init() {
    self.user = User()
    self.friends = (0 ... 20).map { _ in
      User()
    }
  }
}
#endif
