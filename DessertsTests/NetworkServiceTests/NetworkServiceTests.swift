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
        let mockNetworkService = URLSessionMock(expectedResult: expectedResult)
        let sut = DefaultNetworkService(session: mockNetworkService)

        // When
        let response = try? await sut.getImageData(from: url)

        // Then
        guard let response = response else { 
            XCTFail("Response is nil, but should contain data.")
            return
        }
        XCTAssertEqual(response, data)
    }

    /// In getImageData(from:), test that when URLSession.shared.data(from: url) throws an error getImageData(from:) throws a NetworkException.unableToComplete error
    func testGetImageDataRequestToURLSessionFailsAndThrows() {
    }

    /// In getImageData(from:), test that when the response is not 200 getImageData(from:) throws a NetworkException.invalidResponse error
    func testGetImageDataGetsBadResponseAndThrows() {
//    let badHTTPResponseCode = (Data(), HTTPURLResponse(url: URL(string: "https://youtube.com")!, statusCode: 201, httpVersion: nil, headerFields: nil))
    }
}
