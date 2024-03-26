//
//  DataParserTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 26.03.2024.
//

@testable import Followers
import XCTest

final class DataParserTests: XCTestCase {
    private let dataParser = DataParser()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataParserDecodesUser() throws {
        let user: User = try dataParser.parse(data: testUser)

        XCTAssertEqual(user.login, "goz")
        XCTAssertEqual(user.name, "Ahmad Gozali")
        XCTAssertEqual(user.followers, 134)
        XCTAssertEqual(user.following, 64)
    }

    func testDataParserDecodesFollowers() throws {
        let followers: [Follower] = try dataParser.parse(data: testDataFollowers)

        XCTAssertEqual(followers.count, 10)
        XCTAssertEqual(followers[0].login, "tkersey")
    }
}
