//
//  User.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import Foundation

struct User {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}

extension User: Codable {}
