//
//  FollowersViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import SwiftUI

@Observable
final class FollowersViewModel {
    enum State {
        case loading
        case loaded(followers: [Follower])
        case error
    }

    let networkManager: NetworkManagerProtocol

    var followers: [Follower] = []
    var page = 0
    var hasMoreFollowers = true
    var state = State.loading

    var lastAlertMessage = "None" {
        didSet {
            isDisplayingAlert = true
        }
    }

    var isDisplayingAlert = false
    var alertTitle = "Something went wrong"

    var searchText = ""

    var filteredFollowers: [Follower] {
        if searchText.isEmpty {
            return followers
        } else {
            return followers.filter { $0.login.localizedCaseInsensitiveContains(searchText) }
        }
    }

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    @MainActor
    func getFollowers(username: String) async {
        state = .loading
        do {
            page += 1

            let followers = try await networkManager.getFollowers(for: username, page: page)
            if followers.count < 100 { hasMoreFollowers = false }
            self.followers.append(contentsOf: followers)

            state = .loaded(followers: followers)
        } catch {
            page -= 1
            state = .error
            lastAlertMessage = error.localizedDescription
        }
    }

    func addFavorite(username: String) {
        Task {
            do {
                let user = try await networkManager.getUserInfo(for: username)
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                try PersistenceManager.updateWith(favorite: favorite, actionType: .add)
                await MainActor.run {
                    lastAlertMessage = "You have successfully favorited this user"
                    alertTitle = "Success!"
                }
            } catch {
                await MainActor.run {
                    lastAlertMessage = error.localizedDescription
                    alertTitle = "Something went wrong"
                }
            }
        }
    }

    @MainActor
    func reset() {
        state = .loading
        followers.removeAll()
        page = 0
        hasMoreFollowers = true
        searchText = ""
        lastAlertMessage = "None"
        isDisplayingAlert = false
    }
}
