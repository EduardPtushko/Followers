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
    var showingSuccess = false
    var error: FollowersError? {
        didSet {
            if error != nil {
                showingAlert = true
            }
        }
    }

    var showingAlert = false

    init(error: FollowersError? = nil, addFavoriteService: AddFavorite) {
        self.error = error
        addingFavoriteService = addFavoriteService
    }

    @MainActor
    func addFavorite(username: String) async {
        do {
            let user = try await addingFavoriteService.getUserInfo(for: username)
            let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
            try PersistenceManager.updateWith(favorite: favorite, actionType: .add)
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

var addFavoriteViewModel = AddFavoriteViewModel(addFavoriteService: AddingFavoriteService(requestManager: RequestManager(apiManager: APIManager())))
