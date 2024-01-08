//
//  DessertDetails.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import Foundation

struct DessertDetails: Decodable {
    // 1-1 relationship between ingredients and measures
    struct Ingredient: Decodable {
        let name: String
        let measure: String
    }
    let name: String
    let instructions: String
    let ingredients: [Ingredient]
}
