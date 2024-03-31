//
//  FollowersViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.02.2024.
//

import SwiftUI

protocol FollowersFetcher {
    func fetchFollowers(for username: String, page: Int) async throws -> [Follower]
}

@Observable
final class FollowersViewModel {
    private let followersService: FollowersFetcher
    private(set) var followers: [Follower] = []
    private(set) var page = 1
    private(set) var hasMoreFollowers = true
    private(set) var isLoading: Bool
    var searchText = ""

    var error: FollowersError? {
        didSet {
            if error != nil {
                showingAlert = true
            }
        }
    }

    var showingAlert = false
    var filteredFollowers: [Follower] {
        if searchText.isEmpty {
            return followers
        } else {
            return followers.filter { $0.login.localizedCaseInsensitiveContains(searchText) }
        }
    }

    init(isLoading: Bool = true, followersService: FollowersFetcher) {
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
        } catch let error as NetworkError {
            self.error = FollowersError.networkError(error)
        } catch {
            if let error = error as? FollowersError {
                self.error = error
            } else {
                self.error = FollowersError.unexpectedError
            }
        }
        isLoading = false
    }

    func getMoreFollowers(username: String) async {
        page += 1
        await getFollowers(username: username)
    }

    @MainActor
    func reset() {
        followers.removeAll()
        page = 1
        hasMoreFollowers = true
        searchText = ""
        error = nil
    }
}
