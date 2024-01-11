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

    // MARK: Test Get Desserts
    /// In getDesserts(from:), test that the function works
    func testGetDesserts_WhenGivenGoodDataAndNetworkResponse_ReturnsExpectedData() async {
        // Given
        let expectedResult = NetworkServiceTestsStub.shared.desserts

        let data = try! JSONEncoder().encode(NetworkServiceTestsStub.shared.dessertsDTO)
        let mockSession = URLSessionMock(expectedResult: (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!))
        let sut = DefaultNetworkService(session: mockSession)

        // When
        let response = try! await sut.getDesserts()

        // Then
        XCTAssertEqual(response, expectedResult)
    }

    func testGetDesserts_WhenBadHTTPStatusCode_ThrowsInvalidResponse() async {
        // Given
        let data = try! JSONEncoder().encode(NetworkServiceTestsStub.shared.dessertsDTO)
        let statusCode = 201
        let mockSession = URLSessionMock(expectedResult: (data, HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!))
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: NetworkException?
        do {
            _ = try await sut.getDesserts()
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

    func testGetDesserts_WhenSessionThrowsError_ThrowsUnableToCompleteError() async {
        // Given
        let mockSession = URLSessionMock(shouldThrow: true)
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: NetworkException?
        do {
            _ = try await sut.getDesserts()
        } catch {
            caughtError = error as? NetworkException
        }

        // Then
        guard let caughtError else {
            XCTFail("error should no be nil.")
            return
        }
        XCTAssertEqual(caughtError, .unableToComplete)
    }

    func testGetDesserts_WhenDecoderFails_ThrowsInvalidDataError() async {
        // Given
        let data = Data() // Give bad data so decoder cannot decode the data into a DessertsDTO object
        let mockSession = URLSessionMock(expectedResult: (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!))
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: NetworkException?
        do {
            _ = try await sut.getDesserts()
        } catch {
            caughtError = error as? NetworkException
        }

        // Then
        guard let caughtError else {
            XCTFail("error should no be nil.")
            return
        }
        XCTAssertEqual(caughtError, .invalidData)
    }

    // MARK: Test Get Dessert Details
    /// In getDesserts(from:), test that the function works
    func testGetDessertDetails_WhenGivenGoodDataAndNetworkResponse_ReturnsExpectedData() async {
        // Given
        let expectedResult = NetworkServiceTestsStub.shared.dessertDetailsDTO

        let data = try! JSONEncoder().encode(NetworkServiceTestsStub.shared.dessertDetailsWrapperDTO)
        let mockSession = URLSessionMock(expectedResult: (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!))
        let sut = DefaultNetworkService(session: mockSession)

        // When
        let response = try! await sut.getDessertDetails(for: UUID().uuidString)

        // Then
        XCTAssertEqual(response, expectedResult)
    }

    func testGetDessertDetails_WhenTheDessertDetailsWrapperDTOIsEmpty_ThrowsBadIndex() async {
        // Given
        let data = try! JSONEncoder().encode(NetworkServiceTestsStub.shared.emptyDessertDetailsWrapperDTO)
        let mockSession = URLSessionMock(expectedResult: (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!))
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: NetworkException?
        do {
            _ = try await sut.getDessertDetails(for: UUID().uuidString)
        } catch {
            caughtError = error as? NetworkException
        }

        // Then
        XCTAssertEqual(caughtError, .badIndex)
    }

    func testGetDessertDetails_WhenBadHTTPStatusCode_ThrowsInvalidResponse() async {
        // Given
        let data = try! JSONEncoder().encode(NetworkServiceTestsStub.shared.dessertDetailsDTO)
        let statusCode = 201
        let mockSession = URLSessionMock(expectedResult: (data, HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!))
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: NetworkException?
        do {
            _ = try await sut.getDessertDetails(for: UUID().uuidString)
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

    func testGetDessertDetails_WhenSessionThrowsError_ThrowsUnableToCompleteError() async {
        // Given
        let mockSession = URLSessionMock(shouldThrow: true)
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: NetworkException?
        do {
            _ = try await sut.getDessertDetails(for: UUID().uuidString)
        } catch {
            caughtError = error as? NetworkException
        }

        // Then
        guard let caughtError else {
            XCTFail("error should no be nil.")
            return
        }
        XCTAssertEqual(caughtError, .unableToComplete)
    }

    func testGetDessertDetails_WhenDecoderFails_ThrowsInvalidDataError() async {
        // Given
        let data = Data() // Give bad data so decoder cannot decode the data into a DessertsDTO object
        let mockSession = URLSessionMock(expectedResult: (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!))
        let sut = DefaultNetworkService(session: mockSession)

        // When
        var caughtError: NetworkException?
        do {
            _ = try await sut.getDessertDetails(for: UUID().uuidString)
        } catch {
            caughtError = error as? NetworkException
        }

        // Then
        guard let caughtError else {
            XCTFail("error should no be nil.")
            return
        }
        XCTAssertEqual(caughtError, .invalidData)
    }

    // MARK: Test Get Image Data
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
        XCTAssertEqual(caughtError, .unableToComplete)
    }

    /// In getImageData(from:), test that when the response is not 200 getImageData(from:) throws a NetworkException.invalidResponse error
    func testGetImageDataGetsBadHTTPCodeAndThrowsInvalidResponse() async {
        // Given
        let statusCode = 201
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
