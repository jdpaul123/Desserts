//
//  DataService.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import Foundation

class DataService {
    // TODO: Pass in the NetworkService so that we can pass in a mock to get local assets and data for testing
    static let shared = DataService()

    func getDesserts() async throws -> [Dessert] {
        var desserts: [Dessert]
        do {
            desserts = try await NetworkService.shared.getDesserts()
        } catch {
            throw error
        }

        // Sort the desserts by name alphabetically
        desserts.sort { $0.name < $1.name }

        return desserts
    }

    func getDessertDetails(for dessertID: String) async throws -> DessertDetails {
        let dessertDetailsDTO: DessertDetailsDTO
        do {
            dessertDetailsDTO = try await NetworkService.shared.getDessertDetails(for: dessertID)
        } catch {
            throw error
        }

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

        var ingredients: [DessertDetails.Ingredient] {
            var ingredients = [DessertDetails.Ingredient]()

            // When the JSON does not have an ingredient at one of the 20 ingredient properties the api either has an empty pair of quotes or null value
            // This standardizes the empty properties such that every property with no value will store empty quotes
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient1 ?? "", measure: dessertDetailsDTO.strMeasure1 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient2 ?? "", measure: dessertDetailsDTO.strMeasure2 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient3 ?? "", measure: dessertDetailsDTO.strMeasure3 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient4 ?? "", measure: dessertDetailsDTO.strMeasure4 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient5 ?? "", measure: dessertDetailsDTO.strMeasure5 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient6 ?? "", measure: dessertDetailsDTO.strMeasure6 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient7 ?? "", measure: dessertDetailsDTO.strMeasure7 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient8 ?? "", measure: dessertDetailsDTO.strMeasure8 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient9 ?? "", measure: dessertDetailsDTO.strMeasure9 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient10 ?? "", measure: dessertDetailsDTO.strMeasure10 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient11 ?? "", measure: dessertDetailsDTO.strMeasure11 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient12 ?? "", measure: dessertDetailsDTO.strMeasure12 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient13 ?? "", measure: dessertDetailsDTO.strMeasure13 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient14 ?? "", measure: dessertDetailsDTO.strMeasure14 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient15 ?? "", measure: dessertDetailsDTO.strMeasure15 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient16 ?? "", measure: dessertDetailsDTO.strMeasure16 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient17 ?? "", measure: dessertDetailsDTO.strMeasure17 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient18 ?? "", measure: dessertDetailsDTO.strMeasure18 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient19 ?? "", measure: dessertDetailsDTO.strMeasure19 ?? ""))
            ingredients.append(DessertDetails.Ingredient(name: dessertDetailsDTO.strIngredient20 ?? "", measure: dessertDetailsDTO.strMeasure20 ?? ""))

            // Now remove any ingredients that contain empty strings
            ingredients.removeAll(where: { $0.name == "" })

            return ingredients
        }
        return DessertDetails(id: dessertDetailsDTO.idMeal, name: dessertDetailsDTO.strMeal, instructions: instructions, ingredients: ingredients)
    }

    func getImageData(from url: URL) async -> Data? {
        await NetworkService.shared.getImageData(from: url)
    }
}
