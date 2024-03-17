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
    AsyncContentView(
      source: model,
      contentView: contentView
    )
  }
}

// MARK: - Private

private extension GalleryScreen {
  func contentView(with urls: [URL]) -> some View {
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

#if DEBUG
#Preview {
  @Provider var imagesProvider = UnsplashImageProvider() as ImagesDependency

  return GalleryScreen()
}
#endif
