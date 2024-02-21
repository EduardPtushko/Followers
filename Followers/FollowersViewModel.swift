//
//  FollowersViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import Foundation

@Observable
final class FollowersViewModel {
    let networkManager = NetworkManager.shared
    var followers: [Follower] = []
    var error: String?

    func getFollowers(username: String) async {
        do {
            self.followers = try await networkManager.getFollowers(for: username, page: 1)
        } catch {
            self.error = error.localizedDescription
        }
    }


}
