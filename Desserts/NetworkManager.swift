//
//  NetworkManager.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import Foundation

class NetworkManager {
    // TODO: Make a generic network function that getDesserts() and getDessertDetails() can use
    static let shared = NetworkManager()
    private let baseURLString = "https://themealdb.com/api/json/v1/1/"

    func getDesserts() async throws -> [Dessert] {
        let endpoint = "\(baseURLString)filter.php?c=Dessert"
        guard let url = URL(string: endpoint) else {
            throw ErrorMessage.invalidURL
        }

        let desserts: DessertsDTO
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ErrorMessage.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                desserts = try decoder.decode(DessertsDTO.self, from: data)
            } catch {
                throw ErrorMessage.invalidData
            }
        } catch {
            throw ErrorMessage.unableToComplete
        }

        // TODO: Factor this out into a data service
        var dessertArray = [Dessert]()
        for dessert in desserts.desserts {
            dessertArray.append(dessert)
        }
        return dessertArray
    }

    func getDessertDetails(for dessertID: String) async throws -> DessertDetails {
        let endpoint = "\(baseURLString)lookup.php?i=\(dessertID)"
        guard let url = URL(string: endpoint) else {
            throw ErrorMessage.invalidURL
        }

        let dessertDetailsWrapperDTO: DessertDetailsWrapperDTO
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ErrorMessage.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                dessertDetailsWrapperDTO = try decoder.decode(DessertDetailsWrapperDTO.self, from: data)
            } catch {
                throw ErrorMessage.invalidData
            }
        } catch {
            throw ErrorMessage.unableToComplete
        }


        // TODO: Factor this out into a data service
        let dessertDetailsDTO = dessertDetailsWrapperDTO.meals[0]

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

    func getImage(from url: URL) async -> Data? {
        let imageData: Data
        let response: URLResponse
        do {
            (imageData, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return nil
            }
        } catch {
            return nil
        }
        return imageData
    }
}
