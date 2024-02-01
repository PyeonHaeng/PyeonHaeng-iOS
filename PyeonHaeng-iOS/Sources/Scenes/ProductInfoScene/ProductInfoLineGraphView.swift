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
  /// 임시데이터입니다. 이 데이터는 곧 편의점 상품 데이터로 교체됩니다.
  private let prices: [Int] = [1000, 1200, 1050]
  
  /// 가격과 날짜 정보가 표시되는 `Indicator`의 위치 값입니다.
  @State var offset: CGSize = .zero
  
  var body: some View {
    GeometryReader { reader in
      // 뷰의 프레임 크기 정보
      let height = reader.size.height
      let width = reader.size.width
      // 그래프가 올라올 수 있는 최대 높이
      let maxHeight: CGFloat = 87.0
      // 제일 높은 가격 데이터
      let maxPrice: CGFloat = .init(prices.max() ?? 0)
      // 가격 데이터간의 너비 간격
      let interval = reader.size.width / CGFloat(prices.count + 1)
      // 각 데이터의 위치 값을 나타내는 CGPoint
      let startPoint = CGPoint(x: .zero, y: maxHeight)
      let endPoint = CGPoint(x: width, y: maxHeight)
      let points: [CGPoint] = prices.enumerated().map { index, price -> CGPoint in
        var progress = (CGFloat(price) / maxPrice)
        progress *= progress == 1 ? 1.0 : 0.8
        let pathHeight = maxHeight + (1 - progress) * maxHeight
        let pathWidth = interval * CGFloat(index + 1)
        return CGPoint(x: pathWidth, y: pathHeight)
      }
      
      ZStack {
        // 그래프를 그립니다.
        Path { path in
          path.move(to: startPoint)
          path.addLine(to: points.first!)
          path.addLines(points)
          path.addLine(to: endPoint)
        }
        .stroke(.green500, style: StrokeStyle(lineWidth: 2.0))
        
        // 그래프 데이터 위 표시되는 동그라미
        SymbolShape(points: points)
          .fill(.green500)
          .stroke(.white, lineWidth: 1.0)
        
        // 그라데이션 백그라운드 컬러
        LinearGradient(stops: [
          Gradient.Stop(color: .green500.opacity(0.1), location: 0.00),
          Gradient.Stop(color: .green500.opacity(0), location: 1.00),
        ], startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
        .clipShape(
          Path { path in
            path.move(to: CGPoint(x: 0, y: height))
            path.addLine(to: startPoint); path.addLine(to: points.first!)
            path.addLines(points)
            path.addLine(to: endPoint)
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
          }
        )
      }
      .gesture(DragGesture().onChanged { value in
        let translation = value.location.x
        let index = max(min(Int((translation / interval).rounded() - 1), prices.count - 1), 0)
        offset = CGSize(width: points[index].x - 27.5, height: 0)
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
            .frame(width: 1.0, height: 122.0)
        }
        .frame(width: 55.0, height: 162.0)
        .offset(offset == .zero ? CGSize(width: points.last!.x - 27.5, height: 0) : offset)
      }
    }
    .frame(height: 162.0)
  }
}

// MARK: - SymbolShape

struct SymbolShape: Shape {
  let points: [CGPoint]
  
  func path(in _: CGRect) -> Path {
    var path = Path()
    for point in points {
      var point = point
      point.x -= 2; point.y -= 2
      path.addEllipse(in: CGRect(origin: point, size: CGSize(width: 4.0, height: 4.0)))
    }
    return path
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ProductInfoLineGraphView()
}
