//
//  ViewModifiers.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

extension View {
  func frame(size: CGFloat) -> some View {
    frame(width: size, height: size)
  }
}
