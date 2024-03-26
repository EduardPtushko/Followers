//
//  UserInfoViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import Foundation

protocol UserInfoFetcher {
    func fetchUserInfo(username: String) async throws -> User
}

@Observable
final class UserInfoViewModel {
    var user: User?
    private let userInfoFetcher: UserInfoFetcher

    init(user: User? = nil, userInfoFetcher: UserInfoFetcher) {
        self.user = user
        self.userInfoFetcher = userInfoFetcher
    }

    var followersError: Error? {
        didSet {
            if followersError != nil {
                showingAlert = true
            }
        }
    }

    var showingAlert = false

    @MainActor
    func getUser(username: String) async {
        do {
            let user: User = try await userInfoFetcher.fetchUserInfo(username: username)
            self.user = user
        } catch {
            followersError = error
        }
    }
}
