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
  @State var prices: [Int] = [1000, 1200, 1050]

  @State private var width: CGFloat = .zero
  @State private var height: CGFloat = .zero
  @State private var offset: CGSize = .zero
  
  private var interval: CGFloat {
    width / CGFloat(prices.count + 1)
  }
  
  private var points: [CGPoint] {
    var points = [CGPoint]()
    points.append(CGPoint(x: .zero, y: Metrics.maxHeight))
    for (index, price) in prices.enumerated() {
      var progress = (CGFloat(price) / CGFloat(prices.max() ?? 0))
      progress *= progress == 1 ? 1.0 : 0.8
      let pathHeight = Metrics.maxHeight + (1 - progress) * Metrics.maxHeight
      let pathWidth = interval * CGFloat(index + 1)
      points.append(CGPoint(x: pathWidth, y: pathHeight))
    }
    points.append(CGPoint(x: width, y: Metrics.maxHeight))
    return points
  }
  
  // MARK: - View
  
  var body: some View {
    GeometryReader { reader in
      ZStack {
        Path { $0.addLines(points) }
          .stroke(.green500, style: StrokeStyle(lineWidth: 2.0))
        
        Path { path in
          points.dropFirst().dropLast().forEach { point in
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
        
        LinearGradient(stops: [
          Gradient.Stop(color: .green500.opacity(0.1), location: 0.0),
          Gradient.Stop(color: .green500.opacity(0), location: 1.0),
        ], startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
        .clipShape(
          Path { path in
            path.addLines(points)
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint.zero)
            path.addLine(to: points.first!)
          }
        )
      }
      .gesture(DragGesture().onChanged { value in
        let translation = value.location.x
        let index = max(min(Int((translation / interval).rounded() - 1), prices.count - 1), 0)
        offset = CGSize(width: points[index].x - Metrics.panelWidth / 2, height: 0)
      })
      .overlay(alignment: .bottomLeading) {
        VStack(spacing: 0) {
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
        .frame(width: Metrics.panelWidth, height: Metrics.panelHeight)
        .offset(offset)
      }
      .onAppear {
        width = reader.size.width
        height = reader.size.height
        offset = CGSize(width: points.dropLast().last!.x - Metrics.panelWidth / 2, height: 0)
      }
    }
    .frame(height: Metrics.frameHeight)
  }
}

// MARK: ProductInfoLineGraphView.Metrics

private extension ProductInfoLineGraphView {
  enum Metrics {
    static let maxHeight: CGFloat = 87.0
    static let symbolWidth: CGFloat = 4.0
    static let frameHeight: CGFloat = 162.0
    
    static let panelWidth: CGFloat = 55.0
    static let panelHeight: CGFloat = 162.0
    static let panelPoleHeight: CGFloat = 122.0
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ProductInfoLineGraphView()
}
