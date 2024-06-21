//
//  HomeView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import FirebaseAnalytics
import SwiftUI

// MARK: - HomeView

struct HomeView<ViewModel>: View where ViewModel: HomeViewModelRepresentable {
  @StateObject private var viewModel: ViewModel
  @State private var isOnboardingSheetOpen = false
  @AppStorage("isFirstLaunch") private var isFirstLaunch = true
  @Environment(\.injected) private var container

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    NavigationStack {
      ZStack {
        HomeProductListView<ViewModel>()
        VStack(spacing: 0) {
          VStack {
            HomeProductDetailSelectionView<ViewModel>()
            HomeProductSorterView<ViewModel>()
          }
          .background(
            LinearGradient(
              colors: [.init(.systemBackground), .init(.systemBackground).opacity(0.9)],
              startPoint: .top,
              endPoint: .bottom
            )
          )
          Spacer()
        }
      }
      .environmentObject(viewModel)
      .padding(.horizontal, Metrics.horizontal)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          HStack(alignment: .center, spacing: 4) {
            Image.store
              .renderingMode(.template)
            Image.splashLogo
              .renderingMode(.template)
          }
          .foregroundStyle(.gray900)
        }
        ToolbarItemGroup(placement: .topBarTrailing) {
          NavigationLink {
            SearchView(viewModel: SearchViewModel(service: container.services.searchService))
              .toolbarRole(.editor)
          } label: {
            Image.magnifyingglass
              .renderingMode(.template)
              .foregroundStyle(.gray900)
          }
          .accessibilityLabel("검색")
          .accessibilityHint("더블 탭하여 제품을 검색하세요")
          NavigationLink {
            SettingsView()
              .toolbarRole(.editor)
          } label: {
            Image.gearshape
              .renderingMode(.template)
              .foregroundStyle(.gray900)
          }
          .accessibilityLabel("설정")
          .accessibilityHint("더블 탭하여 설정에 관한 기능을 확인하세요")
        }
      }
    }
    .analyticsScreen(name: "main_countent", class: "\(Self.self)")
    .tint(.accent)
    .fullScreenCover(isPresented: $isOnboardingSheetOpen) {
      OnboardingView()
    }
    .onAppear {
      if isFirstLaunch {
        isOnboardingSheetOpen = true
      }
      viewModel.trigger(.fetchProducts)
    }
  }
}

// MARK: - Metrics

private enum Metrics {
  static let horizontal: CGFloat = 20
}
