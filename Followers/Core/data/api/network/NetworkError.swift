//
//  NetworkError.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidServerResponse
    case invalidURL
    case invalidData

    var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            "The server returned an invalid response. Please try again."
        case .invalidURL:
            "URL string is malformed."
        case .invalidData:
            "The data received from the server was invalid. Please try again."
        }
    }
}
