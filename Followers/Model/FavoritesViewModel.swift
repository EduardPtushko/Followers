//
//  FavoritesViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 27.02.2024.
//

import SwiftUI

@Observable
final class FavoritesViewModel {
    var favorites: [Follower] = []
    var followersError: FollowersError? {
        didSet {
            if followersError != nil {
                showingAlert = true
            }
        }
    }

    var showingAlert = false

    @MainActor
    func getFavorites() {
        do {
            let favorites = try PersistenceManager.retrieveFavorites()
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
                try PersistenceManager.updateWith(favorite: favorites[index], actionType: .remove)
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
