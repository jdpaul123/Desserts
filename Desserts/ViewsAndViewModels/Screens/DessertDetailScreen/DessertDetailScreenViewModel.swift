//
//  DessertDetailScreenViewModel.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

@Observable
final class DessertDetailScreenViewModel {
    private let id: String
    private let imageURL: URL
    var image: Image
    var name: String
    var instructions: [String]
    var ingredients: [DessertDetails.Ingredient]

    var status: LoadingStates = .loading
    var showBanner = false
    var bannerData = BannerModifier.BannerData()

    init(dessertID: String, imageURL: URL) {
        self.id = dessertID
        self.imageURL = imageURL
        self.image = Image(.no)
        self.name = ""
        self.instructions = []
        self.ingredients = []
    }

    // Initializer for previewing and testing
    init(dessert: DessertDetails, imageURL: URL) {
        self.id = dessert.id
        self.imageURL = imageURL
        self.image = Image(.no)
        self.name = dessert.name
        self.instructions = dessert.instructions
        self.ingredients = dessert.ingredients
    }

    func fetchDessertDetails() async throws {
        status = .loading
        do {
            let dessert = try await Injector.shared.dataService.getDessertDetails(for: id)
            // Get the image, but don't wait for it if it has to download
            Task {
                if let image = try? await Injector.shared.dataService.getImage(from: imageURL) {
                    self.image = image
                }
            }
            name = dessert.name
            instructions = dessert.instructions
            ingredients = dessert.ingredients
            status = .success
        } catch {
            guard let error = error as? NetworkException else { return }
            bannerData.title = "Error"
            bannerData.detail = error.userMessage
            showBanner = true
            status = .failed
        }
    }
}
