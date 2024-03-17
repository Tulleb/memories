//
//  AsyncContentView.swift
//  Memories
//
//  Created by Guillaume Bellut on 17/03/2024.
//

import SwiftUI

struct AsyncContentView<
  Source: LoadableObject,
  ContentView: View
>: View {
  @ObservedObject private var source: Source

  private var contentView: (Source.Output) -> ContentView

  public init(
    source: Source,
    contentView: @escaping (Source.Output) -> ContentView
  ) {
    self.source = source
    self.contentView = contentView
  }

  public var body: some View {
    switch source.state {
    case .idle:
      Color.clear.onAppear {
        Task {
          await source.load()
        }
      }
    case .loading:
      ProgressView()
    case let .failed(error):
      Text(error.localizedDescription)
        .foregroundStyle(.red)
    case let .loaded(output):
      contentView(output)
    }
  }
}
