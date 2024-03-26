//
//  FollowersViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import SwiftUI

protocol FollowersServiceProtocol {
    func fetchFollowers(for username: String, page: Int) async throws -> [Follower]
    func getUserInfo(for username: String) async throws -> User
}

@Observable
final class FollowersViewModel {
    enum State: Equatable {
        case loading
        case loaded
        case error
    }

    private let followersService: FollowersServiceProtocol

    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var state: State = .loading
    var isLoading: Bool

    var filteredFollowers: [Follower] {
        if searchText.isEmpty {
            return followers
        } else {
            return followers.filter { $0.login.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var error: Error?
    var showingSuccess = false

    var searchText = ""

    init(isLoading: Bool = true, followersService: FollowersServiceProtocol) {
        self.isLoading = isLoading
        self.followersService = followersService
    }

    @MainActor
    func getFollowers(username: String) async {
        isLoading = true
        do {
            let followers = try await followersService.fetchFollowers(for: username, page: page)
            if followers.count < 100 { hasMoreFollowers = false }
            self.followers.append(contentsOf: followers)

        } catch is NetworkError {
            self.error = error
        } catch {
            self.error = error as? FollowersError
        }
        isLoading = false
    }

    func getMoreFollowers(username: String) async {
        page += 1
        await getFollowers(username: username)
    }

    @MainActor
    func addFavorite(username: String) async {
        do {
            let user = try await followersService.getUserInfo(for: username)
            let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
            try PersistenceManager.updateWith(favorite: favorite, actionType: .add)
            showingSuccess = true
        } catch {
            self.error = error as? FollowersError
        }
    }

    @MainActor
    func reset() {
        state = .loading
        followers.removeAll()
        page = 1
        hasMoreFollowers = true
        searchText = ""
        error = nil
    }
}
