//
//  UnsplashService.swift
//  Memories
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import Foundation

protocol ImagesDependency {
  func fetchImageURLs() async throws -> [URL]
}

final class UnsplashImageProvider: ImagesDependency {
  private enum CustomError: Error {
    case parsingImagesURLError
    case parsingImageURLError
  }

  struct ImageData: Decodable {
    let url: URL

    enum RootCodingKeys: String, CodingKey {
      case urls
    }

    enum URLsCodingKeys: String, CodingKey {
      case regular
    }

    public init(from decoder: Decoder) throws {
      let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
      let urlsContainer = try rootContainer.nestedContainer(keyedBy: URLsCodingKeys.self, forKey: .urls)

      let urlString = try urlsContainer.decode(String.self, forKey: .regular)
      guard let url = URL(string: urlString) else {
        throw CustomError.parsingImageURLError
      }

      self.url = url
    }
  }

  private let appId = "575727"
  private let accessKey = "8j7cdQS9HM1tfIomk_dUwqrIZ7wnymEECz6xk6OPP6k"
  private let baseURL = "https://api.unsplash.com/"

  private var imagesURL: URL? {
    URL(string: baseURL + "/photos/?client_id=" + accessKey)!
  }

  func fetchImageURLs() async throws -> [URL] {
    guard let imagesURL else {
      throw CustomError.parsingImagesURLError
    }

    let result = try await URLSession.shared.data(from: imagesURL)
    let imageInfos = try JSONDecoder().decode([ImageData].self, from: result.0)
    return imageInfos.map { $0.url }
  }
}
