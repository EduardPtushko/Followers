//
//  URLProtocolStub.swift
//  Followers
//
//  Created by Eduard Ptushko on 18.03.2024.
//

import Foundation

class URLProtocolStub: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let url = request.url {
            client?.urlProtocol(self, didReceive: URLResponse(), cacheStoragePolicy: .notAllowed)
//            client?.urlProtocol(self, didLoad: )
        } else {
            client?.urlProtocol(self, didFailWithError: LoadingError.loadFailed)
        }
    }

    override func stopLoading() {}

    enum LoadingError: Error {
        case loadFailed
    }
}
