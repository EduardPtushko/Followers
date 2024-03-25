//
//  APIManager.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

protocol APIManagerProtocol {
    func initRequest(with request: RequestProtocol) async throws -> Data
}

class APIManager: APIManagerProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func initRequest(with data: any RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: data.request())

        guard let urlResponse = response as? HTTPURLResponse,
              (200..<300) ~= urlResponse.statusCode else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
}
