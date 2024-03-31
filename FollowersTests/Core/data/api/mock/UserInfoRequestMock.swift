//
//  UserInfoRequestMock.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 27.03.2024.
//

@testable import Followers
import Foundation

enum UserInfoRequestMock: RequestProtocol {
    case getUserInfo(username: String)

    var path: String {
        switch self {
        case let .getUserInfo(username):
            String(decoding: testUser, as: UTF8.self)
        }
    }

    var requestType: RequestType { .GET }
}
