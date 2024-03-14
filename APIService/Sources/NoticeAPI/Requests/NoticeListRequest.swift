//
//  NoticeListRequest.swift
//
//
//  Created by 홍승현 on 3/10/24.
//

import Foundation

public struct NoticeListRequest: Encodable {
  let pageSize: Int
  let offset: Int

  public init(pageSize: Int, offset: Int) {
    self.pageSize = pageSize
    self.offset = offset
  }

  enum CodingKeys: String, CodingKey {
    case pageSize = "page_size"
    case offset
  }
}
