//
//  DessertListCellViewModel.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

@Observable
final class DessertListCellViewModel {
    var image: Image
    let name: String
    var isFavorited: Bool {
        Injector.shared.dataService.desserts.first(where: {$0.id == id})?.isFavorited ?? false
    }
    let id: String
    private let imageURL: URL

    init(name: String, imageURL: URL, image: Image = Image(.no), id: String) {
        self.id = id
        self.image = image
        self.imageURL = imageURL
        self.name = name
    }

    func loadImageIfNeeded() async {
        if image == Image(.no) {
            if let image = try? await Injector.shared.dataService.getImage(from: imageURL) {
                self.image = image
            }
        }
    }
}
