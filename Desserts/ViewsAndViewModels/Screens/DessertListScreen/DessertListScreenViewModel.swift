//
//  DessertListScreenViewModel.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

@Observable
class DessertListScreenViewModel {
    var status: LoadingStates = .loading
    var desserts: [Dessert]

    var bannerData = BannerModifier.BannerData()
    var showBanner = false

    init(desserts: [Dessert] = []) {
        self.desserts = desserts
    }

    func fetchDesserts() async throws {
        do {
            desserts = try await NetworkManager.shared.getDesserts()
            status = .success
        } catch {
            guard let error = error as? ErrorMessage else {
                return
            }
            status = .failed
            bannerData.title = "Error"
            bannerData.detail = error.rawValue
            showBanner = true
            throw error
        }
    }
}
