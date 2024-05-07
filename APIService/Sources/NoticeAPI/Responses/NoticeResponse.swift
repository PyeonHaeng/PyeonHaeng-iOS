//
//  NoticeResponse.swift
//
//
//  Created by 홍승현 on 3/10/24.
//

import Entity
import Foundation

// MARK: - NoticeResponse

struct NoticeResponse: Decodable, Paginatable {
  let count: Int
  let hasMore: Bool

  let results: [NoticeItemResponse]
}

// MARK: - NoticeItemResponse

struct NoticeItemResponse: Decodable {
  let id: Int
  let title: String
  let content: String
  let createdAt: Date
}
