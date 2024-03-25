//
//  NetworkMonitor.swift
//
//
//  Created by 홍승현 on 3/25/24.
//

import Foundation
import Network

// MARK: - NetworkMonitor

public final class NetworkMonitor: ObservableObject {
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue(label: .networkMonitor)
  @Published public var isActive = false
  @Published public var isExpensive = false
  @Published public var isConstrained = false
  @Published public var connectionType = NWInterface.InterfaceType.other

  public init() {
    monitor.pathUpdateHandler = { path in
      DispatchQueue.main.async {
        self.isActive = path.status == .satisfied
        self.isExpensive = path.isExpensive
        self.isConstrained = path.isConstrained
        let connectionType: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
        self.connectionType = connectionType.first(where: path.usesInterfaceType(_:)) ?? .other
      }
    }
    monitor.start(queue: queue)
  }
}

private extension String {
  static let networkMonitor: String = "NetworkMonitor"
}
