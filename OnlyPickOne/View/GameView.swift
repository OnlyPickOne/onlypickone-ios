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
    @State private var isShowingSuffleView = true
    @State private var isAnimating = false
    @ObservedObject var info: GameInfoViewModel
    @ObservedObject var game: GameViewModel
    @ObservedObject var adminDecoder = JWTDecoder()
    
    private let round: Int
    
    @ViewBuilder func admob() -> some View {
        GADBanner().frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
    }
    
    var body: some View {
        ZStack {
            if game.winner == nil {
                if isShowingSuffleView {
                    HStack(spacing: 0) {
                        Text("랜덤생성중...")
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                                    withAnimation {
                                        isShowingSuffleView = false
                                    }
                                }
                            }
                        Image(systemName: "hourglass")
                            .frame(width: 15, height: 15)
                            .rotationEffect(isAnimating ? .degrees(15) : .degrees(-15))
                            .animation(.easeInOut(duration: 0.1))
                            .onAppear() {
                                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                                    withAnimation {
                                        isAnimating.toggle()
                                    }
                                }
                                
                            }
                    }
                } else {
                    GeometryReader { geometry in
                        VStack(spacing: 0) {
                            ZStack {
                                if let topItem = game.topItem, let image = topItem.imageUrl, let caption = topItem.caption {
                                    KFAnimatedImage(URL(string: image))
                                        .placeholder { //플레이스 홀더 설정
                                            Image(systemName: "photo.fill")
                                        }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                        .startLoadingBeforeViewAppear()
                                        .scaledToFit()
                                        .clipped()
//                                        .animation(.easeIn(duration: 0.2), value: image)
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
                            
                            ZStack {
                                Color(uiColor: .systemBackground)
                                HStack {
                                    Text(game.current)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.trailing)
                                    Text("VS")
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                    Text("\(game.round)/\(game.itemCount)")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                            .frame(width: geometry.size.width, height: (geometry.size.height - 50) * 0.1)
                            
                            ZStack {
                                if let bottomItem = game.bottomItem, let image = bottomItem.imageUrl, let caption = bottomItem.caption {
                                    KFAnimatedImage(URL(string: image))
                                        .placeholder { //플레이스 홀더 설정
                                            Image(systemName: "photo.fill")
                                        }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                        .startLoadingBeforeViewAppear()
                                        .scaledToFit()
                                        .clipped()
//                                        .animation(.easeIn(duration: 0.2), value: image)
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
                            .frame(width: geometry.size.width, height: (geometry.size.height - 50) * 0.45)
                            .clipped()
                            
                            if adminDecoder.isAdmin == false {
                                admob()
                            }
                        }
                    }
                }
            } else {
                ResultView(viewModel: game)
            }
        }
    }
    
    init(round: Int, info: GameInfoViewModel) {
        self.round = round
        self.info = info
        self.game = GameViewModel(game: Game(id: info.game.id, title: info.game.title, description: info.game.description, createdTime: info.game.createdAt, items: nil), itemCount: round)
    }
}
