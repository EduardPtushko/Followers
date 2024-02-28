//
//  FollowersViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import SwiftUI

@Observable
final class FollowersViewModel {
    let networkManager: NetworkManagerProtocol
    var followers: [Follower] = []
    var page = 0
    var hasMoreFollowers = true
    var viewState: StateOfView = .empty

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

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func getFollowers(username: String) async {
        viewState = .loading
        do {
            page += 1

            let followers = try await networkManager.getFollowers(for: username, page: page)
            if followers.count < 100 { hasMoreFollowers = false }
            self.followers.append(contentsOf: followers)

            if self.followers.isEmpty {
                viewState = .emptyState
                return
            }

            viewState = .gridView
        } catch {
            viewState = .empty
            lastAlertMessage = error.localizedDescription
        }
    }

    func addFavorite(username: String) {
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                try PersistenceManager.updateWith(favorite: favorite, actionType: .add)

                lastAlertMessage = "You have successfully favorited this user"
                alertTitle = "Success!"
            } catch {
                lastAlertMessage = error.localizedDescription
                alertTitle = "Something went wrong"
            }
        }
    }

    func reset() {
        viewState = .empty
        followers.removeAll()
        page = 0
        hasMoreFollowers = true
        searchText = ""
        lastAlertMessage = "None"
        isDisplayingAlert = false
    }

    enum StateOfView {
        case loading
        case emptyState
        case gridView
        case empty
    }
}
