<p align=center><image src="https://github.com/PyeonHaeng/PyeonHaeng-iOS/assets/57972338/0ad6c578-8a3c-4bc3-a970-0c51818cdd06" height="256" /></p>

<h1 align="center">편의점 행사 정보는 어디서? | 편행</h1>

<p align="center">
  <img alt="" src="https://img.shields.io/badge/Xcode-v15.0.1-white?style=for-the-badge&logo=xcode">
  <img alt="" src="https://img.shields.io/badge/Swift-v5.9-red?style=for-the-badge&logo=swift">
  <img alt="" src="https://img.shields.io/badge/iOS-17.0-red?style=for-the-badge&logo=apple">
  <img alt="" src="https://img.shields.io/github/v/release/PyeonHaeng/PyeonHaeng-iOS?style=for-the-badge">
</p>

<p align="center">편의점에서 음료를 사거나, 라면을 살 때, 내지는 과자를 사고 싶을 때.</p>
<p align="center">편의점 할인행사를 알고 싶지만, 일일이 편의점 사이트를 찾아 알아보기 귀찮을 때.</p>
<p align="center"><b>한 눈에 여러 편의점의 행사 정보를 확인할 수 있는 앱</b>입니다.</p>

![Introduction Image](https://github.com/PyeonHaeng/PyeonHaeng-iOS/assets/57972338/deb422bb-48e5-4000-897b-cca538ef4f7a)

## Architecture

![image](https://github.com/PyeonHaeng/PyeonHaeng-iOS/assets/57972338/521a9431-b167-43b0-b6c8-75b370699a53)

코드를 각 기능에 맞게 분리하면서 효율성과 확장성을 높이고자 **Swift Package로 모듈화**를 진행했습니다.

실제 개발 과정에서 디자인 시스템의 컴포넌트를 확인하고자 새로운 App Target을 생성해야 하는 과정이 있었습니다.
모듈화가 되지 않았다면, **기존 코드를 복사하여 붙여넣는 작업을 반복해야 했을 것**입니다.
하지만 모듈화된 아키텍처 덕분에 **해당 모듈을 라이브러리로 참조하는 방식으로 손쉽게 구현**할 수 있었습니다.

## Flow

#### View - ViewModel 구조

![image](https://github.com/PyeonHaeng/PyeonHaeng-iOS/assets/57972338/ed9da970-a4eb-4e62-a11b-c4a46b69c0ab)

큰 프로젝트가 아니어서 별도의 아키텍처를 고려하지 않았고, 단순 **View와 ViewModel을 활용**하였습니다.
`State`값을 Output으로 사용하고, `trigger(_:)`로 Input을 전달하는 **단방향 흐름으로 구성된 아키텍처**라고 볼 수 있습니다.

특히 ViewModel을 protocol로 처리하여 View가 구체 타입을 알지 못하도록 하였고, 덕분에 DIP 원칙을 지킴과 동시에 테스트 용이성을 보장했습니다.

#### Data Flow

![image](https://github.com/PyeonHaeng/PyeonHaeng-iOS/assets/57972338/20650029-341e-4995-919f-05473e358b3c)

View, ViewModel 그리고 네트워킹을 다루는 Service를 통해 레이어를 분리했습니다.

덕분에 각 기능의 역할을 명확히 할 수 있었고, 버그 발생 시 관련 레이어에 집중함으로써 디버깅을 효율적으로 할 수 있었습니다.

특히 백엔드의 API가 구현되지 않을 경우를 대비하여 **URLProtocol**과 가상의 **Mock JSON**을 파싱해 뷰를 그릴 수 있도록 구현하였습니다.

## Members

| [🧑🏻‍💻홍승현](https://github.com/WhiteHyun) | [🧑🏻‍💻김응철](https://github.com/Eung7) | [🧑🏻‍💻방현석](https://github.com/isGeekCode) |
| :--------------------------------------: | :----------------------------------: | :---------------------------------------: |
|  ![](https://github.com/WhiteHyun.png)   |  ![](https://github.com/Eung7.png)   |  ![](https://github.com/isGeekCode.png)   |
