//
//  Injector.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

final class Injector {
    // TODO: Put this in the environment
    static let shared = Injector()

    private let networkService: NetworkService
    private let imageCache: ImageCache
    let dataService: DataService

    init(networkService: NetworkService = DefaultNetworkService(), dataService: DataService? = nil, imageCache: ImageCache? = nil) {
        self.networkService = networkService

        if let imageCache {
            self.imageCache = imageCache
        } else {
            self.imageCache = DefaultImageCache(networkService: self.networkService)
        }

        if let dataService {
            self.dataService = dataService
        } else {
            self.dataService = DefaultDataService(networkService: self.networkService, imageCache: self.imageCache)
        }
    }
}
