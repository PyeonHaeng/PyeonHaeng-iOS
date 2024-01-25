//
//  HTTPParameter.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

/// 통신 요청 시 필요한 파라미터 데이터를 담습니다.
public enum HTTPParameter {
  /// 빈 평문입니다.
  ///
  /// 아무런 정보 값 없이 요청할 때 사용합니다.
  case plain

  /// query를 설정합니다.
  ///
  /// query문으로 요청값을 전달하고 싶을 때 사용합니다.
  case query(Encodable)

  /// body를 설정합니다.
  ///
  /// `post`요청과 같이 body-field에 무언가를 담아 보내야하는 경우에 사용합니다.
  case body(Encodable)
}
