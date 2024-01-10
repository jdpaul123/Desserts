//
//  NetworkManager.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//
// TODO: Turn this into an instantiated object that conforms to a protocol so that we can simulate network calls for testing and previews

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private let baseURLString = "https://themealdb.com/api/json/v1/1/"

    func getDesserts() async throws -> [Dessert] {
        let endpoint = "\(baseURLString)filter.php?c=Dessert"
        let desserts: DessertsDTO

        do {
            desserts = try await decode(from: endpoint)
        } catch {
            throw error
        }

        return desserts.desserts
    }

    func getDessertDetails(for dessertID: String) async throws -> DessertDetailsDTO {
        let endpoint = "\(baseURLString)lookup.php?i=\(dessertID)"
        let dessertDetailsWrapperDTO: DessertDetailsWrapperDTO

        do {
            dessertDetailsWrapperDTO = try await decode(from: endpoint)
        } catch {
            throw error
        }

        return dessertDetailsWrapperDTO.meals[0]
    }

    /// Generic function to decode JSON data
    private func decode<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw ErrorMessage.invalidURL
        }

        let decodedData: T
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ErrorMessage.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                decodedData = try decoder.decode(T.self, from: data)
            } catch {
                throw ErrorMessage.invalidData
            }
        } catch {
            throw ErrorMessage.unableToComplete
        }

        return decodedData
    }

    /// Get image data and ignore the response or error
    func getImageData(from url: URL) async -> Data? {
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
