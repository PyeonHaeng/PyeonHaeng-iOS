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

  enum CodingKeys: String, CodingKey {
    case count
    case hasMore = "has_more"
    case results
  }
}

// MARK: - NoticeItemResponse

struct NoticeItemResponse: Decodable {
  let id: Int
  let title: String
  let body: String?
  let date: Date
}
