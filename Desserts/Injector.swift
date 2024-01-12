//
//  Injector.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

final class Injector {
    static let shared = Injector()

    private let networkService: NetworkService
    let dataService: DataService

    init(networkService: NetworkService = DefaultNetworkService(), dataService: DataService? = nil) {
        self.networkService = networkService
        if let dataService {
            self.dataService = dataService
        } else {
            self.dataService = DefaultDataService(networkService: networkService)
        }
    }
}
