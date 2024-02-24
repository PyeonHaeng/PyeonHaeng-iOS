//
//  ProductInfoLineGraphView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 1/31/24.
//

import DesignSystem
import SwiftUI

// MARK: - ProductInfoLineGraphView

struct ProductInfoLineGraphView: View {
  // MARK: - Properties

  /// 임시데이터입니다. 이 데이터는 곧 편의점 상품 데이터로 교체됩니다.
  @State var prices: [Int]

  @State private var isFirstRender: Bool = false
  @State private var offset: CGSize = .zero

  // MARK: - View

  var body: some View {
    GeometryReader { reader in
      let size = reader.size
      let interval = size.width / CGFloat(prices.count + 1)
      let points = calculatePoints(interval: interval, width: size.width)
      
      VStack(spacing: Metrics.spacing) {
        TextView()
        ZStack {
          LineGraphView(points: points)
          LineGraphSymbolView(points: points)
          BackgroundGradientView(points: points, size: size)
        }
        .gesture(DragGesture().onChanged { value in
          let index = max(min(Int((value.location.x / interval).rounded() - 1), prices.count - 1), 0)
          offset = CGSize(width: points[index + 1].x - (Metrics.panelWidth / 2), height: 0)
        })
        .overlay(alignment: .bottomLeading) {
          LineGraphPanelView()
        }
        .frame(width: Metrics.panelWidth, height: Metrics.panelHeight)
        .offset(offset)
      }
      .onAppear {
        isFirstRender = true
      }
      .onChange(of: isFirstRender) {
        guard isFirstRender else { return }
        if let lastPoint = points.dropLast().last {
          offset = CGSize(width: lastPoint.x - (Metrics.panelWidth / 2), height: 0)
        } else {
          // TODO: 이전 행사 내역이 하나도 없을 때, UI를 숨길 것인지, 아니면 다른 조치 방법이 있는지?
        }
      }
    }
    .padding(EdgeInsets(top: 4.0, leading: .zero, bottom: 24.0, trailing: .zero))
    .frame(height: Metrics.frameHeight)
  }
  
  private func calculatePoints(interval: CGFloat, width: CGFloat) -> [CGPoint] {
    var points = [CGPoint]()
    points.append(CGPoint(x: .zero, y: Metrics.lineMaxHeightFromTop))

    if let maxPrice = prices.max(), maxPrice != 0 {
      for (index, price) in prices.enumerated() {
        let heightFactor = 1 - (CGFloat(price) / CGFloat(maxPrice))
        let pathHeight = Metrics.lineMaxHeightFromTop + Metrics.lineMaxHeightFromBottom * heightFactor
        let pathWidth = interval * CGFloat(index + 1)
        points.append(CGPoint(x: pathWidth, y: pathHeight))
      }
    }

    points.append(CGPoint(x: width, y: Metrics.lineMaxHeightFromTop))
    return points
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

private struct LineGraphView: View {
  let points: [CGPoint]
  
  var body: some View {
    Path { path in
      path.addLines(points)
    }
    .stroke(.green500, style: StrokeStyle(lineWidth: 2.0))
  }
}

private struct LineGraphSymbolView: View {
  let points: [CGPoint]
  @State var offset: CGSize = .zero
  
  var body: some View {
    Path { path in
      for point in points.dropFirst().dropLast() {
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

private struct LineGraphPanelView: View {
  var body: some View {
    VStack(spacing: .zero) {
      Text(verbatim: "2023.11")
        .font(.c4)
        .foregroundStyle(.gray400)
      Text(verbatim: "1,250원")
        .font(.b1)
        .foregroundStyle(.gray900)
      Rectangle()
        .foregroundStyle(.gray100)
        .frame(width: 1.0, height: Metrics.panelPoleHeight)
    }
  }
}

// MARK: - BackgroundGradientView

private struct BackgroundGradientView: View {
  let points: [CGPoint]
  let size: CGSize

  var body: some View {
    LinearGradient(
      colors: [.green500.opacity(0.1), .clear],
      startPoint: .top,
      endPoint: .bottom
    )
    .clipShape(
      Path { path in
        path.move(to: .zero)
        path.addLines(points)
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.addLine(to: CGPoint(x: .zero, y: size.height))
      }
    )
  }
}

// MARK: - Metrics

private enum Metrics {
  static let spacing: CGFloat = 4.0

  static let lineMaxHeightFromTop: CGFloat = 87.0
  static let lineMaxHeightFromBottom: CGFloat = lineGraphHeight - lineMaxHeightFromTop
  static let symbolWidth: CGFloat = 4.0
  static let frameHeight: CGFloat = 226.0
  static let lineGraphHeight: CGFloat = 162.0

  static let panelWidth: CGFloat = 55.0
  static let panelHeight: CGFloat = 162.0
  static let panelPoleHeight: CGFloat = 122.0
}

#Preview(traits: .sizeThatFitsLayout) {
  ProductInfoLineGraphView(prices: [1, 2])
}
