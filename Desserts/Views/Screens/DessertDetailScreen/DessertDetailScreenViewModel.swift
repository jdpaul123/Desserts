//
//  DessertDetailScreenViewModel.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

@Observable
class DessertDetailScreenViewModel {
    private let id: String
    let imageURL: URL
    var name: String
    var instructions: [String]
    var ingredients: [DessertDetails.Ingredient]

    init(dessertID: String, imageURL: URL) {
        self.id = dessertID
        self.imageURL = imageURL
        self.name = ""
        self.instructions = []
        self.ingredients = []
    }

    // Initializer for previewing and testing
    init(dessert: DessertDetails, imageURL: URL) {
        self.id = dessert.id
        self.imageURL = imageURL
        self.name = dessert.name
        self.instructions = dessert.instructions
        self.ingredients = dessert.ingredients
    }

    func fetchDessertDetails() async throws {
        do {
            let dessert = try await NetworkManager.shared.getDessertDetails(for: id)
            name = dessert.name
            instructions = dessert.instructions
            ingredients = dessert.ingredients
        } catch {
            throw error
        }
    }
}
