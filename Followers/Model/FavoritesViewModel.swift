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
    var lastAlertMessage = "None" {
        didSet {
            isDisplayingAlert = true
        }
    }

    var isDisplayingAlert = false
    var alertTitle = "Something went wrong"

    @MainActor
    func getFavorites() {
        do {
            let favorites = try PersistenceManager.retrieveFavorites()
            self.favorites = favorites
        } catch {
            lastAlertMessage = lastAlertMessage
            alertTitle = "Something went wrong"
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
            lastAlertMessage = lastAlertMessage
            alertTitle = "Unable to remove"
        }
    }
}
