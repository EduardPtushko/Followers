//
//  UserInfoRequest.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

enum UserInfoRequest: RequestProtocol {
    case getUserInfo(username: String)

    var path: String {
        switch self {
        case let .getUserInfo(username):
            "/users/\(username)"
        }
    }

    var requestType: RequestType { .GET }
}
