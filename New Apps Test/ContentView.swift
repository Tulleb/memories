//
//  ContentView.swift
//  New Apps Test
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    var imageService = UnsplashService()
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
            let urls = await imageService.getFeaturedPhotos()
            images = urls.map { URL(string: $0)! }
        }
    }
}

#Preview {
    ContentView()
}
