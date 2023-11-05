//
//  AddView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct AddView: View {
//    @State var isShowingAddSheet: Bool
    
    @ObservedObject var viewModel: AddSheetViewModel = AddSheetViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("""
                 아래의 내용을 확인하시고 서비스 이용 규칙을 준수해주시기 바랍니다.
                 
                 이용 제제의 대상
                 - 욕설 또는 강한 비속어
                 - 음란물 또는 불건전한 내용
                 - 논란이 될 수 있는 커뮤니티 용어
                 - 혐오 표현 또는 인종, 종교, 성별 등에 대한 차별적인 표현
                 - 특정 집단 또는 인물을 비하하는 표현
                 - 정치, 선동, 종교 또는 불법 사행성 도박 등에 대한 내용
                 - 개인의 신상 또는 저작권을 침해하는 컨텐츠
                 - 상업적인 목적 또는 개인 SNS 등을 홍보하기 위한 목적의 컨텐츠
                 - 기타 미풍양속을 저해하는 표현 또는 컨텐츠
                 
                 게시되는 컨텐츠는 실시간 모니터링을 통해 문제가 되는 컨텐츠를 즉각 삭제 처리 하고 있습니다. 단순 실수가 아닌 악의적 이용이 발견되는 사용자는 무관용 강제 퇴출 조치하고 있으므로 컨텐츠 업로드 시에 다시 한 번 검토하여 문제가 없도록 확인 부탁드립니다.
                 """)
                .font(.body)
                .minimumScaleFactor(0.5)
                .padding(15)
                
                Button {
                    viewModel.isShowingAddSheet = true
                } label: {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("동의하고 게임 생성하기")
                    }
                }
                .sheet(isPresented: $viewModel.isShowingAddSheet) {
                    AddSheetView(viewModel: viewModel)
                }
                .tint(Color("opoPink"))
                .padding()
            }
            .navigationTitle("게임 만들기")
            .navigationBarTitleDisplayMode(.inline)
            .tint(Color("opoPink"))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
