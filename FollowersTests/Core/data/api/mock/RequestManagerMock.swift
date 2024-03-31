//
//  RequestManagerMock.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 27.03.2024.
//

@testable import Followers
import XCTest

struct RequestManagerMock: RequestManagerProtocol {
    let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }

    func initRequest<T: Decodable>(with data: any RequestProtocol) async throws -> T {
        let data = try await apiManager.initRequest(with: data)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}
