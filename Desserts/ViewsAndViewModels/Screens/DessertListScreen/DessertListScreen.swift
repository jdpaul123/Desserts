//
//  ContentView.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

struct DessertListScreen: View {
    @State private var viewModel: DessertListScreenViewModel

    init(viewModel: DessertListScreenViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        switch viewModel.status {
        case .loading:
            LoadingView()
                .task {
                    try? await viewModel.fetchDesserts()
                }
        case .failed:
            PullToRefreshView()
                .refreshable {
                    try? await viewModel.fetchDesserts()
                }
                .banner(data: $viewModel.bannerData, show: $viewModel.showBanner)
        case .success:
            List {
                ForEach(viewModel.searchResults) { dessert in
                    NavigationLink(destination: DessertDetailScreen(viewModel: DessertDetailScreenViewModel(dessertID: dessert.id, imageURL: dessert.thumbnailURL))) {
                        DessertListCell(viewModel: DessertListCellViewModel(name: dessert.name, imageURL: dessert.thumbnailURL, id: dessert.id))
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Desserts")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct DessertListScreenDataStub {
    static let shared = DessertListScreenDataStub()

    private let desserts = [
        Dessert(id: "53049", name: "Apam balik", thumbnailURL: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!),
        Dessert(id: "52893", name: "Apple & Blackberry Crumble", thumbnailURL: URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!),
        Dessert(id: "52768", name: "Apple Frangipan Tart", thumbnailURL: URL(string: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")!),
        Dessert(id: "52767", name: "Bakewell tart", thumbnailURL: URL(string: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg")!),
        Dessert(id: "52855", name: "Banana Pancakes", thumbnailURL: URL(string: "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg")!)
    ]

    func makeViewModel() -> DessertListScreenViewModel {
        return .init(desserts: desserts)
    }
}

#Preview {
    NavigationStack {
        DessertListScreen(viewModel: DessertListScreenDataStub.shared.makeViewModel())
    }
}
