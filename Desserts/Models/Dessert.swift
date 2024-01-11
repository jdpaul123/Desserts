//
//  Dessert.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import Foundation

// Dessert acts as both a data transfer object and a domain model.
struct Dessert: Codable, Identifiable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
    let id: String
    let name: String
    let thumbnailURL: URL
}
