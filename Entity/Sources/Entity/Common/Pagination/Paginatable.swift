//
//  Paginatable.swift
//
//
//  Created by 홍승현 on 2/23/24.
//

public protocol Paginatable {
  associatedtype Model
  var count: Int { get }
  var hasMore: Bool { get }

  var results: [Model] { get }
}
