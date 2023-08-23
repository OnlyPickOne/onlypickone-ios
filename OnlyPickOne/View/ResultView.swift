//
//  ResultView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        List {
            Section("내 결과") {
                Text("2023 망한/웃긴/귀여운 고양이 사진 월드컵")
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .listRowSeparator(.hidden)
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("침착맨")
                            .font(.caption2)
                            .fontWeight(.light)
                        Spacer()
                        Text("1 month ago")
                            .font(.caption2)
                            .fontWeight(.light)
                    }
                    
                    Text("안녕하세요. 망한/웃긴/귀여운 고양이들 사진중 원하는 사진을 고르시면 됩니다. 중복이 있으면 바로말해주세요. (자료출처: 구글 이미지, 유튜브 타임스낵과 다양한 동물의 짤, 네이버 카페, 인스타그램, 제작자) (업데이트: ○)")
                        .font(.caption)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                }
                .listRowSeparator(.hidden)
                
                
                HStack {
                    Spacer()
                    Image(systemName: "trophy.fill")
                        .foregroundColor(.yellow)
                    Text("우승")
                        .font(.headline)
                    Image(systemName: "trophy.fill")
                        .foregroundColor(.yellow)
                    Spacer()
                }
                .listRowSeparator(.hidden)
                
                Image("cat2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .listRowSeparator(.hidden)
                
                HStack {
                    Spacer()
                    Text("4강")
                        .font(.subheadline)
                    Spacer()
                }
                .listRowSeparator(.hidden)
                
                HStack {
                    Image("cat1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("cat1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("cat1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .listRowSeparator(.hidden)
            }
            Section("전체 통계") {
                ForEach((0..<10), id: \.self) { index in
                    HStack {
                        Image("cat1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120)
                        VStack(alignment: .leading) {
                            Text("푸마")
                                .font(.headline)
                                .padding(2)
                            Text("64%")
                                .font(.subheadline)
                                .padding(2)
                        }
                        .padding(10)
                    }
                }
            }
        }
        .navigationTitle("최종 결과")
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
