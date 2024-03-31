//
//  AddingFavoriteServiceMock.swift
//  Followers
//
//  Created by Eduard Ptushko on 31.03.2024.
//

import Foundation

struct AddingFavoriteServiceMock: AddFavorite {
    func getUserInfo(for username: String) async throws -> User {
        User.mockUser
    }
}
