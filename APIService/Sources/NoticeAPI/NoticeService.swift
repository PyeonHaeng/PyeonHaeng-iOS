//
//  NoticeService.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation
import NetworkAPIKit

// MARK: - NoticeServiceRepresentable

public protocol NoticeServiceRepresentable {
  func fetchNoticeList(request: NoticeListRequest) async throws -> Paginated<Notice>
  func fetchNoticeDetail(id: Int) async throws -> NoticeDetail
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

  public func fetchNoticeDetail(id: Int) async throws -> NoticeDetail {
    let response: NoticeItemResponse = try await network.request(with: NoticeEndPoint.fetchDetail(id))
    return NoticeDetail(dto: response)
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

private extension NoticeDetail {
  init(dto: NoticeItemResponse) {
    self.init(
      title: dto.title,
      context: dto.body
    )
  }
}
