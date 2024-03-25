//
//  MockNetworkManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 21.02.2024.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    var mockData: Data?
    var mockError: FollowersError?

    func getUserInfo(for username: String) async throws -> User {
        User.mockUser
    }

    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        if let mockError { throw mockError }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let followers = try decoder.decode([Follower].self, from: mockData ?? testDataFollowers)

            return followers
        } catch {
            throw FollowersError.invalidData
        }
    }
}
