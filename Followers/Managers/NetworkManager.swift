//
//  NetworkManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import Foundation

let validStatus = 200...299

class NetworkManager {
    static var shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"

    private init() {}

    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endpoint) else {
            throw NetworkErrors.invalidURL
        }

        guard let (data, response) = try await URLSession.shared.data(from: url) as? (Data, HTTPURLResponse), validStatus.contains(response.statusCode) else {
            throw NetworkErrors.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let followers = try decoder.decode([Follower].self, from: data)
            return followers
        } catch {
            throw NetworkErrors.invalidData
        }


    }
}


enum NetworkErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

extension NetworkErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("This username created an invalid request. Please try again.", comment: "invalid request error description")
        case .invalidResponse:
            return NSLocalizedString("Invalid response from the server. Please try again.", comment: "invalid response error description")
        case .invalidData:
            return NSLocalizedString("The data received from the server was invalid. Please try again.", comment: "invalid data error description")
        }

        }
}

