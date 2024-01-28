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
        HomeProductListView()
        Spacer()
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
            ProductInfoView()
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

  private enum Metrics {
    static let horizontal: CGFloat = 20
  }
}

// MARK: - HomeProductListView

struct HomeProductListView: View {
  var body: some View {
    Text("")
  }
}

#Preview {
  HomeView()
}
