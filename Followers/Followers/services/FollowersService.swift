//
//  FollowersService.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

actor FollowersService {
    private let requestManager: RequestManagerProtocol

    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension FollowersService: FollowersServiceProtocol {
    func fetchFollowers(for username: String, page: Int) async throws -> [Follower] {
        let requestData = FollowersRequest.getFollowers(username: username, page: page)
        let followers: [Follower] = try await requestManager.initRequest(with: requestData)

        return followers
    }

    func getUserInfo(for username: String) async throws -> User {
        let requestData = UserInfoRequest.getUserInfo(username: username)
        let user: User = try await requestManager.initRequest(with: requestData)
        return user
    }
}
