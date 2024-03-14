//
//  ProductInfoDependency.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2/10/24.
//

import Foundation
import Network
import ProductInfoAPI
import ProductInfoAPISupport

// MARK: - ProductInfoDependency

protocol ProductInfoDependency {
  var productInfoService: ProductInfoServiceRepresentable { get }
}

// MARK: - ProductInfoComponent

struct ProductInfoComponent: ProductInfoDependency {
  let productInfoService: ProductInfoServiceRepresentable

  init(productID: Int) {
    let productInfoNetworking: Networking = {
      var configuration = URLSessionConfiguration.ephemeral
      #if DEBUG
        configuration = .ephemeral
        configuration.protocolClasses = [ProductInfoURLProtocol.self]
      #else
        configuration = .default
      #endif
      let provider = NetworkProvider(session: URLSession(configuration: configuration))
      return provider
    }()

    productInfoService = ProductInfoService(productID: productID,
                                            network: productInfoNetworking)
  }
}
