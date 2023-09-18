//
//  HomeView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("게임목록", systemImage: "gamecontroller")
                }
            AddView(isShowingAddSheet: false)
                .tabItem {
                    Label("게임 만들기", systemImage: "plus.square.fill.on.square.fill")
                }
            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gearshape")
                }
        }
        .tint(Color("opoPink"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
