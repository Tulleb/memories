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

#if DEBUG
extension User {
  private static let randomNames: [String] = [
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
    self.id = UUID()
    self.firstName = Self.randomNames.randomElement()!
    self.lastName = Self.randomNames.randomElement()!
  }
}

extension CurrentUser {
  init() async {
    self.user = User()

    let friends = (0 ... 20).map { _ in
      User()
    }
    self.friends = friends

    @Inject var imagesProvider: ImagesDependency
    let imagesURLs = try! await imagesProvider.fetchImageURLs()

    self.memories = friends.reduce([User: [Memory]]()) { partialResult, friend in
      var partialResult = partialResult
      let memories = imagesURLs
        .filter { _ in
          Int.random(in: 1...3) == 1
        }
        .map {
          Memory(
            id: UUID(),
            imageURL: $0,
            conversation: Conversation(
              id: UUID(),
              messages: []
            )
          )
        }
      partialResult[friend] = memories
      return partialResult
    }
  }
}
#endif
