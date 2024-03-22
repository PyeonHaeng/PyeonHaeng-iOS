//
//  LeaveReviewView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/21/24.
//

import DesignSystem
import SwiftUI

// MARK: - LeaveReviewView

struct LeaveReviewView: View {
  @Environment(\.openURL) private var openURL

  var body: some View {
    Button(action: openAppReview) {
      HStack {
        Image.appstore
          .renderingMode(.template)
          .foregroundStyle(.gray900)
        Text("Leave a Review")
          .font(.b1)
          .foregroundStyle(.gray900)
        Spacer()
        Image(systemName: Constants.disclosureImageName)
          .font(.system(size: Metrics.disclosureSize, weight: .semibold)) // Styled to look like a disclosure indicator
          .foregroundStyle(.gray.opacity(Metrics.disclosureOpacity))
      }
    }
  }

  // MARK: Private methods

  /// Opens the Mail app's page in the App Store.
  private func openAppReview() {
    if let url = URL(string: Constants.reviewURL) {
      openURL(url)
    }
  }
}

// MARK: - Metrics

private enum Metrics {
  static let disclosureSize: CGFloat = 14
  static let disclosureOpacity: CGFloat = 0.5
}

// MARK: - Constants

private enum Constants {
  static let disclosureImageName: String = "chevron.right"

  static let reviewURL: String = "https://apps.apple.com/app/id1665633509?action=write-review"
}

#Preview {
  LeaveReviewView()
}
