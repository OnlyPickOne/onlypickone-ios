//
//  NoticeView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/01/31.
//

import SwiftUI

struct NoticeView: View {
    @ObservedObject var adminDecoder = JWTDecoder()
    @ObservedObject var viewModel: NoticeViewModel
    
    var noticeId: Int = 1
        
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.notice.title ?? "")
                    .font(.headline)
                Text(viewModel.notice.createdAt?.toLastTimeString() ?? "")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Text(viewModel.notice.content ?? "")
                .padding(.vertical, 20)
            }
            .padding(5)
        }
        .navigationTitle("공지사항")
        .toolbar {
            if adminDecoder.isAdmin == true {
                NavigationLink {
                    NoticeSettingView(titleInput: "온리픽원 서비스 이용 안내", contentInput: """
안녕하세요.
온리픽원 운영진입니다.

온리픽원 서비스 이용 안내입니다.
황선홍호는 이번 대회에서 최고의 경기력을 과시했다. 대회 전 대표 선수 자격 문제로 엔트리 제외, 이강인 차출 문제, A대표팀 겹치기 차출 논란 등에 연결되며 어려움을 겪었던 황선홍호는 예상과 달리 8강까지 그야말로 완벽한 행보를 보였다. 쿠웨이트와의 조별리그 첫 경기에서 정우영의 해트트릭을 앞세워 9대0 대승을 거둔 한국은 이어진 태국과의 경기에서도 로테이션을 가동한 가운데 4대0 완승을 챙겼다. 마지막 바레인전까지 3대0 승리를 거둔 황선홍호는 조별리그를 3전승, 16골-무실점, 완벽하게 마무리했다.

복병으로 평가받은 키르기스스탄과의 16강전, 역시 5대1 승리를 거뒀다. 이번 대회 첫 실점이 옥에 티였다. 완승에도 불구하고 아쉬움이 남았던 경기, 다음 상대는 개최국 중국이었다. 자칫 심판 판정과 텃세, 분위기 등에서 꼬일 수도 있다는 이야기가 나왔지만, 홍현석(헨트)의 환상 프리킥과 송민규(전북 현대)의 대회 첫 골로 2대0 완승을 거뒀다. 이번 대회에서 가장 적은 골차 승리였지만, 내용은 그야말로 한수 가르쳐줬다는 표현이 맞을 정도로, 상대를 압도했다. 조별리그부터 8강전까지 황 감독이 준비한 빠른 트랜지션과 쉬지 않는 포지션 체인지, 쉴틈 없는 뒷공간 침투와 지체없는 전진패스, 다양한 세트피스 등이 완벽히 통했다. 황 감독은 선수 기용부터 교체까지 세밀한 전략으로 완벽한 운용을 펼쳤다.

황선홍호는 이번 대회에서 최고의 경기력을 과시했다. 대회 전 대표 선수 자격 문제로 엔트리 제외, 이강인 차출 문제, A대표팀 겹치기 차출 논란 등에 연결되며 어려움을 겪었던 황선홍호는 예상과 달리 8강까지 그야말로 완벽한 행보를 보였다. 쿠웨이트와의 조별리그 첫 경기에서 정우영의 해트트릭을 앞세워 9대0 대승을 거둔 한국은 이어진 태국과의 경기에서도 로테이션을 가동한 가운데 4대0 완승을 챙겼다. 마지막 바레인전까지 3대0 승리를 거둔 황선홍호는 조별리그를 3전승, 16골-무실점, 완벽하게 마무리했다.

복병으로 평가받은 키르기스스탄과의 16강전, 역시 5대1 승리를 거뒀다. 이번 대회 첫 실점이 옥에 티였다. 완승에도 불구하고 아쉬움이 남았던 경기, 다음 상대는 개최국 중국이었다. 자칫 심판 판정과 텃세, 분위기 등에서 꼬일 수도 있다는 이야기가 나왔지만, 홍현석(헨트)의 환상 프리킥과 송민규(전북 현대)의 대회 첫 골로 2대0 완승을 거뒀다. 이번 대회에서 가장 적은 골차 승리였지만, 내용은 그야말로 한수 가르쳐줬다는 표현이 맞을 정도로, 상대를 압도했다. 조별리그부터 8강전까지 황 감독이 준비한 빠른 트랜지션과 쉬지 않는 포지션 체인지, 쉴틈 없는 뒷공간 침투와 지체없는 전진패스, 다양한 세트피스 등이 완벽히 통했다. 황 감독은 선수 기용부터 교체까지 세밀한 전략으로 완벽한 운용을 펼쳤다.
""")
                } label: {
                    Text("수정")
                }
            }
        }
    }
    
    init(noticeId: Int) {
        self.viewModel = NoticeViewModel(noticeId: noticeId)
        self.noticeId = noticeId
    }
}

//struct NoticeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
