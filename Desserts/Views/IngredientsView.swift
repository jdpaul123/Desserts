//
//  IngredientsView.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

struct IngredientsView: View {
    @State var vm: IngredientsListViewModel

    var body: some View {
        List(vm.ingredients, id: \.name) { ingredient in
            HStack {
                Text(ingredient.name)
                Spacer()
                Text(ingredient.measure)
            }
        }
    }
}

@Observable
class IngredientsListViewModel {
    var ingredients: [DessertDetails.Ingredient]

    init(ingredients: [DessertDetails.Ingredient]) {
        self.ingredients = ingredients
    }
}

struct IngredientsViewDataStub {
    static var exampleIngredients = [
        DessertDetails.Ingredient(name: "Milk", measure: "1 cup"),
        DessertDetails.Ingredient(name: "Eggs", measure: "2"),
        DessertDetails.Ingredient(name: "Flour", measure: "1 cup"),
        DessertDetails.Ingredient(name: "Sugar", measure: "1/2 cup"),
    ]
}

#Preview {
    IngredientsView(vm: IngredientsListViewModel(ingredients: IngredientsViewDataStub.exampleIngredients))
}
