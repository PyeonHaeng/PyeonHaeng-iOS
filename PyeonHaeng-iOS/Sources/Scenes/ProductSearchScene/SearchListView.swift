//
//  SearchListView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 3/1/24.
//

import DesignSystem
import SwiftUI

// MARK: - SearchListView

struct SearchListView: View {
  var body: some View {
    HStack {}
  }
}

// MARK: - SearchSectionView

private struct SearchSectionView: View {
  var body: some View {
    HStack(spacing: 8.0) {
      Image._7Eleven
      Text(verbatim: "3")
        .font(.title2)
    }
  }
}

#Preview {
  SearchListView()
}
