//
//  EndPoint.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

/// 네트워킹 작업 정보를 담습니다.
public protocol EndPoint {
  /// 공통 base URL
  var baseURL: String { get }

  /// http request method
  var method: HTTPMethod { get }

  /// HTTP path
  var path: String { get }

  /// 요청시 넣을 파라미터입니다.
  ///
  /// body값이거나 query값을 설정할 때 이용합니다.
  var parameters: HTTPParameter { get }

  /// 헤더 값을 설정합니다.
  var headers: [String: String] { get }
}
