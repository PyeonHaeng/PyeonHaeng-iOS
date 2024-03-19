//
//  NoticeService.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation
import Network

// MARK: - NoticeServiceRepresentable

public protocol NoticeServiceRepresentable {
  func fetchNoticeList(request: NoticeListRequest) async throws -> Paginated<Notice>
}

// MARK: - NoticeService

public struct NoticeService {
  private let network: Networking

  public init(network: Networking) {
    self.network = network
  }
}

// MARK: NoticeServiceRepresentable

extension NoticeService: NoticeServiceRepresentable {
  public func fetchNoticeList(request: NoticeListRequest) async throws -> Paginated<Notice> {
    let response: NoticeResponse = try await network.request(with: NoticeEndPoint.fetchList(request))
    return Paginated<Notice>(dto: response)
  }
}

private extension Paginated where Model == Notice {
  init(dto: NoticeResponse) {
    self.init(
      count: dto.count,
      hasMore: dto.hasMore,
      results: dto.results.map(Notice.init)
    )
  }
}

private extension Notice {
  init(dto: NoticeItemResponse) {
    self.init(
      id: dto.id,
      date: dto.date,
      title: dto.title
    )
  }
}
