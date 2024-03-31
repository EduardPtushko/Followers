//
//  RequestManagerTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 27.03.2024.
//

@testable import Followers
import XCTest

class RequestManagerTests: XCTestCase {
    private var requestManager: RequestManagerProtocol?

    override func setUp() {
        super.setUp()

        requestManager = RequestManagerMock(apiManager: APIManagerMock())
    }

    func testRequestUser() async throws {
        guard let user: User = try await requestManager?.initRequest(with: UserInfoRequestMock.getUserInfo(username: "goz")) else {
            XCTFail()
            return
        }

        XCTAssertEqual(user.login, "goz")
    }

    func testRequestFollowers() async throws {
        guard let followers: [Follower] = try await requestManager?.initRequest(with: FollowersRequestMock.getFollowers(username: "goz", page: 1)) else {
            XCTFail()
            return
        }
        let first = followers.first
        let last = followers.last

        XCTAssertEqual(first?.login, "tkersey")
        XCTAssertEqual(last?.login, "tonyarnold")
    }
}
