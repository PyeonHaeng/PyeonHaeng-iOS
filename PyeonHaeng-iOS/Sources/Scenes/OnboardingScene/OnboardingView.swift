//
//  OnboardingView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 82)
                Image("Onboarding01")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 275.55, height: 280)
                // 페이지컨트롤
                // 본문 제목
                Text("하나사면 하나더")
                    .textStyle(.h2)
                    .padding(.top, 20)

                // 본문 내용
                Text("""
                     다양한 편의점의 1+1, 2+1 행사 제품 정보로
                     알뜰하고 합리적으로 소비할수 있어요.
                    """)
                    .textStyle(.body2)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)

                Spacer()

                Button("다음") {
                    // 다음 버튼 동작
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.main500) // 임시 색상, 나중에 변경 가능
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)

                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: Text("건너뛰기")
                    .foregroundStyle(.main500))
            }
        }
    }
}

#Preview {
  OnboardingView()
}
