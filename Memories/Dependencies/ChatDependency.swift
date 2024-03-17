//
//  ChatService.swift
//  Memories
//
//  Created by Michel-André Chirita on 11/03/2024.
//

import Foundation

protocol ChatDependencyProtocol {
  func post(message: String)
  func getMessages() -> [String]
}
