//
//  RequestManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

protocol RequestManagerProtocol {
    var parser: DataParserProtocol { get }
    func initRequest<T: Decodable>(with data: any RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
    private var apiManager: APIManager

    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }

    func initRequest<T: Decodable>(with data: any RequestProtocol) async throws -> T {
        let data = try await apiManager.initRequest(with: data)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}

extension RequestManagerProtocol {
    var parser: DataParserProtocol {
        DataParser()
    }
}
