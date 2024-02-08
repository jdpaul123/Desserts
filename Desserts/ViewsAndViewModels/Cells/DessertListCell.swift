//
//  DessertListCell.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

struct DessertListCell: View {
    @State private var viewModel: DessertListCellViewModel

    init(viewModel: DessertListCellViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            HStack {
                // Using Image instead of Async image to avoid calling the API redundantly when scrolling over content that was already loaded
                viewModel.image
                    .resizable()
                    .frame(width: 115, height: 115)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text(viewModel.name)
                Spacer()
            }
            if viewModel.isFavorited {
                HStack {
                    Spacer()
                        .ignoresSafeArea(edges: .trailing)
                    VStack {
                        Label("", systemImage: "heart.fill")
                            .foregroundStyle(.red)
                            .clipped()
                            .padding()
                            .offset(x: 55, y: -10)
                        Spacer()
                    }
                }
            }
        }
        .task {
            await viewModel.loadImageIfNeeded()
        }
        .frame(height: 100)
    }
}

struct DessertListCellDataStub {
    static let shared = DessertListCellDataStub()

    private let name = "Apple & Blackberry Crumble"
    private let imageURL = URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!

    func makeDessertListCellViewModel() -> DessertListCellViewModel {
        return DessertListCellViewModel(name: name, imageURL: imageURL, id: "123")
    }
}

#Preview {
    DessertListCell(viewModel: DessertListCellDataStub.shared.makeDessertListCellViewModel())
        .frame(height: 100)
}
