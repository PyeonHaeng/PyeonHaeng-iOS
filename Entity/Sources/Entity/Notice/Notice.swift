//
//  Notice.swift
//
//
//  Created by 홍승현 on 3/10/24.
//

import Foundation

public struct Notice {
  /// 공지 날짜
  public let date: Date

  /// 공지 제목
  public let title: String

  public init(date: Date, title: String) {
    self.date = date
    self.title = title
  }
}
