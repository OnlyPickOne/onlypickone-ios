//
//  GameInfoView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/05.
//

import SwiftUI
import Kingfisher

struct GameInfoView: View {
    @ObservedObject var viewModel: GameInfoViewModel
    
    private let gameId: Int
    private var options = [4, 8, 16, 32, 64, 128, 256]
    @State private var selectionOption = 0
    
    var body: some View {
        List {
            Section("게임 제목") {
                Text(viewModel.game.title ?? "unknown game")
                    .font(.subheadline)
            }
            
            Section("게임 설명") {
                Text(viewModel.game.description ?? "unknwon game")
                    .font(.subheadline)
            }
            
            Section("예시 사진") {
                GeometryReader { geometry in
                    HStack(spacing: 10) {
                        KFImage(URL(string: viewModel.game.imageUrls?[0] ?? ""))
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
                            .scaledToFill()
                            .frame(width: (geometry.size.width - 20) * (1/2), height: geometry.size.height)
                            .clipped()
                        KFImage(URL(string: viewModel.game.imageUrls?[1] ?? ""))
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
                            .scaledToFill()
                            .frame(width: (geometry.size.width - 20) * (1/2), height: geometry.size.height)
                            .clipped()
                    }
                }
                .frame(height: 160)
            }
            
            Section("게임 플레이") {
                if (viewModel.game.isCreated ?? false) {
                    Button {
                        viewModel.deleteGame()
                    } label: {
                        Text("게임 삭제")
                    }
                    .foregroundColor(Color(uiColor: .label))
                } else if (viewModel.game.isLiked ?? false) {
                    Button {
                        viewModel.likeGame()
                    } label: {
                        Text("좋아요 취소")
                    }
                    .foregroundColor(Color(uiColor: .label))
                    
                    Button {
                        viewModel.reportGamte()
                    } label: {
                        Text("신고하기")
                    }
                    .foregroundColor(Color(uiColor: .label))
                } else {
                    Button {
                        viewModel.likeGame()
                    } label: {
                        Text("좋아요")
                    }
                    .foregroundColor(Color(uiColor: .label))
                    
                    Button {
                        viewModel.reportGamte()
                    } label: {
                        Text("신고하기")
                    }
                    .foregroundColor(Color(uiColor: .label))
                }
                
                Picker("토너먼트 선택", selection: $selectionOption) {
                    ForEach(0 ..< options.count) {
                        if (options[$0] <= viewModel.game.itemCount ?? 0) {
                            Text("\(options[$0])강")
                        }
                    }
                }
                
                NavigationLink {
                    GameView(round: options[selectionOption], info: self.viewModel)
                        .navigationTitle(viewModel.game.title ?? "")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("게임 시작")
                }
            }
        }
    }
    
    init(gameId: Int = 0, game: NewGame?) {
        self.viewModel = GameInfoViewModel(game: game)
        self.gameId = gameId
    }
}
//
//struct GameInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameInfoView()
//    }
//}
