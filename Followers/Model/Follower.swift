//
//  Follower.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import Foundation

struct Follower {
    var login: String
    var avatarUrl: String
}

extension Follower: Codable {}
