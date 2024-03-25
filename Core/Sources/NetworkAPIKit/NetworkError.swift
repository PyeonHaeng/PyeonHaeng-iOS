//
//  NetworkError.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation

// MARK: - NetworkError

public enum NetworkError {
  case urlError
  case decodeError
  case encodeError
  case requestError(Error)
  case responseError
  case failedResponse(statusCode: Int)
  case emptyResponse
}

// MARK: LocalizedError

extension NetworkError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .urlError:
      "잘못된 URL 입니다."
    case .decodeError:
      "디코딩에 실패했습니다."
    case .encodeError:
      "인코딩에 실패했습니다."
    case let .requestError(error):
      "요청 간 에러가 발생했습니다. \(error)"
    case .responseError:
      "잘못된 응답입니다."
    case let .failedResponse(statusCode):
      "Error status code : \(statusCode)"
    case .emptyResponse:
      "응답이 비어있습니다."
    }
  }
}
