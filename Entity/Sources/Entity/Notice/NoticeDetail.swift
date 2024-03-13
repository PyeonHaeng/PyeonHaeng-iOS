//
//  NoticeDetail.swift
//
//
//  Created by 홍승현 on 3/10/24.
//

import Foundation

public struct NoticeDetail {
  /// 공지 제목
  public let title: String

  /// 공지 내용, `markdown`으로 적혀있습니다.
  public let context: String?

  public init(title: String, context: String?) {
    self.title = title
    self.context = context
  }
}
