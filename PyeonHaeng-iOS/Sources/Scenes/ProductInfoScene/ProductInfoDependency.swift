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
  let productID: Int

  init(productID: Int) {
    self.productID = productID
    let productInfoNetworking: Networking = {
      let configuration = URLSessionConfiguration.ephemeral
      configuration.protocolClasses = [ProductInfoURLProtocol.self]
      let provider = NetworkProvider(session: URLSession(configuration: configuration))
      return provider
    }()

    productInfoService = ProductInfoService(productID: productID,
                                            network: productInfoNetworking)
  }
}
