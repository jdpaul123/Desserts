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
                .frame(width: 50, height: 50)
            Text(vm.name)
        }
    }
}

@Observable
class DessertListCellViewModel {
    // This would be a great place for a mcro to confirm that the pngData below is not nil.
    var imageData: Data
    let name: String

    init(name: String, imageData: Data = UIImage(resource: .no).pngData()!) {
        self.imageData = imageData
        self.name = name
    }
}

struct DessertListCellDataStub {
    static let shared = DessertListCellDataStub()

    private let name = "Apple & Blackberry Crumble"

    func makeDessertListCellViewModel() -> DessertListCellViewModel {
        return DessertListCellViewModel(name: name)
    }
}

#Preview {
    DessertListCell(vm: DessertListCellViewModel(name: "Apple & Blackberry Crumble"))
}
