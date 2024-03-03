//
//  SearchViewComponent.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 3/4/24.
//

import Foundation
import Network
import SearchAPI
import SearchAPISupport

// MARK: - SearchDependency

protocol SearchDependency {
  var searchService: SearchServiceRepresentable { get }
}

// MARK: - SearchViewComponent

struct SearchViewComponent: SearchDependency {
  let searchService: SearchServiceRepresentable

  init() {
    let searchNetworking: Networking = {
      let configuration: URLSessionConfiguration
      #if DEBUG
        configuration = .ephemeral
        configuration.protocolClasses = [SearchURLProtocol.self]
      #else
        configuration = .default
      #endif
      let provider = NetworkProvider(session: URLSession(configuration: configuration))
      return provider
    }()

    searchService = SearchService(network: searchNetworking)
  }
}
