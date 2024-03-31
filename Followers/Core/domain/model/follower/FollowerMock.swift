//
//  FollowerMock.swift
//  Followers
//
//  Created by Eduard Ptushko on 31.03.2024.
//

import Foundation

private struct FollowersMock: Codable {
    let followers: [Follower]
}

extension Follower {
    static var mockFollowers: [Follower] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        let followers = try? decoder.decode([Follower].self, from: testDataFollowers)

        return followers ?? []
    }
}
