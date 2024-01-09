//
//  DessertListCell.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

struct DessertListCell: View {
    @State private var vm: DessertListCellViewModel

    init(vm: DessertListCellViewModel) {
        self.vm = vm
    }

    var body: some View {
        HStack {
            // TODO: Use async image here?
            Image(uiImage: .init(data: vm.imageData)!)
                .resizable()
                .frame(width: 115, height: 115)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(vm.name)
        }
        .task {
            await vm.loadImageIfNeeded()
        }
    }
}

@Observable
class DessertListCellViewModel {
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
            await getImage()
        }
    }

    private func getImage() async {
        let newImageData = await NetworkManager.shared.getImage(from: imageURL)
        guard let newImageData = newImageData else {
            print("failed")
            return
        }
        imageData = newImageData
    }
}

struct DessertListCellDataStub {
    static let shared = DessertListCellDataStub()

    private let name = "Apple & Blackberry Crumble"
    private let imageURL = URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!

    func makeDessertListCellViewModel() -> DessertListCellViewModel {
        return DessertListCellViewModel(name: name, imageURL: imageURL)
    }
}

#Preview {
    DessertListCell(vm: DessertListCellDataStub.shared.makeDessertListCellViewModel())
}
