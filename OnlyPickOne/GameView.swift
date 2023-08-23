//
//  GameView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct GameView: View {
    @State var round: Int = 0
    
    var body: some View {

        VStack(spacing: 5) {
            NavigationLink {
                ResultView()
            } label: {
                ZStack {
                    Image("cat1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Text("냥 패키지")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5)
                }
            }

            HStack {
                Text("VS")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            
            NavigationLink {
                ResultView()
            } label: {
                ZStack {
                    Image("cat2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Text("퓨마")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
