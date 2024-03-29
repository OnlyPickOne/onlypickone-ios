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
    @State private var selected : Int = 0
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
                        ForEach((0..<(viewModel.gameList.count)), id: \.self) { index in
                            NavigationLink {
                                GameInfoView(gameId: viewModel.gameList[index].id ?? 0, game: viewModel.gameList[index], list: viewModel)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("\(viewModel.gameList[index].title ?? "unknown game")")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .lineLimit(2)
                                    HStack(spacing: 15) {
                                        HStack(spacing: 0) {
                                            if viewModel.gameList[index].imageUrls?.count ?? 0 >= 2 {
                                                KFImage(URL(string: "\(viewModel.gameList[index].imageUrls?[0] ?? "")"))
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
                                                KFImage(URL(string: "\(viewModel.gameList[index].imageUrls?[1] ?? "")"))
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
                                            } else if viewModel.gameList[index].imageUrls?.count ?? 0 == 1 {
                                                KFImage(URL(string: "\(viewModel.gameList[index].imageUrls?[0] ?? "")"))
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
                                                    .frame(width: 80, height: 80)
                                                    .clipped()
                                            } else {
                                                Image(systemName: "exclamationmark.circle.fill")
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 80, height: 80)
                                                    .clipped()
                                            }
                                        }
                                        VStack(alignment: .leading, spacing: 0) {
                                            Text("\(viewModel.gameList[index].description ?? "please refresh or restart the application")")
                                                .font(.caption)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(5)
                                                .frame(height: 66)
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Text(viewModel.gameList[index].createdAt?.toLastTimeString() ?? "")
                                                    .font(.caption)
                                                    .fontWeight(.light)
                                                    .multilineTextAlignment(.trailing)
                                            }
                                        }
                                    }
                                }
                                .padding(5)
                            }
                            .onAppear {
                                if viewModel.lastGameId == viewModel.gameList[index].id {
                                    viewModel.fetchData()
                                }
                            }
                        }
                    }
                    .navigationTitle("OnlyPickOne")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Menu("정렬") {
                            Picker("Auto-Join Hotspot", selection: $viewModel.sortBy) {
                                ForEach(GameSort.allCases) { option in
                                    Text(String(describing: option))
                                }
                            }
                            .onChange(of: viewModel.sortBy) { _ in
                                viewModel.refreshData()
                                viewModel.fetchData()
                            }
                        }
                    }
                    .refreshable {
                        viewModel.refreshData()
                        viewModel.fetchData()
                    }
                    .tint(Color("opoPink"))
                }
                
                if adminDecoder.isAdmin == false {
                    admob()
                }
            }
            .searchable(text: $viewModel.searchKeyword, placement: .navigationBarDrawer, prompt: "제목 또는 키워드를 입력해주세요")
        }
        
        .onSubmit(of: .search) {
            viewModel.refreshData()
            viewModel.fetchData()
        }
        .onChange(of: viewModel.searchKeyword) { newValue in
            viewModel.searchSubject.send(newValue)
        }
        .onAppear() {
            viewModel.fetchData()
            viewModel.startSearching()
        }
    }
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
}
