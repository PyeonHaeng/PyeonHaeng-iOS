//
//  Array+subscript.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 6/20/24.
//

import Foundation

extension Array {
  subscript(safe index: Index) -> Element? {
    indices ~= index ? self[index] : nil
  }
}
