//
//  NetworkManager.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import Foundation

protocol NetworkService: AnyObject {
    func getDesserts() async throws -> [Dessert]
    func getDessertDetails(for dessertID: String) async throws -> DessertDetailsDTO
    func getImageData(from url: URL) async throws -> Data
}

final class DefaultNetworkService: NetworkService {
    private let baseURLString = "https://themealdb.com/api/json/v1/1/"

    func getDesserts() async throws -> [Dessert] {
        let endpoint = "\(baseURLString)filter.php?c=Dessert"

        let response: DessertsDTO = try await fetchAndDecode(from: endpoint)
        return response.desserts
    }

    func getDessertDetails(for dessertID: String) async throws -> DessertDetailsDTO {
        let endpoint = "\(baseURLString)lookup.php?i=\(dessertID)"
        let dessertDetailsWrapperDTO: DessertDetailsWrapperDTO = try await fetchAndDecode(from: endpoint)

        guard let dessert = dessertDetailsWrapperDTO.meals.first else {
            throw NetworkException.badIndex
        }
        return dessert
    }

    /// Generic function to decode JSON data
    private func fetchAndDecode<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkException.invalidURL
        }

        let decodedData: T
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkException.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                decodedData = try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkException.invalidData
            }
        } catch {
            throw NetworkException.unableToComplete
        }

        return decodedData
    }

    /// Get image data and ignore the response or error
    func getImageData(from url: URL) async throws -> Data {
        let imageData: Data
        let response: URLResponse
        do {
            (imageData, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkException.invalidResponse
            }
        } catch {
            throw NetworkException.unableToComplete
        }
        return imageData
    }
}
