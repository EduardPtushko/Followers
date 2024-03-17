//
//  FollowersViewModelTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 21.02.2024.
//

@testable import Followers
import XCTest

final class FollowersViewModelTests: XCTestCase {
    var followersViewModel: FollowersViewModel!

    override func setUpWithError() throws {
        followersViewModel = FollowersViewModel(networkManager: MockNetworkManager())
    }

    override func tearDownWithError() throws {
        followersViewModel = nil
    }

//    func testGetFollowers() async throws {
//        await followersViewModel.getFollowers(username: "apple")
//
//        XCTAssertEqual(followersViewModel.page, 1)
//        XCTAssertEqual(followersViewModel.followers.count, 10)
//        XCTAssertEqual(followersViewModel.viewState, .gridView)
//    }
//
//    func testGetFollowersInvalidUsernameShouldThrow() async throws {
//        let manager = MockNetworkManager()
//        manager.mockError = FollowersError.invalidUsername
//        let followersViewModel = FollowersViewModel(networkManager: manager)
//
//        await followersViewModel.getFollowers(username: "agjorngrgng5f4g49rg4/")
//
//        XCTAssertEqual(followersViewModel.page, 0)
//        XCTAssertEqual(followersViewModel.followers.count, 0)
//        XCTAssertEqual(followersViewModel.viewState, .empty)
//        XCTAssertEqual(followersViewModel.lastAlertMessage, FollowersError.invalidUsername.localizedDescription)
//    }
//
//    func testResetShouldSetPropertiesToInitialValues() async throws {
//        await followersViewModel.getFollowers(username: "apple")
//        XCTAssertEqual(followersViewModel.followers.count, 10)
//
//        followersViewModel.hasMoreFollowers = false
//        followersViewModel.searchText = "search"
//        followersViewModel.lastAlertMessage = "Error"
//        followersViewModel.isDisplayingAlert = true
//
//        await followersViewModel.reset()
//
//        XCTAssertEqual(followersViewModel.followers.count, 0)
//        XCTAssertEqual(followersViewModel.hasMoreFollowers, true)
//        XCTAssertEqual(followersViewModel.viewState, .empty)
//        XCTAssertEqual(followersViewModel.page, 0)
//        XCTAssertEqual(followersViewModel.searchText, "")
//        XCTAssertEqual(followersViewModel.lastAlertMessage, "None")
//        XCTAssertEqual(followersViewModel.isDisplayingAlert, false)
//    }

    func testFilteredFollowerShouldReturnFollowers() async throws {
        await followersViewModel.getFollowers(username: "apple")

        let filteredFollowers = followersViewModel.filteredFollowers

        XCTAssertEqual(followersViewModel.followers, filteredFollowers)
    }

    func testFilteredFollowerShouldReturnFilteredFollowers() async throws {
        await followersViewModel.getFollowers(username: "apple")

        followersViewModel.searchText = "t"

        XCTAssertEqual(followersViewModel.filteredFollowers.count, 4)
    }
}
