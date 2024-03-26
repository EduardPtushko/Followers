//
//  GetUserInfoService.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

actor GetUserInfoService {
    private let requestManager: RequestManager

    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
}

extension GetUserInfoService: UserInfoFetcher {
    func fetchUserInfo(username: String) async throws -> User {
        let requestData = UserInfoRequest.getUserInfo(username: username)
        let user: User = try await requestManager.initRequest(with: requestData)
        return user
    }
}
