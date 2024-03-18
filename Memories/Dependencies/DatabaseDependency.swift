//
//  DatabaseDependency.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import Foundation

protocol DatabaseDependency {
  func fetchCurrentUser() async throws -> CurrentUser
}

// TODO: Plug to Firestore database
final class FirestoreProvider: DatabaseDependency {
  func fetchCurrentUser() async throws -> CurrentUser {
    CurrentUser(
      user: User(
        id: UUID(),
        firstName: "John",
        lastName: "Doe"
      ),
      friends: [],
      memories: [:]
    )
  }
}

#if DEBUG
final class MockDatabaseProvider: DatabaseDependency {
  func fetchCurrentUser() async throws -> CurrentUser {
    await CurrentUser()
  }
}
#endif
