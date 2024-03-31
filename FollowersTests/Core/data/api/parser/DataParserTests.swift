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

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

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

    func testDataParserInvalidDataShouldThrow() throws {
        XCTAssertThrowsError(try dataParser.parse(data: testInvalidUser) as User)

        do {
            let _: User = try dataParser.parse(data: testInvalidUser)
        } catch {
            guard let parserError = error as? NetworkError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(parserError, NetworkError.invalidData)
        }
    }

    func testDataParserEmptyDataShouldThrow() throws {
        XCTAssertThrowsError(try dataParser.parse(data: testEmptyData) as User)

        do {
            let _: User = try dataParser.parse(data: testEmptyData)
        } catch {
            guard let parserError = error as? NetworkError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(parserError, NetworkError.invalidData)
        }
    }

    func testDataParserInvalidJsonShouldThrow() throws {
        XCTAssertThrowsError(try dataParser.parse(data: testDataFollowers) as User)

        do {
            let _: User = try dataParser.parse(data: testDataFollowers)
        } catch {
            guard let parserError = error as? NetworkError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(parserError, NetworkError.invalidData)
        }
    }
}
