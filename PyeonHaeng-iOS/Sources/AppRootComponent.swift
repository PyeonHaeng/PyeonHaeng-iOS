//
//  AppRootComponent.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 2/1/24.
//

import Foundation
import HomeAPI
import HomeAPISupport
import Network

// MARK: - HomeDependency

protocol HomeDependency {
  var homeService: HomeServiceRepresentable { get }
}

// MARK: - AppRootComponent

struct AppRootComponent: HomeDependency {
  let homeService: HomeServiceRepresentable

  init() {
    let homeNetworking: Networking = {
      let configuration: URLSessionConfiguration
      #if DEBUG
        configuration = .ephemeral
        configuration.protocolClasses = [HomeURLProtocol.self]
      #else
        configuration = .default
      #endif
      let provider = NetworkProvider(session: URLSession(configuration: configuration))
      return provider
    }()

    homeService = HomeService(network: homeNetworking)
  }
}
