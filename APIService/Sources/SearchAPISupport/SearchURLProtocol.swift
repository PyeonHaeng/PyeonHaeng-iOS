//
//  SearchURLProtocol.swift
//
//
//  Created by 김응철 on 3/2/24.
//

import Foundation
import Network
import SearchAPI

public final class SearchURLProtocol: URLProtocol {
  private lazy var mockData: [String: Data?] = [
    SearchEndPoint.fetchProducts(
      SearchProductRequest(name: "칠성)펩시콜라제로355ml")
    ).path: loadMockData(fileName: "SearchProductResponse"),
  ]

  override public class func canInit(with _: URLRequest) -> Bool {
    true
  }

  override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }

  override public func startLoading() {
    defer { client?.urlProtocolDidFinishLoading(self) }
    if let url = request.url,
       let mockData = mockData[url.path(percentEncoded: true)],
       let data = mockData,
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
