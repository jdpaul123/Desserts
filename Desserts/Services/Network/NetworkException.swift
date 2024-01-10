//
//  NetworkException.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/10/24.
//

import Foundation

enum NetworkException: Error, LocalizedError {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case badIndex

    /// Log this message to console
    var errorDescription: String? {
        switch self {
        case .invalidURL: "This URL created an invalid request."
        case .unableToComplete: "Unable to complete the request. Probable internet connection problem."
        case .invalidResponse: "Invalid response from the server."
        case .invalidData: "The data received from the server was invalid."
        case .badIndex: "The data received from the server was invalid"
        }
    }

    /// Display this message to user
    var userMessage: String {
        switch self {
        case .invalidURL: "There was an error. Please try again."
        case .unableToComplete: "Unable to complete your request. Please check your internet connection."
        case .invalidResponse: "There was an error. Please try again."
        case .invalidData: "There was an error. Please try again."
        case .badIndex: "There was an error. Please try again."
        }
    }
}
