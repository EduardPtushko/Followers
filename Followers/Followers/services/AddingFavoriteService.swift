//
//  AddingFavoriteService.swift
//  Followers
//
//  Created by Eduard Ptushko on 26.03.2024.
//

import Foundation

actor AddingFavoriteService {
    private let requestManager: RequestManager

    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
}

extension AddingFavoriteService: AddFavorite {
    func getUserInfo(for username: String) async throws -> User {
        let requestData = UserInfoRequest.getUserInfo(username: username)
        let user: User = try await requestManager.initRequest(with: requestData)
        return user
    }
}
