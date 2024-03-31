//
//  FavoritesViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 27.02.2024.
//

import SwiftUI

@Observable
final class FavoritesViewModel {
    private(set) var persistenceManager: PersistenceManagerProtocol
    var favorites: [Follower] = []

    var followersError: FollowersError? {
        didSet {
            if followersError != nil {
                showingAlert = true
            }
        }
    }

    var showingAlert = false

    init(
        persistenceManager: PersistenceManagerProtocol = PersistenceManager(),
        favorites: [Follower] = [],
        followersError: FollowersError? = nil,
        showingAlert: Bool = false
    ) {
        self.persistenceManager = persistenceManager
        self.favorites = favorites
        self.followersError = followersError
        self.showingAlert = showingAlert
    }

    @MainActor
    func getFavorites() {
        do {
            let favorites = try persistenceManager.retrieveFavorites()
            self.favorites = favorites
        } catch {
            if let error = error as? FollowersError {
                followersError = error
            } else {
                followersError = .unexpectedError
            }
        }
    }

    @MainActor
    func deleteFavorite(offsets: IndexSet) {
        do {
            for index in offsets {
                try persistenceManager.updateWith(favorite: favorites[index], actionType: .remove)
            }
            favorites.remove(atOffsets: offsets)
        } catch {
            if let error = error as? FollowersError {
                followersError = error
            } else {
                followersError = .unexpectedError
            }
        }
    }
}
