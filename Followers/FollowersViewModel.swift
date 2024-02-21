//
//  FollowersViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import Foundation

@Observable
final class FollowersViewModel {
    let networkManager: NetworkManagerProtocol
    var followers: [Follower] = []
    var error: String?
    var page = 0
    var hasMoreFollowers = true

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func getFollowers(username: String) async {
        do {
            page += 1
            
            let followers = try await networkManager.getFollowers(for: username, page: page)
            if followers.count < 100  { self.hasMoreFollowers = false }
            self.followers.append(contentsOf: followers)
        } catch {
            self.error = error.localizedDescription
        }
    }

}
