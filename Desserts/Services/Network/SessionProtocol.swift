//
//  SessionProtocol.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/10/24.
//

import Foundation

/// A protocol to allow for mocking URLSession in tests. URLSession conforms to this protocol.
protocol Session {
    func data(from url: URL) async throws -> (Data, URLResponse)
}
