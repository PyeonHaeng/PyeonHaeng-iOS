//
//  ProductInfoLineGraphView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 1/31/24.
//

import SwiftUI

struct ProductInfoLineGraphView: View {
  var body: some View {
    GeometryReader { reader in
      ZStack {
        Text("LineGraphView")
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

#Preview {
  ProductInfoLineGraphView()
}
