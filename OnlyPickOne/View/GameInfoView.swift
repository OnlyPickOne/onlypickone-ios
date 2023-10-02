//
//  GameInfoView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/05.
//

import SwiftUI

struct GameInfoView: View {
    var options = ["8강", "16강", "32강", "64강", "128강", "256강"]
    @State private var selectionOption = 0
    
    var body: some View {
        List {
            Section("게임 설명") {
                Text("안녕하세요. 망한/웃긴/귀여운 고양이 사진 중 원하는 사진을 고르시면 됩니다. 중복이 있으면 바로 말해주세요. 추가를 원하는 사진이 있으시면 건의 해주세요. 저작권 문제가 있는 사진은 제거하였습니다. (자료 출처: 구글 이미지)")
                    .font(.subheadline)
            }
            
            Section("예시 사진") {
                GeometryReader { geometry in
                    HStack(spacing: 10) {
                        Image("street")
                            .resizable()
                            .scaledToFill()
                            .frame(width: (geometry.size.width - 20) * (1/3), height: geometry.size.height)
                            .clipped()
                        Image("cat1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: (geometry.size.width - 20) * (1/3), height: geometry.size.height)
                            .clipped()
                        Image("cat2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: (geometry.size.width - 20) * (1/3), height: geometry.size.height)
                            .clipped()
                    }
                }
                .frame(height: 160)
            }
            
            Section("게임 플레이") {
                Button {
                    print("좋아요")
                } label: {
                    Text("좋아요")
                }
                .foregroundColor(Color(uiColor: .label))
                
                Button {
                    print("신고하기")
                } label: {
                    Text("신고하기")
                }
                .foregroundColor(Color(uiColor: .label))
                
                Picker("토너먼트 선택", selection: $selectionOption) {
                    ForEach(0 ..< options.count) {
                        Text(options[$0])
                    }
                }
                
                NavigationLink {
                    GameView()
                        .navigationTitle("2023 망한/웃긴/귀여운 고양이 사진 월드컵")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("게임 시작")
            

            }
        }
    }
}

struct GameInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GameInfoView()
    }
}
