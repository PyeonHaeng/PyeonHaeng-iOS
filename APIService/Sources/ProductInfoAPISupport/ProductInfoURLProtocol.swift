//
//  ProductInfoURLProtocol.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Foundation
import ProductInfoAPI
import Network

public final class ProductInfoURLProtocol: URLProtocol {
  private lazy var mockData: [String: Data?] = [
    ProductInfoEndPoint.fetchProduct(0).path : loadMockData(fileName: "HomeProductResponse"),
    ProductInfoEndPoint.fetchPrices(0).path : loadMockData(fileName: "ProductPriceResponse")
  ]
  
  public override class func canInit(with request: URLRequest) -> Bool {
    true
  }
  
  public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }
  
  public override func startLoading() {
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
  
  private func loadMockData(fileName: String) -> Data? {
    guard let url = Bundle.module.url(forResource: fileName, withExtension: "json")
    else {
      return nil
    }
    return try? Data(contentsOf: url)
  }
}
