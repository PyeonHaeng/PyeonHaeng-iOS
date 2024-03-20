//
//  Notice.swift
//
//
//  Created by 홍승현 on 3/10/24.
//

import Foundation

public struct Notice: Identifiable {
  public let id: Int
  /// 공지 날짜
  public let date: Date

  /// 공지 제목
  public let title: String

  public init(id: Int, date: Date, title: String) {
    self.id = id
    self.date = date
    self.title = title
  }
}
