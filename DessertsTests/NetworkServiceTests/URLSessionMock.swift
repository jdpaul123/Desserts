//
//  URLSessionMock.swift
//  DessertsTests
//
//  Created by Jonathan Paul on 1/10/24.
//

import Foundation
@testable import Desserts

extension NetworkServiceTests {
    final class URLSessionMock: Session {
        enum MockError: Error {
            case error
        }

        private let expectedResult: (Data, URLResponse)
        private let shouldThrow: Bool

        init(expectedResult: (Data, URLResponse), shouldThrow: Bool = false) {
            self.expectedResult = expectedResult
            self.shouldThrow = shouldThrow
        }

        func data(from url: URL) async throws -> (Data, URLResponse) {
            if shouldThrow {
                throw MockError.error
            }
            return expectedResult
        }
    }
}
