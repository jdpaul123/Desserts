//
//  DessertDetailScreen.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

struct DessertDetailScreen: View {
    @State private var vm: DessertDetailScreenViewModel

    init(vm: DessertDetailScreenViewModel) {
        self.vm = vm
    }

    var body: some View {
        List {
            AsyncImage(url: vm.imageURL) { image in
                image
                    .resizable()
            } placeholder: {
                Image(.no)
                    .resizable()
            }
            .scaledToFill()
            .frame(idealWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height * 0.40)
            .clipped()
            Section {
                ForEach(vm.ingredients) { ingredient in
                    HStack {
                        Text(ingredient.name)
                        Spacer()
                        Text(ingredient.measure)
                    }
                    .padding(.init(top: 0, leading: 20, bottom: 4, trailing: 20))
                }
            }
            header: {
                Text("Ingredients")
                    .font(.title2)
            }
            Section {
                Text(vm.instructions)
                    .padding(.init(top: 15, leading: 20, bottom: 15, trailing: 20))
            } header: {
                Text("Instructions")
                    .font(.title2)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(vm.name)
        .task {
            do {
                try await vm.fetchDessertDetails()
            } catch {
                // TODO: Show error on screen as banner or alert.
            }
        }
    }
}

@Observable
class DessertDetailScreenViewModel {
    private let id: String
    let imageURL: URL
    var name: String
    var instructions: String
    var ingredients: [DessertDetails.Ingredient]

    init(dessertID: String, imageURL: URL) {
        self.id = dessertID
        self.imageURL = imageURL
        self.name = ""
        self.instructions = ""
        self.ingredients = []
    }

    // Initializer for previewing and testing
    init(dessert: DessertDetails, imageURL: URL) {
        self.id = dessert.id
        self.imageURL = imageURL
        self.name = dessert.name
        self.instructions = dessert.instructions
        self.ingredients = dessert.ingredients
    }

    func fetchDessertDetails() async throws {
        do {
            let dessert = try await NetworkManager.shared.getDessertDetails(for: id)
            name = dessert.name
            instructions = dessert.instructions
            ingredients = dessert.ingredients
        } catch {
            throw error
        }
    }
}

class DessertDetailScreenDataStub {
    static let shared = DessertDetailScreenDataStub()
    let dessert = DessertDetails(id: "52893",
                                 name: "Apple & Blackberry Crumble",
                                 instructions: "Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured.\r\nMeanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan.\r\nTo serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream.",
                                 ingredients: [
                                    DessertDetails.Ingredient(name: "Plain Flour", measure: "120g"),
                                    DessertDetails.Ingredient(name: "Caster Sugar", measure: "60g"),
                                    DessertDetails.Ingredient(name: "Butter", measure: "60g"),
                                    DessertDetails.Ingredient(name: "Braeburn Apples", measure: "300g"),
                                    DessertDetails.Ingredient(name: "Butter", measure: "30g"),
                                    DessertDetails.Ingredient(name: "Demerara Sugar", measure: "30g"),
                                    DessertDetails.Ingredient(name: "Blackberrys", measure: "120g"),
                                    DessertDetails.Ingredient(name: "Cinnamon", measure: "¼ teaspoon"),
                                    DessertDetails.Ingredient(name: "Ice Cream", measure: "to serve")
                                    ])
}

#Preview {
//    DessertDetailScreen(vm: DessertDetailScreenViewModel(dessert: DessertDetailScreenDataStub.shared.dessert))
    NavigationStack {
        DessertDetailScreen(vm: DessertDetailScreenViewModel(dessertID: "52898", imageURL: URL(string: "https://www.themealdb.com/images/media/meals/vqpwrv1511723001.jpg")!))
    }
}
