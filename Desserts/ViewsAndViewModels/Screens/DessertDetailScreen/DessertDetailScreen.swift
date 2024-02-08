//
//  DessertDetailScreen.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

struct DessertDetailScreen: View {
    @State private var viewModel: DessertDetailScreenViewModel

    init(viewModel: DessertDetailScreenViewModel) {
        self.viewModel = viewModel
    }

    let verticalPadding: CGFloat = 4
    let horizontalPadding: CGFloat = 20

    var body: some View {
        switch viewModel.status {
        case .loading:
            LoadingView()
            .task {
                try? await viewModel.fetchDessertDetails()
            }
        case .failed:
            PullToRefreshView()
                .refreshable {
                    try? await viewModel.fetchDessertDetails()
                }
                .banner(data: $viewModel.bannerData, show: $viewModel.showBanner)
        case .success:
            List {
                viewModel.image
                    .resizable()
                    .listRowInsets(EdgeInsets())
                    .scaledToFill()
                    .frame(idealWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height * 0.40)
                    .clipped()
                Section {
                    ForEach(viewModel.ingredients) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Text(ingredient.measure)
                        }
                        .padding(.init(top: verticalPadding, leading: horizontalPadding, bottom: verticalPadding, trailing: horizontalPadding))
                        .listRowSeparator(.hidden)
                    }
                }
                header: {
                    Text("Ingredients")
                        .font(.title2)
                }
                Section {
                    ForEach(viewModel.instructions, id: \.self) { instruction in
                        Text(instruction)
                            .padding(.init(top: verticalPadding, leading: horizontalPadding, bottom: verticalPadding, trailing: horizontalPadding))
                    }
                } header: {
                    Text("Instructions")
                        .font(.title2)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                viewModel.isFavorited.toggle()
            }, label: {
                if viewModel.isFavorited {
                    Label("heart", systemImage: "heart.fill")
                        .foregroundStyle(.red)
                } else {
                    Label("heart", systemImage: "heart")
                        .foregroundStyle(.red)
                }
            }))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.name)
        }
    }
}

struct DessertDetailScreenPreviewStub {
    static let shared = DessertDetailScreenPreviewStub()
    let imageURL = URL(string: "https://www.themealdb.com/images/media/meals/vqpwrv1511723001.jpg")!
    let dessert: DessertDetails

    init() {
        let instructionsString = "Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured.\r\nMeanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan.\r\nTo serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream."
        var instructions: [String] {
            var index = 0
            // Number the instructions on each line break
            return instructionsString.components(separatedBy: "\n").compactMap({ element in
                if element.isEmpty || element == "" || element == "\r" {
                    return nil
                }
                index += 1
                return "\(index). \(element)"
            })
        }
        self.dessert = DessertDetails(id: "52893",
                         name: "Apple & Blackberry Crumble",
                         instructions: instructions,
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


}

#Preview {
    NavigationStack {
        DessertDetailScreen(viewModel: DessertDetailScreenViewModel(dessert: DessertDetailScreenPreviewStub.shared.dessert, imageURL: DessertDetailScreenPreviewStub.shared.imageURL))
    }
}
