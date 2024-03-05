//
//  ConvenienceStore.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import DesignSystem
import Foundation
import SwiftUI

public enum ConvenienceStore: String, Codable, CaseIterable {
  case cu = "CU"
  case gs25 = "GS25"
  case _7Eleven = "7-ELEVEn"
  case emart24
  case ministop = "MINISTOP"

  public var image: Image {
    switch self {
    case .cu:
      .cu
    case .gs25:
      .gs25
    case ._7Eleven:
      ._7Eleven
    case .emart24:
      .emart24
    case .ministop:
      .ministop
    }
  }
}
