//
//  DessertListCellViewModel.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import UIKit

@Observable
final class DessertListCellViewModel {
    var imageData: Data
    let name: String
    private let imageURL: URL

    init(name: String, imageURL: URL, imageData: Data = UIImage(resource: .no).pngData()!) {
        self.imageData = imageData
        self.imageURL = imageURL
        self.name = name
    }

    func loadImageIfNeeded() async {
        if imageData == UIImage(resource: .no).pngData()! {
            await getImageData()
        }
    }

    private func getImageData() async {
        do {
            imageData = try await Injector.shared.dataService.getImageData(from: imageURL)
        } catch {
            return
        }
    }
}
