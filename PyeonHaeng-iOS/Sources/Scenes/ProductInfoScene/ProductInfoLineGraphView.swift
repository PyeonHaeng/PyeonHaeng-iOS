//
//  ProductInfoLineGraphView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 1/31/24.
//

import DesignSystem
import Entity
import Log
import SwiftUI

// MARK: - ProductInfoLineGraphView

struct ProductInfoLineGraphView<ViewModel>: View where ViewModel: ProductInfoViewModelRepresentable {
  @EnvironmentObject private var viewModel: ViewModel

  @State private var offset: CGSize = .zero
  @State private var index: Int = 0
  @State private var frameSize: CGSize = .zero
  @State private var symbolLocations: [CGPoint] = []

  private var interval: CGFloat {
    frameSize.width / CGFloat(viewModel.state.previousProducts.count + 1)
  }

  private var previousDetailProductsCount: Int {
    viewModel.state.previousProducts.count
  }

  // MARK: - View

  var body: some View {
    GeometryReader { reader in
      VStack(spacing: Metrics.spacing) {
        TextView()
        ZStack {
          LineGraphView(locations: symbolLocations)
          LineGraphSymbolView(locations: symbolLocations)
          BackgroundGradientView(locations: symbolLocations, frameSize: frameSize)
        }
        .onAppear {
          frameSize = reader.size
          updateSymbolLocations(viewModel.state.previousProducts)
          offset = CGSize(
            width: symbolLocations[viewModel.state.previousProducts.count].x - (Metrics.panelWidth / 2),
            height: .zero
          )
          index = viewModel.state.previousProducts.count - 1
        }
        .gesture(DragGesture().onChanged { viewDidDrag($0) })
        .sensoryFeedback(trigger: offset) { _, _ in
          .impact()
        }
        .overlay(alignment: .bottomLeading) {
          LineGraphPanelView(
            position: (offset, index),
            products: viewModel.state.previousProducts
          )
        }
      }
      .padding(EdgeInsets(
        top: Metrics.paddingTop,
        leading: .zero,
        bottom: Metrics.paddingBottom,
        trailing: .zero
      ))
    }
    .frame(height: Metrics.frameHeight)
  }
}

private extension ProductInfoLineGraphView {
  func updateSymbolLocations(_ products: [DetailProduct]) {
    let prices = products.map(\.price)
    var locations = [CGPoint]()
    locations.append(CGPoint(x: .zero, y: Metrics.lineMaxHeightFromTop))

    if let maxPrice = prices.max(), maxPrice != 0 {
      for (index, price) in prices.enumerated() {
        let heightFactor = (1 - (CGFloat(price) / CGFloat(maxPrice))) * 4
        let pathHeight = Metrics.lineMaxHeightFromTop + Metrics.lineMaxHeightFromBottom * heightFactor
        let pathWidth = interval * CGFloat(index + 1)
        locations.append(CGPoint(x: pathWidth, y: pathHeight))
      }
    }

    locations.append(CGPoint(x: frameSize.width, y: Metrics.lineMaxHeightFromTop))
    symbolLocations = locations
  }

  func viewDidDrag(_ value: DragGesture.Value) {
    let index = max(min(Int((
      value.location.x / interval).rounded() - 1
    ), previousDetailProductsCount - 1), 0)
    self.index = index
    offset = CGSize(width: symbolLocations[index + 1].x - (Metrics.panelWidth / 2), height: 0)
  }
}

// MARK: - TextView

private struct TextView: View {
  var body: some View {
    Text("이전 행사 정보")
      .font(.title1)
      .foregroundStyle(.gray900)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

// MARK: - LineGraphView

private struct LineGraphView: View {
  let locations: [CGPoint]

  var body: some View {
    Path { $0.addLines(locations) }
      .stroke(.green500, style: StrokeStyle(lineWidth: 2.0))
  }
}

// MARK: - LineGraphSymbolView

private struct LineGraphSymbolView: View {
  let locations: [CGPoint]

  var body: some View {
    Path { path in
      for point in locations.dropFirst().dropLast() {
        var point = point
        point.x -= Metrics.symbolWidth / 2
        point.y -= Metrics.symbolWidth / 2
        path.addEllipse(in: CGRect(
          origin: point,
          size: CGSize(width: Metrics.symbolWidth, height: Metrics.symbolWidth)
        ))
      }
    }
    .fill(.green500)
    .stroke(.white, lineWidth: 1.0)
  }
}

// MARK: - LineGraphPanelView

private struct LineGraphPanelView: View {
  let position: (offset: CGSize, index: Int)
  let product: DetailProduct

  init(
    position: (offset: CGSize, index: Int),
    products: [DetailProduct]
  ) {
    self.position = position
    product = products[position.index]
  }

  var body: some View {
    VStack(spacing: .zero) {
      Text(verbatim: "\(formatted(product.date))")
        .font(.c4)
        .foregroundStyle(.gray400)
      Text("\(product.price.formatted())원")
        .frame(maxWidth: .infinity)
        .font(.b1)
        .foregroundStyle(.gray900)
      Rectangle()
        .foregroundStyle(.gray100)
        .frame(width: 1.0, height: Metrics.panelPoleHeight)
    }
    .frame(width: Metrics.panelWidth, height: Metrics.panelHeight)
    .offset(position.offset)
  }

  func formatted(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM"
    return formatter.string(from: date)
  }
}

// MARK: - BackgroundGradientView

private struct BackgroundGradientView: View {
  let locations: [CGPoint]
  let frameSize: CGSize

  var body: some View {
    LinearGradient(
      colors: [.green500.opacity(0.1), .clear],
      startPoint: .top,
      endPoint: .bottom
    )
    .clipShape(
      Path { path in
        path.move(to: .zero)
        path.addLines(locations)
        path.addLine(to: CGPoint(x: frameSize.width, y: frameSize.height))
        path.addLine(to: CGPoint(x: .zero, y: frameSize.height))
      }
    )
  }
}

// MARK: - Metrics

private enum Metrics {
  static let spacing: CGFloat = 4.0

  static let paddingTop = 4.0
  static let paddingBottom = 24.0

  static let lineMaxHeightFromTop: CGFloat = 87.0
  static let lineMaxHeightFromBottom: CGFloat = lineGraphHeight - lineMaxHeightFromTop
  static let symbolWidth: CGFloat = 4.0
  static let frameHeight: CGFloat = 226.0
  static let lineGraphHeight: CGFloat = 162.0

  static let panelWidth: CGFloat = 70.0
  static let panelHeight: CGFloat = 162.0
  static let panelPoleHeight: CGFloat = 122.0
}
