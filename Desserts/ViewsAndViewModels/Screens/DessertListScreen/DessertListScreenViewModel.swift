//
//  DessertListScreenViewModel.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

@Observable
final class DessertListScreenViewModel {
    var status: LoadingStates = .loading
    var desserts: [Dessert]

    var searchText = ""
    var searchResults: [Dessert] {
        if searchText.isEmpty {
            return desserts
        } else {
            return desserts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var bannerData = BannerModifier.BannerData()
    var showBanner = false

    init(desserts: [Dessert] = []) {
        self.desserts = desserts
    }

    func fetchDesserts() async throws {
        status = .loading
        do {
            desserts = try await Injector.shared.dataService.getDesserts()
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
