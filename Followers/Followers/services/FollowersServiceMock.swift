//
//  FollowersServiceMock.swift
//  Followers
//
//  Created by Eduard Ptushko on 31.03.2024.
//

import Foundation

struct FollowersServiceMock: FollowersFetcher {
    func fetchFollowers(for username: String, page: Int) async throws -> [Follower] {
        Follower.mockFollowers
    }
}
