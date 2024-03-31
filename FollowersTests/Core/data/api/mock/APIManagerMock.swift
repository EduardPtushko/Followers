//
//  APIManagerMock.swift
//  FollowersTests
//
//  Created by Eduard Ptushko on 27.03.2024.
//

@testable import Followers
import Foundation

struct APIManagerMock: APIManagerProtocol {
    func initRequest(with data: any RequestProtocol) async throws -> Data {
        Data(data.path.utf8)
    }
}
