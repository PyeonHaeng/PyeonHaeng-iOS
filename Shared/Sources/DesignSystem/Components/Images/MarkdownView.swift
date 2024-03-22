//
//  MarkdownView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/8/24.
//

import SwiftUI

// MARK: - TextBlock

private struct TextBlock: Identifiable {
  let id: UUID = .init()
  let content: String
}

// MARK: - MarkdownView

public struct MarkdownView: View {
  private let content: String

  public init(content: String) {
    self.content = content
  }

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .zero) {
        ForEach(content.components(separatedBy: .newlines).map(TextBlock.init)) { block in
          if block.content.starts(with: #/\s*[-*]/#) {
            BulletTextView(content: block.content)
              .font(.body3)
          } else {
            Text(block.content)
              .font(.body2)
          }
        }
      }
      .padding(.vertical, Metrics.verticalPadding)
      .padding(.horizontal, Metrics.horizontalPadding)
    }
  }
}

// MARK: - BulletTextView

private struct BulletTextView: View {
  /// The text content after removing the bullet symbol and leading spaces.
  private let content: String

  /// Calculated spacing to apply before the bullet symbol for alignment.
  private let spacingCount: CGFloat

  /// Initializes the view with text content, automatically adjusting spacing based on leading spaces.
  ///
  /// - Parameter content: The bullet-prefixed content, optionally with leading spaces.
  init(content: String) {
    guard let match = content.firstMatch(of: #/(?<spacing>\s*)[-*]\s*?(?<content>[^\s].*)/#)
    else {
      self.content = content
      spacingCount = 0
      return
    }

    self.content = String(match.content)

    // Calculates the spacing count by dividing the number of leading spaces by 2.
    // This adjustment ensures a consistent and visually appealing spacing, regardless of minor irregularities in the original spacing.
    let repeatSpaceCount = match.spacing.count / 2
    spacingCount = CGFloat(repeatSpaceCount)
  }

  var body: some View {
    HStack {
      Spacer()
        .frame(width: Metrics.bulletPrefixSpacingPerOne * CGFloat(spacingCount) + Metrics.bulletSpacingAlpha)
      Label(
        title: { Text(verbatim: content) },
        icon: {
          Image(systemName: Constants.bulletImageName)
            .resizable()
            .scaledToFit()
            .frame(width: Metrics.bulletSize, height: Metrics.bulletSize)
        }
      )
      Spacer()
    }
  }
}

// MARK: - Metrics

private enum Metrics {
  // MARK: == padding ==

  static let horizontalPadding: CGFloat = 20
  static let verticalPadding: CGFloat = 16

  // MARK: == item ==

  static let bulletSize: CGFloat = 3
  static let bulletPrefixSpacingPerOne: CGFloat = 20
  static let bulletSpacingAlpha: CGFloat = 10
}

// MARK: - Constants

private enum Constants {
  static let bulletImageName: String = "circle.fill"
}
