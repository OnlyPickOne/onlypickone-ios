//
//  HomeView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("게임목록", systemImage: "gamecontroller.fill")
                }
            AddView()
                .tabItem {
                    Label("게임 만들기", systemImage: "plus")
                }
            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gear")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
