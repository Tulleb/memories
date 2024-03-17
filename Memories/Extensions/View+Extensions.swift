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

  func title() -> some View {
    font(.custom("Gluten-Black", size: 32))
  }

  func subtitle() -> some View {
    font(.custom("Gluten-Bold", size: 24))
  }

  func label() -> some View {
    font(.custom("Gluten-Regular", size: 16))
  }
}
