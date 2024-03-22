//
//  Credits.swift
//
//
//  Created by 홍승현 on 3/22/24.
//

import Foundation

/// `만든사람들`을 보여주는 크레딧 장면에서 사용될 엔티티 모델
public struct Credits {
  /// 크레딧 제목
  public let title: String

  /// 크레딧 내용
  public let body: String

  /// 크레딧 생성 날짜
  public let date: Date

  public init(title: String, body: String, date: Date) {
    self.title = title
    self.body = body
    self.date = date
  }
}
