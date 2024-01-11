//
//  DessertsTests.swift
//  DessertsTests
//
//  Created by Jonathan Paul on 1/10/24.
//

import XCTest
@testable import Desserts

final class NetworkServiceTests: XCTestCase {
    private let url = URL(string: "https://youtube.com")!

    /// In fetchAndDecode(from:), test that when given a good URL and [Dessert] as the return type the function returns the expected value
    func testFetchAndDecode() {

    }

    /// In getImageData(from:), test that when URLSession.shared.data(from: url) throws an error getImageData(from:) throws a NetworkException.unableToComplete error
    func testGetImageDataGetsURLAndReturnsData() async {
        // Given
        let data = UIImage(resource: .test).pngData()!
        let expectedResult = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!)
        let mockSession = URLSessionMock(expectedResult: expectedResult)
        let sut = DefaultNetworkService(session: mockSession)

        // When
        let response = try? await sut.getImageData(from: url)

        // Then
        guard let response else {
            XCTFail("Response is nil, but should contain data.")
            return
        }
        XCTAssertEqual(response, data)
    }

    /// In getImageData(from:), test that when URLSession.shared.data(from: url) throws an error getImageData(from:) throws a NetworkException.unableToComplete error
    func testBadGetImageDataRequestToURLSessionThrowsUnableToComplete() async {
        // Given
        let mockSession = URLSessionMock(shouldThrow: true)
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: Error? = nil
        do {
            _ = try await sut.getImageData(from: url)
        } catch {
            caughtError = error
        }

        // Then
        guard let error = caughtError as? NetworkException else {
            XCTFail("error should be a NetworkException.")
            return
        }
        XCTAssertEqual(error, .unableToComplete)
    }

    /// In getImageData(from:), test that when the response is not 200 getImageData(from:) throws a NetworkException.invalidResponse error
    func testGetImageDataGetsBadHTTPCodeAndThrowsInvalidResponse() async {
        // Given
        let statusCode = 404
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        let expectedResult = (Data(), response)
        let mockSession = URLSessionMock(expectedResult: expectedResult)
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: NetworkException?
        do {
            _ = try await sut.getImageData(from: url)
        } catch {
            caughtError = error as? NetworkException
        }

        // Then
        guard let caughtError else {
            XCTFail("error should no be nil.")
            return
        }
        XCTAssertEqual(caughtError, .invalidResponse)
    }
}
