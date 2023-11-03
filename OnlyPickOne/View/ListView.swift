//
//  ListView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI
import Kingfisher
import GoogleMobileAds

struct ListView: View {
    @State var isModal: Bool = false
    @ObservedObject private var viewModel: ListViewModel
    @ObservedObject var adminDecoder = JWTDecoder()
    
    @ViewBuilder func admob() -> some View {
        GADBanner().frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach((0..<(viewModel.newGameList.content?.count ?? 0)), id: \.self) { index in
                            NavigationLink {
                                GameInfoView(gameId: index, game: viewModel.newGameList.content?[index])
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("\(viewModel.newGameList.content?[index].title ?? "unknown game")")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .lineLimit(2)
                                    HStack(spacing: 15) {
                                        HStack(spacing: 0) {
                                            KFImage(URL(string: "\(viewModel.newGameList.content?[index].imageUrls?[0] ?? "")"))
                                                .placeholder { //플레이스 홀더 설정
                                                    Image(systemName: "list.dash")
                                                }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                                .onSuccess {r in //성공
                                                    print("succes: \(r)")
                                                }
                                                .onFailure { e in //실패
                                                    print("failure: \(e)")
                                                }
                                                .startLoadingBeforeViewAppear()
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 40, height: 80)
                                                .clipped()
                                            KFImage(URL(string: "\(viewModel.newGameList.content?[index].imageUrls?[1] ?? "")"))
                                                .placeholder { //플레이스 홀더 설정
                                                    Image(systemName: "list.dash")
                                                }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                                .onSuccess {r in //성공
                                                    print("succes: \(r)")
                                                }
                                                .onFailure { e in //실패
                                                    print("failure: \(e)")
                                                }
                                                .startLoadingBeforeViewAppear()
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 40, height: 80)
                                                .clipped()
                                        }
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("\(viewModel.newGameList.content?[index].description ?? "please refresh or restart the application")")
                                                .font(.caption)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(4)
                                                .frame(height: 32)
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Text(viewModel.newGameList.content?[index].createdAt?.toLastTimeString() ?? "")
                                                    .font(.caption)
                                                    .fontWeight(.light)
                                                    .multilineTextAlignment(.trailing)
                                            }
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
//                    .toolbar {
//                        Menu("정렬") {
//                            Text("최신순")
//                            Text("조회순")
//                            Text("최다플레이순")
//                        }
//                    }
                    .refreshable {
                        viewModel.fetchGameList()
                    }
                    .tint(Color("opoPink"))
                }
                
//                if adminDecoder.isAdmin == false {
//                    admob()
//                }
            }
        }
//        .searchable(text: $viewModel.searchKeyword, placement: .navigationBarDrawer,
//                    prompt: "제목 또는 키워드를 입력해주세요")
        .onAppear() {
            viewModel.fetchGameList()
        }
    }
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
}

struct MyGameListView: View {
    @State var isModal: Bool = false
    @ObservedObject private var viewModel = ListViewModel()
    @ObservedObject var adminDecoder = JWTDecoder()
    
    @ViewBuilder func admob() -> some View {
        GADBanner().frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
    }
    
    var body: some View {
        VStack {
            ZStack {
                List {
                    ForEach((0..<(viewModel.newGameList.content?.count ?? 0)), id: \.self) { index in
                        NavigationLink {
                            GameInfoView(gameId: index, game: viewModel.newGameList.content?[index])
                        } label: {
                            VStack(alignment: .leading) {
                                Text("\(viewModel.newGameList.content?[index].title ?? "unknown game")")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .lineLimit(2)
                                HStack(spacing: 15) {
                                    HStack(spacing: 0) {
                                        KFImage(URL(string: "\(viewModel.newGameList.content?[index].imageUrls?[0] ?? "")"))
                                            .placeholder { //플레이스 홀더 설정
                                                Image(systemName: "list.dash")
                                            }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                            .onSuccess {r in //성공
                                                print("succes: \(r)")
                                            }
                                            .onFailure { e in //실패
                                                print("failure: \(e)")
                                            }
                                            .startLoadingBeforeViewAppear()
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 80)
                                            .clipped()
                                        KFImage(URL(string: "\(viewModel.newGameList.content?[index].imageUrls?[1] ?? "")"))
                                            .placeholder { //플레이스 홀더 설정
                                                Image(systemName: "list.dash")
                                            }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                            .onSuccess {r in //성공
                                                print("succes: \(r)")
                                            }
                                            .onFailure { e in //실패
                                                print("failure: \(e)")
                                            }
                                            .startLoadingBeforeViewAppear()
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 80)
                                            .clipped()
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        HStack {
                                            Spacer()
                                            Text(viewModel.newGameList.content?[index].createdAt?.toLastTimeString() ?? "")
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
                .navigationTitle("내 게임")
                .navigationBarTitleDisplayMode(.inline)
                .refreshable {
                    viewModel.fetchGameList()
                }
                .tint(Color("opoPink"))
            }
            
//            if adminDecoder.isAdmin == false {
//                admob()
//            }
        }
        .onAppear() {
            viewModel.fetchGameList()
        }
    }
}
