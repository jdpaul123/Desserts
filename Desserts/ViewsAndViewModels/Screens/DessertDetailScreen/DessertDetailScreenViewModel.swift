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

    var status: LoadingStates = .loading
    var showBanner = false
    var bannerData = BannerModifier.BannerData()

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
        status = .loading
        do {
            let dessert = try await NetworkService.shared.getDessertDetails(for: id)
            name = dessert.name
            instructions = dessert.instructions
            ingredients = dessert.ingredients
            status = .success
        } catch {
            guard let error = error as? ErrorMessage else { return }
            bannerData.title = "Error"
            bannerData.detail = error.rawValue
            showBanner = true
            status = .failed
        }
    }
}
