//
//  HomeView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

// MARK: - HomeView

struct HomeView: View {
  var body: some View {
    NavigationStack {
      VStack {
        HomeProductDetailSelectionView()
        HomeProductSorterView(count: 12)
        HomeProductListView()
      }
      .padding(.horizontal, Metrics.horizontal)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          HStack {
            Image.store
          }
        }

        ToolbarItemGroup(placement: .topBarTrailing) {
          NavigationLink {
            ProductSearchView()
              .toolbarRole(.editor)
          } label: {
            Image.magnifyingglass
          }
          .accessibilityLabel("검색")
          .accessibilityHint("더블 탭하여 제품을 검색하세요")
          NavigationLink {
            SettingsView()
              .toolbarRole(.editor)
          } label: {
            Image.gearshape
          }
          .accessibilityLabel("설정")
          .accessibilityHint("더블 탭하여 설정에 관한 기능을 확인하세요")
        }
      }
    }
  }
}

// MARK: HomeView.Metrics

private extension HomeView {
  enum Metrics {
    static let horizontal: CGFloat = 20
  }
}
