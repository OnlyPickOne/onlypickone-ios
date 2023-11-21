//
//  HomeView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @ObservedObject var listViewModel = ListViewModel()
//    @State var refreshTabView: Bool = false
    
    var body: some View {
        TabView {
            ListView(viewModel: listViewModel)
                .tabItem {
                    Label("게임목록", systemImage: "gamecontroller")
                }
            AddView()
                .tabItem {
                    Label("게임 만들기", systemImage: "plus.square.fill.on.square.fill")
                }
            SettingView(isNeedToAuth: $viewModel.isNeedToAuth)
                .tabItem {
                    Label("설정", systemImage: "gearshape")
                }
        }
        .tint(Color("opoPink"))
        .fullScreenCover(isPresented: $viewModel.isNeedToAuth) {
            LogInSheetView(isShowingLogInSheet: $viewModel.isNeedToAuth)
                .tint(Color("opoPink"))
                .onDisappear() {
                    listViewModel.refreshData()
                    listViewModel.fetchGameList()
                }
        }
        .alert("필수 업데이트가 있습니다.", isPresented: $viewModel.isNeedToUpdate, actions: {
            Button {
                print("필수업데이트")
            } label: {
                Text("업데이트")
            }
        })
        .alert("최신 버전이 있습니다. 더욱 좋은 서비스를 위해 업데이트를 해주세요", isPresented: $viewModel.toLeadToUpdate, actions: {
            Button {
                print("선택업데이트")
            } label: {
                Text("업데이트")
            }
            Button {
                print("스킵")
            } label: {
                Text("다음에 알림")
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
