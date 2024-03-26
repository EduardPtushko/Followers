//
//  URLSessionExtension.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.03.2024.
//

import Foundation

extension URLSession {
    static var urlDataDict: [URL: Data] = [:]
    static var didProcessURLs = false

    static var stub: URLSession {
        if !didProcessURLs {
            didProcessURLs = true
        }

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: config)
    }
}
