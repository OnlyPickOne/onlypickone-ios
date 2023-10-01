//
//  ListView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct ListView: View {
    @State var isModal: Bool = false
    @ObservedObject private var viewModel = ListViewModel(testString: "")
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach((0..<viewModel.gameList.count), id: \.self) { index in
                        NavigationLink {
                            GameInfoView()
                        } label: {
                            VStack(alignment: .leading) {
                                Text(viewModel.testString)
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
                                        Text(viewModel.gameList[index].description ?? "")
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
                .tint(Color("opoPink"))
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
