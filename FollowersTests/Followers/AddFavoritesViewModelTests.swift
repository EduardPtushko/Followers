//
//  AddFavoritesViewModelTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 31.03.2024.
//

@testable import Followers
import XCTest

final class AddFavoritesViewModelTests: XCTestCase {
    private var userDefaults: UserDefaults!
    private var addFavoriteViewModel: AddFavoriteViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        addFavoriteViewModel = AddFavoriteViewModel(addFavoriteService: AddingFavoriteServiceMock(), persistenceManager: PersistenceManager(defaults: userDefaults))
    }

    override func tearDownWithError() throws {}

    func testAddFavoriteSuccess() async throws {
        await addFavoriteViewModel.addFavorite(username: "goz")

        XCTAssertTrue(addFavoriteViewModel.showingSuccess)
        XCTAssertNil(addFavoriteViewModel.error)
        XCTAssertFalse(addFavoriteViewModel.showingAlert)
    }

    func testAddFavoriteAddingExistingShouldThrow() async throws {
        await addFavoriteViewModel.addFavorite(username: "goz")
        await addFavoriteViewModel.addFavorite(username: "goz")

        XCTAssertNotNil(addFavoriteViewModel.error)
        XCTAssertTrue(addFavoriteViewModel.showingAlert)
        XCTAssertEqual(addFavoriteViewModel.error, FollowersError.alreadyInFavorites)
    }
}
