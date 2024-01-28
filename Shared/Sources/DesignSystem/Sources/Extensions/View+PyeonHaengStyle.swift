//
//  View+PyeonHaengStyle.swift
//
//
//  Created by 김응철 on 2024/1/28.
//

import SwiftUI

public extension View {
  func foregroundStyle(_ color: PyeonHaengColor) -> some View {
    foregroundStyle(Color(color.rawValue))
  }

  func background(_ color: PyeonHaengColor) -> some View {
    background(Color(color.rawValue))
  }
}
