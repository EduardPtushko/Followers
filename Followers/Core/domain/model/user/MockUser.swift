//
//  MockUser.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

#if DEBUG
extension User {
    static var mockUser: User {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        let user = try! decoder.decode(User.self, from: testUser)

        return user
    }
}
#endif
