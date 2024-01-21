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
    private let imageURL: URL

    init(name: String, imageURL: URL, image: Image = Image(.no)) {
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
