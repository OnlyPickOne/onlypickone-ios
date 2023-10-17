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
//    @ObservedObject var game: GameViewModel = GameViewModel(game: Game(id: 0, title: "게임 이름 1", description: "안녕하세요. 망한/웃긴/귀여운 고양이들 사진중 원하는 사진을 고르시면 됩니다. 중복이 있으면 바로말해주세요. (자료출처: 구글 이미지, 유튜브 타임스낵과 다양한 동물의 짤, 네이버 카페, 인스타그램, 제작자) (업데이트: ○)", createdTime: 23400, items: [
//        Item(id: 0, caption: "00", image: UIImage(named: "cat1")),
//        Item(id: 1, caption: "01", image: UIImage(named: "cat2")),
//        Item(id: 2, caption: "02", image: UIImage(named: "football")),
//        Item(id: 3, caption: "03", image: UIImage(named: "street")),
//        Item(id: 4, caption: "04", image: UIImage(named: "cat1")),
//        Item(id: 5, caption: "05", image: UIImage(named: "cat2")),
//        Item(id: 6, caption: "가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하", image: UIImage(named: "football")),
//        Item(id: 7, caption: "가나다라마바사아자차카타파하가나다라마바사아자차카타파하", image: UIImage(named: "street"))
//        ]))
    
    private let round: Int
//    private let gameId: Int
    
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
                    
                    admob()
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
