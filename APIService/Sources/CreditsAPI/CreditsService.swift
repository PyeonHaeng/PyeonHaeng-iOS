//
//  CreditsService.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation
import Network

// MARK: - HomeServiceRepresentable

public protocol HomeServiceRepresentable {
  func fetchCredits() async throws
}

// MARK: - HomeService

public struct HomeService {
  private let network: Networking

  public init(network: Networking) {
    self.network = network
  }
}

// MARK: HomeServiceRepresentable

extension HomeService: HomeServiceRepresentable {
  public func fetchCredits() async throws {
    let response: CreditsResponse = try await network.request(with: CreditsEndPoint.fetchCredits)
  }
}
