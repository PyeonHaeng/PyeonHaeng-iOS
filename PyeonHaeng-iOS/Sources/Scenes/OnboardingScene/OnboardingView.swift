//
//  OnboardingView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import SwiftUI

// 온보딩 페이지 정보를 관리하는 enum
enum OnboardingPage: Int, CaseIterable {
    case first, second

    var title: String {
        switch self {
        case .first:
            return "하나사면 하나 더"
        case .second:
            return "수많은 혜택을 한곳에서"
        }
    }

    var body: String {
        switch self {
        case .first:
            return """
                   다양한 편의점의 1+1, 2+1 행사 제품 정보로
                   알뜰하고 합리적으로 소비할수 있어요.
                   """
        case .second:
            return """
                   세븐일레븐, CU, 이마트 24, GS 25, 미니스톱의
                   수많은 행사정보를 ‘편행’한곳에서 만나보세요.
                   """
        }
    }

    var imageName: String {
        switch self {
        case .first:
            return "Onboarding01"
        case .second:
            return "Onboarding02"
        }
    }
}

struct OnboardingView: View {
    
    @State private var currentPage = 0

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(OnboardingPage.allCases.indices, id: \.self) { index in
                        let page = OnboardingPage(rawValue: index) ?? OnboardingPage.first
                        VStack {
                            Spacer().frame(height: page == .first ? 82 : 139)
                            Image(page.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                // 커스텀 페이지 컨트롤
                CustomPageControl(currentPage: $currentPage, pageCount: 2)
                    .padding(.vertical)

                // 본문 제목
                Text(OnboardingPage(rawValue: currentPage)?.title ?? "")
                    .textStyle(.h2)
                Spacer().frame(height: 16)

                // 본문 내용
                Text(OnboardingPage(rawValue: currentPage)?.body ?? "")
                    .textStyle(.body2)
                    .foregroundStyle(.gray500)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)

                Spacer().frame(height: 84)

                Button(action: {
                    if currentPage < OnboardingPage.allCases.count - 1 {
                        currentPage += 1
                    }
                }) {
                    Text(currentPage < OnboardingPage.allCases.count - 1 ? "다음" : "편행 시작하기")
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
