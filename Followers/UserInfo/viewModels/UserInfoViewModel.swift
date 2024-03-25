//
//  UserInfoViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 24.02.2024.
//

import Foundation

@Observable
final class UserInfoViewModel {
    let networkManager: NetworkManagerProtocol
    var user: User?

    var followersError: Error? {
        didSet {
            if followersError != nil {
                showingAlert = true
            }
        }
    }

    var showingAlert = false

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    @MainActor
    func getUser(username: String) async {
        do {
            let user = try await networkManager.getUserInfo(for: username)
            self.user = user
        } catch {
            followersError = error
        }
    }
}
