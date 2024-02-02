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
            Image(systemName: "storefront")
              .foregroundStyle(Color.gray900)
          }
        }

        ToolbarItemGroup(placement: .topBarTrailing) {
          NavigationLink {
            ProductSearchView()
              .toolbarRole(.editor)
          } label: {
            Image(systemName: "magnifyingglass")
              .foregroundStyle(Color.gray900)
          }
          NavigationLink {
            SettingsView()
              .toolbarRole(.editor)
          } label: {
            Image(systemName: "gear")
              .foregroundStyle(Color.gray900)
          }
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
