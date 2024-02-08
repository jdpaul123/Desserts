//
//  DataService.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

protocol DataService {
    func getDesserts() async throws -> [Dessert]
    func getDessertDetails(for dessertID: String) async throws -> DessertDetails
    func getImage(from url: URL) async throws -> Image
    func setDessertFavoriteValue(dessertId: String, isFavorite: Bool )
    var desserts: [Dessert] { get }
}

// Put the data service in the environment from the top of the list view
// Another option would be to use Combine
final class DefaultDataService: DataService {
    private let networkService: NetworkService
    private let imageCache: ImageCache
    internal var desserts = [Dessert]()

    init(networkService: NetworkService, imageCache: ImageCache) {
        self.networkService = networkService
        self.imageCache = imageCache
    }

    /// Get all the desserts and sort the data
    func getDesserts() async throws -> [Dessert] {
        var desserts = try await networkService.getDesserts()

        // Sort the desserts by name alphabetically
        desserts.sort { $0.name < $1.name }

        self.desserts = desserts
        return desserts
    }

    func setDessertFavoriteValue(dessertId: String, isFavorite: Bool ) {
        guard let index = desserts.firstIndex(where: { dessert in
            dessert.id == dessertId
        }) else { return }
        desserts[index].isFavorited = isFavorite
    }

    /// Get the details for a dessert and process the data into the model
    func getDessertDetails(for dessertID: String) async throws -> DessertDetails {
        let dessertDetailsDTO = try await networkService.getDessertDetails(for: dessertID)

        // TODO: Split the instructions into numebred items in the View Model for details
        var instructions: [String] {
            var index = 0
            // Number the instructions on each line break
            return dessertDetailsDTO.strInstructions.components(separatedBy: "\n").compactMap({ element in
                if element.isEmpty || element == "" || element == "\r" {
                    return nil
                }
                index += 1
                return "\(index). \(element)"
            })
        }

        // TODO: Decode the ingredients directly into an array using dynamic Coding Keys?
        var ingredients: [DessertDetails.Ingredient] {
            // When the JSON does not have an ingredient at one of the 20 ingredient properties the value of the property is empty quotes or null value

            // This is the cleanest way I can think of to get the values from the api and process them into the model
            // Step 1: Get the optional string for each ingredient/measure
            let ingredientTuples: [(KeyPath<DessertDetailsDTO, String?>, KeyPath<DessertDetailsDTO, String?>)] = [
                (\DessertDetailsDTO.strIngredient1, \DessertDetailsDTO.strMeasure1),
                (\DessertDetailsDTO.strIngredient2, \DessertDetailsDTO.strMeasure2),
                (\DessertDetailsDTO.strIngredient3, \DessertDetailsDTO.strMeasure3),
                (\DessertDetailsDTO.strIngredient4, \DessertDetailsDTO.strMeasure4),
                (\DessertDetailsDTO.strIngredient5, \DessertDetailsDTO.strMeasure5),
                (\DessertDetailsDTO.strIngredient6, \DessertDetailsDTO.strMeasure6),
                (\DessertDetailsDTO.strIngredient7, \DessertDetailsDTO.strMeasure7),
                (\DessertDetailsDTO.strIngredient8, \DessertDetailsDTO.strMeasure8),
                (\DessertDetailsDTO.strIngredient9, \DessertDetailsDTO.strMeasure9),
                (\DessertDetailsDTO.strIngredient10, \DessertDetailsDTO.strMeasure10),
                (\DessertDetailsDTO.strIngredient11, \DessertDetailsDTO.strMeasure11),
                (\DessertDetailsDTO.strIngredient12, \DessertDetailsDTO.strMeasure12),
                (\DessertDetailsDTO.strIngredient13, \DessertDetailsDTO.strMeasure13),
                (\DessertDetailsDTO.strIngredient14, \DessertDetailsDTO.strMeasure14),
                (\DessertDetailsDTO.strIngredient15, \DessertDetailsDTO.strMeasure15),
                (\DessertDetailsDTO.strIngredient16, \DessertDetailsDTO.strMeasure16),
                (\DessertDetailsDTO.strIngredient17, \DessertDetailsDTO.strMeasure17),
                (\DessertDetailsDTO.strIngredient18, \DessertDetailsDTO.strMeasure18),
                (\DessertDetailsDTO.strIngredient19, \DessertDetailsDTO.strMeasure19),
                (\DessertDetailsDTO.strIngredient20, \DessertDetailsDTO.strMeasure20)
            ]

            // Step 2. Create the array of ingredients
            var ingredients = [DessertDetails.Ingredient]()

            // Step 3. Fill the ingredients/measures in the ingredients array and sift out any ingredients/measures that are nil or empty (ie. "")
            for ingredientTuple in ingredientTuples {
                guard
                    let ingredient = dessertDetailsDTO[keyPath: ingredientTuple.0],
                    !ingredient.isEmpty
                else {
                    continue
                }

                // Sometimes measure stores " " rather than "", so if an igredient has no measure then it will store " " or ""
                let measure = dessertDetailsDTO[keyPath: ingredientTuple.1] ?? ""

                ingredients.append(DessertDetails.Ingredient(name: ingredient, measure: measure))
            }

            return ingredients
        }

        return DessertDetails(id: dessertDetailsDTO.idMeal, name: dessertDetailsDTO.strMeal, instructions: instructions, ingredients: ingredients)
    }

    ///  Get the image data from the url
    func getImage(from url: URL) async throws -> Image {
        try await imageCache.getImage(from: url)
    }
}
