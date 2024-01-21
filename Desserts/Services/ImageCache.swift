//
//  ImageCache.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/20/24.
//

import SwiftUI

protocol ImageCache: Actor {
    func getImage(from url: URL) async throws -> Image
}

// Reference type actor to cache images
// One call to getImage can occur at any time because the internal synchronization of the actor has eliminated that potential for data races on the actor's state.
// Calls within an actor are synchronous so the code in a funciton is run to completion uninterrunpted.
actor DefaultImageCache: ImageCache {
    // Using the CacheEntry ensures that the cache will not download the same image twice using
    // an inProgress state and ready state to notify any second calls to the function that for
    // the same url will wait until the data has been retutned form the first call to getImage
    // and then return that data
    private enum CacheEntry {
        case inProgress(Task<Image, Error>)
        case ready(Image)
    }

    let networkService: NetworkService
    private var cache = [URL: CacheEntry]()

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getImage(from url: URL) async throws -> Image {
        if let cached = cache[url] {
            switch cached {
            case .inProgress(let task):
                return try await task.value
            case .ready(let image):
                return image
            }
        }

        let task = Task {
            let imageData = try await networkService.getImageData(from: url)
            return Image(uiImage: UIImage(data: imageData) ?? UIImage(resource: .no))
        }

        cache[url] = .inProgress(task)

        do {
            let imageData = try await task.value
            cache[url] = .ready(imageData)
            return imageData
        } catch {
            cache[url] = nil
            throw error
        }
    }
}
