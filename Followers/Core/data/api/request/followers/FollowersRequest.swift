//
//  FollowersRequest.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

enum FollowersRequest: RequestProtocol {
    case getFollowers(username: String, page: Int)

    var path: String {
        switch self {
        case let .getFollowers(username, page):
            "/users/\(username)/followers?per_page=100&page=\(page)"
        }
    }

    var requestType: RequestType { .GET }
}
