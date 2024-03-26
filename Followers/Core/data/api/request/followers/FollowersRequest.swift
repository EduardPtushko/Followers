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
        case let .getFollowers(username, _):
            "/users/\(username)/followers"
        }
    }

    var requestType: RequestType { .GET }

    var urlParams: [String: String?] {
        switch self {
        case let .getFollowers(_, page):
            ["per_page": "100", "page": String(page)]
        }
    }
}
