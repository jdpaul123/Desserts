//
//  NetworkServiceTestsStub.swift
//  DessertsTests
//
//  Created by Jonathan Paul on 1/11/24.
//

import Foundation
@testable import Desserts

extension NetworkServiceTests {
    struct NetworkServiceTestsStub {
        static let shared = NetworkServiceTestsStub()
        private let url = URL(string: "https://youtube.com")!

        let desserts: [Dessert]
        let dessertsDTO: DessertsDTO

        let dessertDetailsDTO: DessertDetailsDTO
        let dessertDetailsWrapperDTO: DessertDetailsWrapperDTO
        let emptyDessertDetailsWrapperDTO: DessertDetailsWrapperDTO

        init() {
            desserts = [
                Dessert(id: UUID().uuidString, name: UUID().uuidString, thumbnailURL: url),
                Dessert(id: UUID().uuidString, name: UUID().uuidString, thumbnailURL: url),
                Dessert(id: UUID().uuidString, name: UUID().uuidString, thumbnailURL: url),
                Dessert(id: UUID().uuidString, name: UUID().uuidString, thumbnailURL: url),
                Dessert(id: UUID().uuidString, name: UUID().uuidString, thumbnailURL: url),
                Dessert(id: UUID().uuidString, name: UUID().uuidString, thumbnailURL: url),
                Dessert(id: UUID().uuidString, name: UUID().uuidString, thumbnailURL: url),
                Dessert(id: UUID().uuidString, name: UUID().uuidString, thumbnailURL: url)
            ]

            dessertsDTO = DessertsDTO(desserts: desserts)

            dessertDetailsDTO = DessertDetailsDTO(idMeal: UUID().uuidString, strMeal: UUID().uuidString, strInstructions: UUID().uuidString,
                                                  strIngredient1: UUID().uuidString, strIngredient2: UUID().uuidString, strIngredient3: UUID().uuidString, strIngredient4: UUID().uuidString, strIngredient5: UUID().uuidString, strIngredient6: UUID().uuidString, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil,
                                                  strMeasure1: UUID().uuidString, strMeasure2: UUID().uuidString, strMeasure3: UUID().uuidString, strMeasure4: UUID().uuidString, strMeasure5: UUID().uuidString, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil)

            dessertDetailsWrapperDTO = DessertDetailsWrapperDTO(meals: [dessertDetailsDTO])
            emptyDessertDetailsWrapperDTO = DessertDetailsWrapperDTO(meals: [])
        }
    }
}
