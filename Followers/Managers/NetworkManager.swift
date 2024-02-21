//
//  NetworkManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import UIKit

let validStatus = 200...299

class NetworkManager {
    static var shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()

    let baseURL = "https://api.github.com/users/"

    private init() {}

    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidUsername
        }

        guard let (data, response) = try await URLSession.shared.data(from: url) as? (Data, HTTPURLResponse), validStatus.contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let followers = try decoder.decode([Follower].self, from: data)
            return followers
        } catch {
            throw NetworkError.invalidData
        }
    }
}



