//
//  Services.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 2/1/24.
//

import Foundation
import HomeAPI
import HomeAPISupport
import Network
import NoticeAPI
import NoticeAPISupport
import ProductInfoAPI
import ProductInfoAPISupport
import SearchAPI
import SearchAPISupport

// MARK: - Services

struct Services {
  let homeService: HomeServiceRepresentable
  let noticeService: NoticeServiceRepresentable
  let productInfoService: ProductInfoServiceRepresentable
  let searchService: SearchServiceRepresentable
  
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
    
    let noticeNetworking: Networking = {
      let configuration: URLSessionConfiguration
      #if DEBUG
      configuration = .ephemeral
      configuration.protocolClasses = [NoticeURLProtocol.self]
      #else
      configuration = .default
      #endif
      let provider = NetworkProvider(session: URLSession(configuration: configuration))
      return provider
    }()
    
    let productInfoNetworking: Networking = {
      let configuration: URLSessionConfiguration
      #if DEBUG
      configuration = .ephemeral
      configuration.protocolClasses = [ProductInfoURLProtocol.self]
      #else
      configuration = .default
      #endif
      let provider = NetworkProvider(session: URLSession(configuration: configuration))
      return provider
    }()
    
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
    
    homeService = HomeService(network: homeNetworking)
    noticeService = NoticeService(network: noticeNetworking)
    productInfoService = ProductInfoService(network: productInfoNetworking)
    searchService = SearchService(network: searchNetworking)
  }
}
