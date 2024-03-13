//
//  NoticeDetailService.swift
//
//
//  Created by 홍승현 on 3/10/24.
//

import Entity
import Foundation
import Network

// MARK: - NoticeDetailServiceRepresentable

public protocol NoticeDetailServiceRepresentable {
  func fetchNoticeDetail() async throws -> NoticeDetail
}

// MARK: - NoticeDetailService

public struct NoticeDetailService {
  private let network: Networking
  private let id: Int

  public init(network: Networking, id: Int) {
    self.network = network
    self.id = id
  }
}

// MARK: NoticeDetailServiceRepresentable

extension NoticeDetailService: NoticeDetailServiceRepresentable {
  public func fetchNoticeDetail() async throws -> NoticeDetail {
    let countResponse: NoticeItemResponse = try await network.request(with: NoticeEndPoint.fetchDetail(id))
    return NoticeDetail(dto: countResponse)
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
