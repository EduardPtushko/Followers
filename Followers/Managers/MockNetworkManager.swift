//
//  MockNetworkManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 21.02.2024.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {

    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
       try await Task.sleep(nanoseconds: 2_000_000_000)

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let followers = try decoder.decode([Follower].self, from: testDataFollowers)

            return followers
        } catch {
            throw NetworkError.invalidData
        }
    }

}
