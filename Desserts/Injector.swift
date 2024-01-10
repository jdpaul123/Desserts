//
//  Injector.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

// TODO: In the future, make all of the services conform to a protocol and create an initialzier for this class that sets the Injectior's properties using Mock Versions
@Observable
class Injector {
    static let shared = Injector()
    private let networkService = NetworkService()
    let dataService = DataService()

    init() {
        // Set the networkService as a weak variable to avoid a reference cycle
        dataService.networkService = networkService
    }
}
