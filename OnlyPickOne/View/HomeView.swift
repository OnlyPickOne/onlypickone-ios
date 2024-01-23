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
                    listViewModel.fetchData()
                }
        }
        .fullScreenCover(isPresented: $viewModel.isNeedToUpdate) {
            VStack(spacing: 30) {
                Text("필수 업데이트 안내")
                    .font(.headline)
                Text("안정적이고 편리한 사용을 위해 꾸준히 업데이트 중입니다. 이번 업데이트는 필수 업데이트이므로 반드시 진행해주시기 바랍니다. 더욱 좋은 서비스를 위해 노력하겠습니다. 감사합니다.")
                Link(destination: URL(string: "https://apps.apple.com/kr/app/onlypickone/id6469682692")!) {
                    Text("업데이트 하러가기")
                }
                .foregroundColor(.pink)
            }
            .padding(30)
        }
//        .alert("필수 업데이트가 있습니다.", isPresented: $viewModel.isNeedToUpdate, actions: {
//            Link(destination: URL(string: "https://apps.apple.com/kr/app/onlypickone/id6469682692")!) {
//                Text("업데이트")
//            }
//        })
        .alert("최신 버전이 있습니다. 더욱 좋은 서비스를 위해 업데이트를 해주세요", isPresented: $viewModel.toLeadToUpdate, actions: {
            Link(destination: URL(string: "https://apps.apple.com/kr/app/onlypickone/id6469682692")!) {
                Text("업데이트")
            }
            Button {
                print("스킵")
            } label: {
                Text("다음에 알림")
            }
        })
        .alertButtonTint(color: Color("opoPurple"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
