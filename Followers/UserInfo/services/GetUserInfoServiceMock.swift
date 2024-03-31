//
//  GetUserInfoServiceMock.swift
//  Followers
//
//  Created by Eduard Ptushko on 31.03.2024.
//

import Foundation

struct GetUserInfoServiceMock: UserInfoFetcher {
    func fetchUserInfo(username: String) async throws -> User {
        User.mockUser
    }
}
