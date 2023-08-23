//
//  GameView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: GameViewModel = GameViewModel(list: [
        Item(id: 0, caption: "00", image: "cat1"),
        Item(id: 1, caption: "01", image: "cat2"),
        Item(id: 2, caption: "02", image: "football"),
        Item(id: 3, caption: "03", image: "street"),
        Item(id: 4, caption: "04", image: "cat1"),
        Item(id: 5, caption: "05", image: "cat2"),
        Item(id: 6, caption: "06", image: "football"),
        Item(id: 7, caption: "07", image: "street")
        ])
    @State var round: Int = 0
    
    var body: some View {
        if game.winner == nil {
            GeometryReader { geometry in
                VStack(spacing: 5) {
                    ZStack {
                        if let topItem = game.topItem, let image = topItem.image, let caption = topItem.caption {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                            Text(caption)
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5)
                        }
                    }
                    .onTapGesture {
                        game.choose(top: true)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.45)
                    .clipped()
                    
                    HStack {
                        Text("VS")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                    
                    ZStack {
                        if let bottomItem = game.bottomItem, let image = bottomItem.image, let caption = bottomItem.caption {
                            Image(image)
                                .resizable()
                            Text(caption)
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5)
                        }
                    }
                    .onTapGesture {
                        game.choose(top: false)
                    }
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.45)
                    .clipped()
                }
            }
        }
        else {
            ResultView()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
