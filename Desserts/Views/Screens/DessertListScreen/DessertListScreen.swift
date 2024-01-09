//
//  ContentView.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

struct DessertListScreen: View {
    private let exampleData = DessertListScreenDataStub.shared
    @State private var vm: DessertListScreenViewModel

    init(vm: DessertListScreenViewModel) {
        self.vm = vm
    }

    var body: some View {
        if !vm.isLoaded {
            VStack(spacing: 20) {
                ProgressView()
                Text("Loading...")
            }
            .task {
                try? await vm.fetchDesserts()
            }
        } else {
            List {
                ForEach(vm.desserts) { dessert in
                    NavigationLink(destination: DessertDetailScreen(vm: DessertDetailScreenViewModel(dessertID: dessert.id, imageURL: dessert.thumbnailURL))) {
                        DessertListCell(vm: DessertListCellViewModel(name: dessert.name, imageURL: dessert.thumbnailURL))
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Desserts")
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
        DessertListScreen(vm: DessertListScreenDataStub.shared.makeViewModel())
    }
}
