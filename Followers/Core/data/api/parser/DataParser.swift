//
//  DataParser.swift
//  Followers
//
//  Created by Eduard Ptushko on 25.03.2024.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(data: Data) throws -> T
}

struct DataParser: DataParserProtocol {
    private let jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func parse<T>(data: Data) throws -> T where T: Decodable {
        try jsonDecoder.decode(T.self, from: data)
    }
}
