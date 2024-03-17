//
//  MemoriesApp.swift
//  Memories
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import SwiftUI

@main
struct MemoriesApp: App {
  @StateObject private var model = MemoriesAppModel()

  var body: some Scene {
    WindowGroup {
      FriendsScreen()
    }
  }
}
