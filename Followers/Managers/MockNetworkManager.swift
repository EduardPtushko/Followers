//
//  MockNetworkManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 21.02.2024.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    func getFollowers(for _: String, page _: Int) async throws -> [Follower] {
        try await Task.sleep(nanoseconds: 2000000000)

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let followers = try decoder.decode([Follower].self, from: testDataFollowers)

            return followers
        } catch {
            throw FollowersError.invalidData
        }
    }
}
