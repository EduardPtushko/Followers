//
//  PersistenceManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 26.02.2024.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static let defaults = UserDefaults.standard

    enum Keys {
        static let favorites = "favorites"
    }

    static func updateWith(favorite: Follower, actionType: PersistenceActionType) throws {
        var favorites = try retrieveFavorites()
        switch actionType {
        case .add:
            guard !favorites.contains(favorite) else {
                throw FollowersError.alreadyInFavorites
            }
            favorites.append(favorite)
        case .remove:
            favorites.removeAll(where: { $0.login == favorite.login })
        }

        try save(favorites: favorites)
    }

    static func retrieveFavorites() throws -> [Follower] {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            return []
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)

            return favorites
        } catch {
            throw FollowersError.unableToFavorite
        }
    }

    static func save(favorites: [Follower]) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(favorites)
        defaults.set(data, forKey: Keys.favorites)
    }
}
