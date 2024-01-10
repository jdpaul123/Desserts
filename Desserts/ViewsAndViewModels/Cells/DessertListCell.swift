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
            // Using Image instead of Async image to avoid calling the API redundantly when scrolling over content that was already loaded
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
