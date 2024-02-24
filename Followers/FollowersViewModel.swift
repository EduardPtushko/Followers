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
    var isLoading = false
    var isEmptyView = false

    var searchText = ""

    var filteredFollowers: [Follower] {
        if searchText.isEmpty {
           return followers
        } else {
            return followers.filter { $0.login.localizedCaseInsensitiveContains(searchText)}
        }
    }

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func getFollowers(username: String) async {
        isLoading = true

        defer { isLoading = false }
        do {
            page += 1
            
            let followers = try await networkManager.getFollowers(for: username, page: page)

            if followers.count < 100  { self.hasMoreFollowers = false }
            self.followers.append(contentsOf: followers)
            if self.followers.isEmpty {
                isEmptyView = true
            }
        } catch {
            self.error = error.localizedDescription
        }
    }

}
