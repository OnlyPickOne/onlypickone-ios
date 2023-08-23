//
//  ListView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct ListView: View {
    @State var isModal: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach((0..<10), id: \.self) { index in
                    NavigationLink {
                        GameView()
                            .navigationTitle("2023 망한/웃긴/귀여운 고양이 사진 월드컵")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        VStack(alignment: .leading) {
                            Text("2023 망한/웃긴/귀여운 고양이 사진 월드컵")
                                .font(.headline)
                                .fontWeight(.medium)
                                .lineLimit(2)
                            HStack(spacing: 15) {
                                Image("thumbnail")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 48, height: 48)
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("침착맨")
                                            .font(.caption2)
                                            .fontWeight(.light)
                                        Spacer()
                                        Text("\(index) month ago")
                                            .font(.caption2)
                                            .fontWeight(.light)
                                    }
                                    Text("안녕하세요. 망한/웃긴/귀여운 고양이들 사진중 원하는 사진을 고르시면 됩니다. 중복이 있으면 바로말해주세요. (자료출처: 구글 이미지, 유튜브 타임스낵과 다양한 동물의 짤, 네이버 카페, 인스타그램, 제작자) (업데이트: ○)")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(3)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("이상형 월드컵")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Menu("정렬") {
                    Text("최신순")
                    Text("조회순")
                    Text("최다플레이순")
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
