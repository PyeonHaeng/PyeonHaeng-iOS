//
//  OnboardingView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var currentPage = 0

    // 본문 제목과 내용을 동적으로 변경하기 위한 @State 변수
    @State private var titleText = "하나사면 하나더"
    @State private var bodyText = """
                                   다양한 편의점의 1+1, 2+1 행사 제품 정보로
                                   알뜰하고 합리적으로 소비할수 있어요.
                                  """

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $currentPage) {
                    // 첫 번째 페이지
                    VStack {
                        Spacer().frame(height: 82)
                        Image("Onboarding01")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 275.55, height: 280)
                        Spacer()
                    }
                    .tag(0)

                    // 두 번째 페이지
                    VStack {
                        Spacer().frame(height: 139)
                        Image("Onboarding02")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 320, height: 197.11)
                        Spacer()
                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: currentPage, {
                    updateTexts(for: currentPage)
                })

                // 커스텀 페이지 컨트롤
                CustomPageControl(currentPage: $currentPage, pageCount: 2)
                    .padding(.vertical)

                // 본문 제목
                Text(titleText)
                    .textStyle(.h2)
                Spacer().frame(height: 16)

                // 본문 내용
                Text(bodyText)
                    .textStyle(.body2)
                    .foregroundStyle(.gray500)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)

                Spacer().frame(height: 84)

                Button(action: {
                    if currentPage < 1 {
                        currentPage += 1
                    }
                }) {
                    Text(currentPage < 1 ? "다음" : "편행 시작하기")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.main500)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 8)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Text("건너뛰기")
                .foregroundColor(.main500))
        }
    }
    
    /// currentPage 값에 따라 본문 제목과 내용을 업데이트하는 함수
    func updateTexts(for page: Int) {
        if page == 0 {
            titleText = "하나사면 하나더"
            bodyText = """
                       다양한 편의점의 1+1, 2+1 행사 제품 정보로
                       알뜰하고 합리적으로 소비할수 있어요.
                       """
        } else if page == 1 {
            titleText = "수많은 혜택을 한곳에서"
            bodyText = """
                       세븐일레븐, CU, 이마트 24, GS 25, 미니스톱의
                       수많은 행사정보를 ‘편행’한곳에서 만나보세요.
                       """
        }
    }
}

struct CustomPageControl: View {
    @Binding var currentPage: Int
    var pageCount: Int
    
    var body: some View {
        HStack {
            ForEach(0..<pageCount, id: \.self) { index in
                if currentPage == index {
                    Rectangle()
                        .frame(width: 24, height: 6)
                        .foregroundColor(.main500)
                        .transition(.scale)
                } else {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.gray)
                        .transition(.scale)
                }
            }
        }
        // 페이지 변경 시 애니메이션 효과
        .animation(.default, value: currentPage)
    }
}

#Preview {
  OnboardingView()
}
