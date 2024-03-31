//
//  FollowersRequestMock.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 27.03.2024.
//

@testable import Followers
import Foundation

enum FollowersRequestMock: RequestProtocol {
    case getFollowers(username: String, page: Int)

    var path: String {
        switch self {
        case let .getFollowers(username, _):
            String(decoding: testDataFollowers, as: UTF8.self)
        }
    }

    var requestType: RequestType { .GET }
}
