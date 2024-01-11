//
//  DessertsDTO.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import Foundation

struct DessertsDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case desserts = "meals"
    }
    let desserts: [Dessert]
}
