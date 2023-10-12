//
//  ListView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct ListView: View {
    @State var isModal: Bool = false
    @ObservedObject private var viewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach((0..<(viewModel.newGameList.content?.count ?? 0)), id: \.self) { index in
                        NavigationLink {
                            GameInfoView()
                        } label: {
                            VStack(alignment: .leading) {
                                Text("\(viewModel.newGameList.content?[index].title ?? "unknown game")")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .lineLimit(2)
                                HStack(spacing: 15) {
                                    HStack(spacing: 0) {
                                        Image("cat1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 80)
                                            .clipped()
                                        Image("cat2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 80)
                                            .clipped()
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        HStack {
                                            Spacer()
                                            Text(viewModel.gameList[index].createdTime?.toLastTimeString() ?? "")
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.trailing)
                                        }
                                        Spacer()
                                        Text("\(viewModel.newGameList.content?[index].description ?? "please refresh or restart the application")")
                                            .font(.caption)
                                            .fontWeight(.light)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(4)
                                            .frame(height: 64)
                                        Spacer()
                                    }
                                }
                            }
                            .padding(5)
                        }
                    }
                }
                .navigationTitle("OnlyPickOne")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Menu("정렬") {
                        Text("최신순")
                        Text("조회순")
                        Text("최다플레이순")
                    }
                }
                .refreshable {
                    print("새로고침 - 게임 리스트 호출")
                }
                .tint(Color("opoPink"))
            }
        }
        .onAppear() {
            print("토큰 여부 확인해서 게임 리스트 호출")
            viewModel.fetchGameList()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
