//
//  FollowersRequestTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 27.03.2024.
//

@testable import Followers
import XCTest

final class FollowersRequestTests: XCTestCase {
    func testFollowersRequestGetFollowers() throws {
        let endpoint = FollowersRequest.getFollowers(username: "apple", page: 1)

        let request = try endpoint.request()
        XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/users/apple/followers?per_page=100&page=1")

        XCTAssertEqual(endpoint.host, "api.github.com")
        XCTAssertEqual(endpoint.path, "/users/apple/followers")
        XCTAssertEqual(endpoint.requestType, .GET)
        XCTAssertEqual(endpoint.urlParams, ["per_page": "100", "page": String(1)])
    }
}
