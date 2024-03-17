//
//  GalleryScreen.swift
//  Memories
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import SwiftUI

struct GalleryScreen: View {
  @StateObject private var model = GalleryScreenModel()

  var body: some View {
    switch model.state {
    case .loading:
      loadingView
    case .loaded(let urls):
      loadedView(with: urls)
    }
  }
}

// MARK: - Private

private extension GalleryScreen {
  var loadingView: some View {
    ProgressView()
  }

  func loadedView(with urls: [URL]) -> some View {
    ScrollView {
      VStack {
        ForEach(urls, id: \.self) { url in
          AsyncImage(url: url)
        }
      }
    }
    .padding()
  }
}

#Preview {
  @Provider var imagesProvider = UnsplashImageProvider() as ImagesDependency

  return GalleryScreen()
}
