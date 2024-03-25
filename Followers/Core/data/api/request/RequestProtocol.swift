//
//  RequestProtocol.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var headers: [String: String] { get }
    var requestType: RequestType { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
}

extension RequestProtocol {
    var host: String { APIConstants.host }

    var params: [String: Any] {
        [:]
    }

    var urlParams: [String: String?] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }
}

extension RequestProtocol {
    func request() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path

        if !urlParams.isEmpty {
            components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            request.allHTTPHeaderFields = headers
        }

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        }

        return request
    }
}
