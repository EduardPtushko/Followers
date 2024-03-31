//
//  AddFavoriteViewModel.swift
//  Followers
//
//  Created by Eduard Ptushko on 26.03.2024.
//

import Foundation

protocol AddFavorite {
    func getUserInfo(for username: String) async throws -> User
}

@Observable
final class AddFavoriteViewModel {
    private var addingFavoriteService: AddFavorite
    private var persistenceManager: PersistenceManagerProtocol
    var showingSuccess = false
    var error: FollowersError? {
        didSet {
            if error != nil {
                showingAlert = true
            }
        }
    }

    var showingAlert = false

    init(error: FollowersError? = nil, addFavoriteService: AddFavorite, persistenceManager: PersistenceManagerProtocol = PersistenceManager()) {
        self.error = error
        addingFavoriteService = addFavoriteService
        self.persistenceManager = persistenceManager
    }

    @MainActor
    func addFavorite(username: String) async {
        do {
            let user = try await addingFavoriteService.getUserInfo(for: username)
            let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
            try persistenceManager.updateWith(favorite: favorite, actionType: .add)
            showingSuccess = true
        } catch let error as NetworkError {
            self.error = FollowersError.networkError(error)
        } catch {
            if let error = error as? FollowersError {
                self.error = error
            } else {
                self.error = FollowersError.unexpectedError
            }
        }
    }
}
