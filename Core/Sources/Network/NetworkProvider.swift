//
//  NetworkProvider.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation

// MARK: - NetworkProvider

public struct NetworkProvider: Networking {
  private let session: URLSession

  public init(session: URLSession) {
    self.session = session
  }

  public func request<T: Decodable>(with endPoint: EndPoint) async throws -> T {
    let urlRequest = try makeRequest(endPoint)
    return try await executeRequest(urlRequest)
  }

  /// EndPoint를 통해 URLRequest를 생성합니다.
  private func makeRequest(_ endPoint: EndPoint) throws -> URLRequest {
    guard let url = URL(string: endPoint.baseURL)?.appending(path: endPoint.path)
    else {
      throw NetworkError.urlError
    }
    var request = URLRequest(url: url)
    request.httpMethod = endPoint.method.rawValue
    request.allHTTPHeaderFields = endPoint.headers

    // parameter 세팅
    do {
      switch endPoint.parameters {
      case .plain:
        break
      case let .body(data):
        request.httpBody = try JSONEncoder().encode(data)
      case let .query(data):
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = data.toDictionary.map { URLQueryItem(name: $0, value: "\($1)") }
        request.url = URL(string: components?.url?.absoluteString.replacingOccurrences(of: "+", with: "%2B") ?? "")
      }
    } catch {
      throw NetworkError.encodeError
    }
    return request
  }

  private func executeRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
    let (data, response) = try await session.data(for: request)

    guard let response = response as? HTTPURLResponse
    else {
      throw NetworkError.responseError
    }

    guard 200 ..< 300 ~= response.statusCode
    else {
      throw NetworkError.failedResponse(statusCode: response.statusCode)
    }

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let decodedData = try decoder.decode(T.self, from: data)
    return decodedData
  }
}

private extension Encodable {
  var toDictionary: [String: Any] {
    guard let data = try? JSONEncoder().encode(self),
          let jsonData = try? JSONSerialization.jsonObject(with: data),
          let dictionaryData = jsonData as? [String: Any]
    else {
      return [:]
    }
    return dictionaryData
  }
}
