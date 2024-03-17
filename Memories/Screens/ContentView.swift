//
//  ContentView.swift
//  Memories
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import SwiftUI

struct ContentView: View {
  
  var imageService = UnsplashImageProvider()
  @State var images: [URL] = []
  
  var body: some View {
    ScrollView {
      VStack {
        ForEach(images, id: \.self) { url in
          AsyncImage(url: url)
        }
      }
    }
    .padding()
    .task {
      images = try! await imageService.fetchImageURLs()
    }
  }
}

#Preview {
  ContentView()
}
