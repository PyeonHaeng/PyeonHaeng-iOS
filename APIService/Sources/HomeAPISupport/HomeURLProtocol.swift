//
//  HomeURLProtocol.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation
import Network

public final class HomeURLProtocol: URLProtocol {
  private let fileName = "HomeProductResponse"

  override public class func canInit(with _: URLRequest) -> Bool {
    true
  }

  override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }

  override public func startLoading() {
    defer { client?.urlProtocolDidFinishLoading(self) }
    if let data = loadMockData(fileName: fileName),
       let url = request.url,
       let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) {
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: data)
    } else {
      client?.urlProtocol(self, didFailWithError: NetworkError.urlError)
    }
  }

  override public func stopLoading() {}

  private func loadMockData(fileName: String) -> Data? {
    guard let url = Bundle.module.url(forResource: fileName, withExtension: "json")
    else {
      return nil
    }
    return try? Data(contentsOf: url)
  }
}
