//
//  NetworkMonitor.swift
//
//
//  Created by 홍승현 on 3/25/24.
//

import Foundation
import Network

// MARK: - NetworkMonitor

@Observable
public final class NetworkMonitor {
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue(label: .networkMonitor)
  public var isSatisfied = true

  public init() {
    monitor.pathUpdateHandler = { path in
      DispatchQueue.main.async {
        self.isSatisfied = path.status == .satisfied
      }
    }
    monitor.start(queue: queue)
  }
}

private extension String {
  static let networkMonitor: String = "NetworkMonitor"
}
