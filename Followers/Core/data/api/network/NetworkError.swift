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

    var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .invalidURL:
            return "URL string is malformed."
        }
    }
}
