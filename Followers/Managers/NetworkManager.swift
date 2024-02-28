//
//  NetworkManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import UIKit

let validStatus = 200...299

protocol NetworkManagerProtocol {
    func getFollowers(for username: String, page: Int) async throws -> [Follower]
}

actor NetworkManager: NetworkManagerProtocol {
    static var shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()

    let baseURL = "https://api.github.com/users/"

    private init() {}

    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endpoint) else {
            throw FollowersError.invalidUsername
        }

        guard let (data, response) = try await URLSession.shared.data(from: url) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode)
        else {
            throw FollowersError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let followers = try decoder.decode([Follower].self, from: data)
            return followers
        } catch {
            throw FollowersError.invalidData
        }
    }

    func getUserInfo(for username: String) async throws -> User {
        let endpoint = baseURL + "\(username)"

        guard let url = URL(string: endpoint) else {
            throw FollowersError.invalidUsername
        }

        guard let (data, response) = try await URLSession.shared.data(from: url) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode)
        else {
            throw FollowersError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601

            return try decoder.decode(User.self, from: data)
        } catch {
            throw FollowersError.invalidData
        }
    }
}
