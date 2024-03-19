//
//  NetworkProvider.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation
import Log

// MARK: - NetworkProvider

public struct NetworkProvider: Networking {
  private let session: URLSession
  private let logger = Log.make(with: .network)

  public init(session: URLSession) {
    self.session = session
  }

  public func request<T: Decodable>(with endPoint: EndPoint) async throws -> T {
    let urlRequest = try makeRequest(endPoint)
    logger?.debug("⬇️⬇️Requesting...⬇️⬇️\n\(urlRequest)\n⬆️⬆️=============⬆️⬆️\n")
    let dataModel = try await executeRequest(urlRequest)
    logger?.debug("⬇️⬇️Decoding...⬇️⬇️\n")
    return try decodingToModel(dataModel)
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

  private func executeRequest(_ request: URLRequest) async throws -> Data {
    let data: Data
    let response: URLResponse

    do {
      (data, response) = try await session.data(for: request)
    } catch {
      logger?.error("⚠️⚠️===Network Connection Error==⚠️⚠️\n")
      throw error
    }
    logger?.debug("✅✅===Req(\(request)) Completed===✅✅\n")

    guard let response = response as? HTTPURLResponse
    else {
      logger?.error("⚠️⚠️===HTTPResponse Error==⚠️⚠️\n")
      throw NetworkError.responseError
    }

    guard 200 ..< 300 ~= response.statusCode
    else {
      logger?.error("⚠️⚠️===Response Status Code Error: \(response.statusCode)==⚠️⚠️\n")
      throw NetworkError.failedResponse(statusCode: response.statusCode)
    }

    return data
  }

  /// 모델을 디코딩합니다.
  /// - Parameter dataModel: 성공적으로 받아온 네트워크 응답 데이터
  /// - Returns: 디코딩된 모델
  private func decodingToModel<T: Decodable>(_ dataModel: Data) throws -> T {
    logger?.info("⬇️⬇️===Received Data===⬇️⬇️\n\(dataModel.prettyJSONData ?? "None")\n⬆️⬆️===============⬆️⬆️\n")
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    do {
      let decodedData = try decoder.decode(T.self, from: dataModel)
      logger?.info("✅✅===Decoding Completed===✅✅\n\(String(describing: decodedData))\n")
      return decodedData
    } catch {
      logger?.error("⚠️⚠️===Decoded Error: \(error)==⚠️⚠️\n")
      throw error
    }
  }
}

private extension Data {
  var prettyJSONData: String? {
    guard let jsonObject = try? JSONSerialization.jsonObject(with: self),
          let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
          let prettyString = String(data: prettyData, encoding: .utf8)
    else {
      return nil
    }
    return prettyString
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
