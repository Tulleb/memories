//
//  Preview.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

#if DEBUG
import SwiftUI

struct Preview<Value: View>: View {
  private let viewToPreview: () -> Value

  init(@ViewBuilder _ viewToPreview: @escaping () -> Value) {
    self.viewToPreview = viewToPreview
  }

  var body: some View {
    viewToPreview()
      .onLoad(injectDependencies)
  }

  func injectDependencies() {
    @Provider var imagesProvider = UnsplashImageProvider() as ImagesDependency
    @Provider var databaseProvider = MockDatabaseProvider() as DatabaseDependency
  }
}

struct LogicLoader<T>: View where T: View {
  private var content: T

  init(_ closure: () -> Void, content: T) {
    closure()
    self.content = content
  }

  var body: some View {
    content
  }
}

extension View {
  func onLoad(_ closure: () -> Void) -> some View {
    LogicLoader(
      closure,
      content: self
    )
  }
}
#endif

