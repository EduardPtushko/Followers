//
//  UserInfoRequestTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 27.03.2024.
//

@testable import Followers
import XCTest

final class UserInfoRequestTests: XCTestCase {
    func testUserInfoRequestGetUserInfo() throws {
        let request = UserInfoRequest.getUserInfo(username: "apple")

        guard let url = try request.request().url else {
            XCTFail()
            return
        }
        XCTAssertEqual(url.absoluteString, "https://api.github.com/users/apple")

        XCTAssertEqual(request.path, "/users/apple")
        XCTAssertEqual(request.requestType, .GET)
    }
}
