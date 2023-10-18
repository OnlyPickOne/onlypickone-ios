//
//  GameView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI
import GoogleMobileAds
import Kingfisher

struct GameView: View {
    @ObservedObject var info: GameInfoViewModel
    @ObservedObject var game: GameViewModel
    @ObservedObject var adminDecoder = JWTDecoder()
    
    private let round: Int
    
    @ViewBuilder func admob() -> some View {
        GADBanner().frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
    }
    
    var body: some View {
        if game.winner == nil {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack {
                        if let topItem = game.topItem, let image = topItem.imageUrl, let caption = topItem.caption {
                            KFImage(URL(string: image))
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
                                .clipped()
                                .animation(.easeIn(duration: 0.2), value: image)
                            Text(caption)
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5)
                                .animation(.easeIn(duration: 0.2), value: image)
                        }
                    }
                    .onTapGesture {
                        game.choose(top: true)
                    }
                    .frame(width: geometry.size.width, height: (geometry.size.height - 50) * 0.45)
                    .clipped()
                    
                    HStack {
                        ZStack {
                            Color(uiColor: .systemBackground)
                            Text("VS")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                        }
                    }
                    .frame(width: geometry.size.width, height: (geometry.size.height - 50) * 0.1)
                    
                    ZStack {
                        if let bottomItem = game.bottomItem, let image = bottomItem.imageUrl, let caption = bottomItem.caption {
                            KFImage(URL(string: image))
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
                                .clipped()
                                .animation(.easeIn(duration: 0.2), value: image)
                            Text(caption)
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5)
                                .animation(.easeIn(duration: 0.2), value: image)
                        }
                    }
                    .onTapGesture {
                        game.choose(top: false)
                    }
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: (geometry.size.height - 50) * 0.45)
                    .clipped()
                    
                    if adminDecoder.isAdmin == false {
                        admob()
                    }
                }
                .onAppear() {
                    game.fetchGameData(gameId: info.game.gameId ?? 0, count: self.round)
                }
            }
        }
        else {
            ResultView(viewModel: game)
        }
    }
    
    init(round: Int, info: GameInfoViewModel) {
        self.round = round
//        self.gameId = gameId
        self.info = info
        self.game = GameViewModel(game: Game(id: info.game.gameId, title: info.game.title, description: info.game.description, createdTime: info.game.createdAt, items: nil), itemCount: round)
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(round: 4, gameId: 0)
//    }
//}
