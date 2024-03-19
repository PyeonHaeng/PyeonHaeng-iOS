//
//  DIContainer.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/19/24.
//

import SwiftUI

// MARK: - DIContainer

struct DIContainer: EnvironmentKey {
  let services: Services

  static var defaultValue: Self { Self.default }

  private static let `default` = Self(services: .init())
}

extension EnvironmentValues {
  var injected: DIContainer {
    get { self[DIContainer.self] }
    set { self[DIContainer.self] = newValue }
  }
}
