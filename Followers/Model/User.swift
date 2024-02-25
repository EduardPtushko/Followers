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
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}

extension User: Codable {}

extension User {
    static var sampleUser: User {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let user = try! decoder.decode(User.self, from: testUser)

        return user
    }
}
