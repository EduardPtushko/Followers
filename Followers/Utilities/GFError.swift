//
//  GFError.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUsername
    case unableToComplete
    case invalidResponse
    case invalidData
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUsername:
            return NSLocalizedString("This username created an invalid request. Please try again.", comment: "invalid username error description")
        case .invalidResponse:
            return NSLocalizedString("Invalid response from the server. Please try again.", comment: "invalid response error description")
        case .invalidData:
            return NSLocalizedString("The data received from the server was invalid. Please try again.", comment: "invalid data error description")
        case .unableToComplete:
            return NSLocalizedString("Unable to complete your request. Please check your internet connection", comment: "unable to complete error description")
        }

    }
}
