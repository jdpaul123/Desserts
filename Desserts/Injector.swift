//
//  Injector.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

@Observable
class Injector {
    static let shared = Injector()

    private let networkService: NetworkService = DefaultNetworkService()
    let dataService: DataService

    init() {
        dataService = DefaultDataService(networkService: networkService)
    }
}
