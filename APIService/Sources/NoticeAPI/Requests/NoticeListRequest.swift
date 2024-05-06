//
//  NoticeListRequest.swift
//
//
//  Created by 홍승현 on 3/10/24.
//

import Foundation

public struct NoticeListRequest: Encodable {
  let limit: Int
  let offset: Int

  public init(limit: Int, offset: Int) {
    self.limit = limit
    self.offset = offset
  }
}
