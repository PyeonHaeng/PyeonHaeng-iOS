//
//  MockURLProtocol.swift
//
//
//  Created by 홍승현 on 5/7/24.
//

import Foundation

class MockURLProtocol: URLProtocol {
  static var mockData: Data?
  static var mockError: Error?
  static var mockStatusCode: Int?

  override class func canInit(with _: URLRequest) -> Bool {
    true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }

  override func startLoading() {
    if let error = MockURLProtocol.mockError {
      client?.urlProtocol(self, didFailWithError: error)
    } else {
      let response = HTTPURLResponse(url: request.url!, statusCode: MockURLProtocol.mockStatusCode ?? 200, httpVersion: nil, headerFields: nil)
      client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: MockURLProtocol.mockData ?? Data())
    }
    client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {}
}
