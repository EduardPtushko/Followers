//
//  UserInfoViewModelTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 31.03.2024.
//

@testable import Followers
import XCTest

final class UserInfoViewModelTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testGetUserSuccess() async throws {
        let userInfoViewModel = UserInfoViewModel(userInfoFetcher: GetUserInfoServiceMock())

        await userInfoViewModel.getUser(username: "goz")

        let user = userInfoViewModel.user

        XCTAssertEqual(user?.login, "goz")
        XCTAssertEqual(user?.name, "Ahmad Gozali")
        XCTAssertEqual(user?.bio, "Know very little except how to google")
        XCTAssertFalse(userInfoViewModel.showingAlert)
        XCTAssertNil(userInfoViewModel.error)
    }

    func testGetUserFailure() async throws {
        let userInfoViewModel = UserInfoViewModel(userInfoFetcher: GetUserInfoServiceThrowsMock())

        await userInfoViewModel.getUser(username: "goz")

        XCTAssertEqual(userInfoViewModel.error, FollowersError.networkError(.invalidServerResponse))
        XCTAssertTrue(userInfoViewModel.showingAlert)
        XCTAssertNil(userInfoViewModel.user)
    }
}

struct GetUserInfoServiceThrowsMock: UserInfoFetcher {
    func fetchUserInfo(username: String) async throws -> User {
        throw NetworkError.invalidServerResponse
    }
}
