//
//  DessertListScreenViewModel.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

@Observable
class DessertListScreenViewModel {
    var isLoaded = false
    var desserts: [Dessert]

    init(desserts: [Dessert] = []) {
        self.desserts = desserts
    }

    func fetchDesserts() async throws {
        do {
            desserts = try await NetworkManager.shared.getDesserts()
            isLoaded = true
        } catch {
            throw error
        }
    }
}
