//
//  FollowersViewModelTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 31.03.2024.
//

@testable import Followers
import XCTest

final class FollowersViewModelTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchFollowersSuccess() async throws {
        let followersViewModel = FollowersViewModel(followersService: FollowersServiceMock())
        XCTAssertEqual(followersViewModel.isLoading, true)
        await followersViewModel.getFollowers(username: "apple")
        XCTAssertEqual(followersViewModel.isLoading, false)
        XCTAssertEqual(followersViewModel.filteredFollowers.count, 10)
    }

    func testFetchMoreFollowersSuccess() async throws {
        let followersViewModel = FollowersViewModel(followersService: FollowersServiceMock())
        XCTAssertEqual(followersViewModel.filteredFollowers.count, 0)

        await followersViewModel.getFollowers(username: "apple")
        XCTAssertEqual(followersViewModel.filteredFollowers.count, 10)

        await followersViewModel.getMoreFollowers(username: "apple")

        XCTAssertEqual(followersViewModel.filteredFollowers.count, 20)
        XCTAssertEqual(followersViewModel.page, 2)
    }

    func testFetchFollowersEmptyResponse() async throws {
        let followersViewModel = FollowersViewModel(followersService: EmptyResponseFollowersFetcherMock())

        await followersViewModel.getFollowers(username: "apple")
        XCTAssertFalse(followersViewModel.isLoading)
        XCTAssertFalse(followersViewModel.hasMoreFollowers)
        XCTAssertEqual(followersViewModel.filteredFollowers.count, 0)
    }

    func testFetchFollowersThrowsError() async throws {
        let followersViewModel = FollowersViewModel(followersService: FollowersFetcherThrowsErrorMock())

        await followersViewModel.getFollowers(username: "apple")

        XCTAssertEqual(followersViewModel.error, FollowersError.networkError(NetworkError.invalidServerResponse))

        XCTAssertEqual(followersViewModel.isLoading, false)
    }
}

struct EmptyResponseFollowersFetcherMock: FollowersFetcher {
    func fetchFollowers(for username: String, page: Int) async throws -> [Followers.Follower] {
        []
    }
}

struct FollowersFetcherThrowsErrorMock: FollowersFetcher {
    func fetchFollowers(for username: String, page: Int) async throws -> [Followers.Follower] {
        throw NetworkError.invalidServerResponse
    }
}
