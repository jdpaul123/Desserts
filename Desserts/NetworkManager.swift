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

        var dessertArray = [Dessert]()
        for dessert in desserts.desserts {
            dessertArray.append(dessert)
        }
        return dessertArray
    }

    func getDessertDetails(for dessertID: String) async throws -> DessertDetailsWrapperDTO {
        let endpoint = "\(baseURLString)lookup.php?i=\(dessertID)"
        guard let url = URL(string: endpoint) else {
            throw ErrorMessage.invalidURL
        }

        let dessertDetailsDTO: DessertDetailsWrapperDTO
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ErrorMessage.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                dessertDetailsDTO = try decoder.decode(DessertDetailsWrapperDTO.self, from: data)
            } catch {
                throw ErrorMessage.invalidData
            }
        } catch {
            throw ErrorMessage.unableToComplete
        }

        return dessertDetailsDTO
    }
}
