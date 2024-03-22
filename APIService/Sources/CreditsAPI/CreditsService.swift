//
//  CreditsService.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation
import Network

// MARK: - CreditsServiceRepresentable

public protocol CreditsServiceRepresentable {
  func fetchCredits() async throws -> Credits
}

// MARK: - CreditsService

public struct CreditsService {
  private let network: Networking

  public init(network: Networking) {
    self.network = network
  }
}

// MARK: CreditsServiceRepresentable

extension CreditsService: CreditsServiceRepresentable {
  public func fetchCredits() async throws -> Credits {
    let response: CreditsResponse = try await network.request(with: CreditsEndPoint.fetchCredits)
    return Credits(dto: response)
  }
}

private extension Credits {
  init(dto: CreditsResponse) {
    self.init(
      title: dto.title,
      body: dto.body,
      date: dto.date
    )
  }
}
