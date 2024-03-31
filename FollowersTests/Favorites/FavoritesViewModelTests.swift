//
//  FavoritesViewModelTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 31.03.2024.
//

@testable import Followers
import XCTest

final class FavoritesViewModelTests: XCTestCase {
    private var userDefaults: UserDefaults!
    private var favoritesViewModel: FavoritesViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        favoritesViewModel = FavoritesViewModel(persistenceManager: PersistenceManager(defaults: userDefaults))
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testGetFavorites() throws {
        favoritesViewModel.getFavorites()
        XCTAssertTrue(favoritesViewModel.favorites.isEmpty)

        let follower = Follower.mockFollowers[0]
        try favoritesViewModel.persistenceManager.save(favorites: [follower])

        favoritesViewModel.getFavorites()

        XCTAssertEqual(favoritesViewModel.favorites.count, 1)
        XCTAssertEqual(follower, favoritesViewModel.favorites[0])
    }

    @MainActor
    func testGetFavoritesFailure() throws {
        let favoritesViewModel = FavoritesViewModel(persistenceManager: PersistenceManagerMock())

        favoritesViewModel.getFavorites()

        XCTAssertEqual(favoritesViewModel.favorites.count, 0)
        XCTAssertTrue(favoritesViewModel.showingAlert)
        XCTAssertEqual(favoritesViewModel.followersError, FollowersError.unableToComplete)
    }

    @MainActor
    func testDeleteFavorite() throws {
        let follower = Follower.mockFollowers[0]
        try favoritesViewModel.persistenceManager.save(favorites: [follower])

        favoritesViewModel.getFavorites()
        XCTAssertEqual(favoritesViewModel.favorites.count, 1)
        XCTAssertEqual(follower, favoritesViewModel.favorites[0])

        favoritesViewModel.deleteFavorite(offsets: IndexSet(arrayLiteral: 0))
        XCTAssertTrue(favoritesViewModel.favorites.isEmpty)
    }
}

class PersistenceManagerMock: PersistenceManagerProtocol {
    func updateWith(favorite: Followers.Follower, actionType: Followers.PersistenceActionType) throws {}

    func retrieveFavorites() throws -> [Followers.Follower] {
        throw FollowersError.unableToComplete
    }

    func save(favorites: [Followers.Follower]) throws {}
}
