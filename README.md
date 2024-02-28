# OnlyPickOne - 이상형 월드컵 iOS 앱 출시 및 서비스
<div align="center">
<img width="1024" alt="image" src="https://github.com/110w110/110w110/assets/87888411/ea4fa14d-c71a-43ce-831c-11cf149d3f9d">
</div>

## 개요
iOS, Web Client, Server & DB 로 이루어진 3명의 팀 구성원이 진행하는 프로젝트입니다. 유저들이 자유롭게 업로드한 사진과 캡션을 무작위로 배정하여 반복적으로 1:1 매칭을 진행하는 게임입니다. 최종적으로 단 한 개의 선택지가 남으면 게임이 종료되며, 다른 유저들이 가장 많이 선택한 선택지를 비교하며 공유하고 즐길 수 있습니다. 현재 앱스토어에 성공적으로 출시되어 서비스되고 있습니다.

## 수행 기간
- 2023.9.5 - 프로젝트 설계 및 구현 시작
- 2023.12.4 - v.1.0.0 앱스토어 출시 완료

## 앱스토어
|:: 앱스토어 링크  |
|:------------|
|:: [OnlyPickOne Appstore Link](https://apps.apple.com/kr/app/onlypickone/id6469682692) |

## 패치노트
### v_1.0.0
- OnlyPickOne 서비스가 시작되었습니다.

### v_1.0.1
- 결과 공유하기 기능이 추가되었습니다.
- 게임 생성 UI가 변경 및 개선되었습니다.
- 게임 생성 중 아이템 삭제 방식이 '롱터치'로 변경되었습니다.
- 게임 신고 관련 안내가 추가되었습니다.
- 배너 광고가 추가되었습니다.
- 게임 정렬 기능이 추가되었습니다.
- 페이지네이션이 적용되었습니다.
- 검색 기능이 추가되었습니다.
- 회원가입 및 로그인 UI가 개선되었습니다.
- 일부 이미지가 업로드 되지 않는 이슈를 수정하였습니다.

### v_1.0.2
- 회원가입 시 인증번호 재전송 기능이 추가되었습니다.
- 게임 정보와 관련된 UI가 변경 및 개선되었습니다.
- 게임 별 조회수가 표시됩니다.
- 사진 별 설명을 추가하지 않고 게임을 생성할 수 있도록 변경되었습니다.
- 공지사항 메뉴가 추가되었습니다.
- 세로로 긴 이미지가 잘리지 않도록 수정되었습니다.

## 성과
### 앱 출시 완료
2024년 12월 4일 부로 AppStoreConnect에서 앱 심사 최종 승인 후 앱스토어에 출시가 완료되었습니다.
[앱스토어 바로가기 Link](https://apps.apple.com/kr/app/onlypickone/id6469682692)

### 앱스토어 노출 수
<div align="center">
<img width="480" alt="image" src="https://github.com/OnlyPickOne/onlypickone-ios/assets/87888411/d46296b7-d2c6-4994-b899-3557b91bbd2b">
</div>
현재 앱스토어 출시 이후로 꾸준한 페이지 노출 수를 나타내고 있습니다. 별도의 홍보나 프로모션 없이 순수하게 이상형 월드컵 등의 키워드로 조회되는 통계입니다.

### 다운로드 수
<div align="center">
<img width="480" alt="image" src="https://github.com/OnlyPickOne/onlypickone-ios/assets/87888411/f8b51077-c7d1-45c8-a96b-7793b44c2b61">
</div>
2월 기준 실제 앱스토어에서 다운로드 된 통계입니다. 별도의 홍보 없이도 매일 꾸준하게 다운로드가 되고 있음을 확인할 수 있습니다.

### 충돌 수
<div align="center">
<img width="480" alt="image" src="https://github.com/OnlyPickOne/onlypickone-ios/assets/87888411/2ecded23-6a2b-491e-8cf6-f854bafda39f">
</div>
통계를 내기 충분한 수의 회원이 사용했음에도 테스트 중에 발생했던 1회의 충돌 이외에 어떤 크래시도 발생하지 않았습니다.

### 유입 경로
<div align="center">
<img width="480" alt="image" src="https://github.com/OnlyPickOne/onlypickone-ios/assets/87888411/2a9cc1ea-4d8e-4931-9803-64b8105d3ba6">
</div>
앱스토어에서 이상형 월드컵 등을 검색하거나 앱스토어 앱 추천을 통해 유입되는 케이스가 꾸준하게 발생하는 것을 확인할 수 있습니다.

## 팀 구성
### Han Taehee
- iOS Development
- https://github.com/110w110
- 프로젝트 기획 및 설계, 전체 UI 디자인 및 구현, iOS 앱 개발 전체 과정 등

### Lee Hoseok
- Server, Infra, DB Development
- https://github.com/hoshogi
- DB 설계 및 Server 구현, 

## 기술 스택
### iOS
SwiftUI, MVVM, KingFisher, Moya, Combine, TestFlight, AppstoreConnect
### DB
MySQL, Redis 6.06
### Server
Java 11, Spring, SpringBoot 2.7.15, Spring Security, Swagger, JPA, EC2, RDS, S3
### etc
Figma, Zepline, Git, Github, Postman, Notion

## DB 설계
### E-R Diagram (23.10 기준)
<div align="center">
<img width="480" alt="image" src="https://github.com/OnlyPickOne/onlypickone-ios/assets/87888411/4cd60aa4-0c69-4a8a-a6b4-5cdbc991e818">
</div>

### DB Schema (23.10 기준)
<div align="center">
<img width="480" alt="image" src="https://github.com/OnlyPickOne/onlypickone-ios/assets/87888411/7bc85032-b9e5-4340-91d3-d14e9fd31b09">
</div>

## 서비스 이용 규칙 또는 약관
### 개인정보 처리방침
https://water-advantage-4b6.notion.site/8ff7ccd28d05427c85c5aacbc59cfe06?pvs=4

### 이용 약관
https://water-advantage-4b6.notion.site/7e7e7929ce6f4d6a88c6dcdb31e0fa12?pvs=4

