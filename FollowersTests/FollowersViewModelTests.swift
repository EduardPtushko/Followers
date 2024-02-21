//
//  FollowersViewModelTests.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 21.02.2024.
//

import XCTest
@testable import Followers

final class FollowersViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        let sut = FollowersViewModel(networkManager: MockNetworkManager())

        await sut.getFollowers(username: "apple")
        
        XCTAssertEqual(sut.followers.count, 10)
    }


}
