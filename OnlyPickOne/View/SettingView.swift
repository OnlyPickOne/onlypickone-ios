//
//  SettingView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/23.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel = SettingViewModel()
    @Binding var isNeedToAuth: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section("고객센터") {
                    NavigationLink {
                        NoticeListView()
                    } label: {
                        Text("공지사항")
                    }
                    NavigationLink {
                        Text("문의하기")
                    } label: {
                        Text("문의하기")
                    }
                    NavigationLink {
                        Text("최소지원버전 : \(viewModel.minimumVersion)\n현재최신버전 : \(viewModel.latestVersion)")
                            .onAppear() {
                                viewModel.info()
                            }
                    } label: {
                        Text("앱 정보")
                    }

                }
                
                Section("약관") {
                    NavigationLink {
                        TermsWebView(urlToLoad: "https://water-advantage-4b6.notion.site/8ff7ccd28d05427c85c5aacbc59cfe06?pvs=4")
                    } label: {
                        Text("개인정보 처리방침")
                    }
                    NavigationLink {
                        TermsWebView(urlToLoad: "https://water-advantage-4b6.notion.site/7e7e7929ce6f4d6a88c6dcdb31e0fa12?pvs=4")
                    } label: {
                        Text("이용 약관")
                    }
                    
                }
                
                Section("개인 설정") {
                    NavigationLink {
                        ListView()
                    } label: {
                        Text("내 게임")
                    }
                    Button {
                        viewModel.logout()
                        isNeedToAuth = true
                    } label: {
                        Text("로그아웃")
                    }
                    .foregroundColor(Color(uiColor: .label))
                    NavigationLink {
                        Text("회원 탈퇴")
                    } label: {
                        Text("회원 탈퇴")
                    }
                }
                
                Section("관리자 메뉴 - 관리자만 보일 예정") {
                    NavigationLink {
                        NoticeSettingView(titleInput: "", contentInput: "")
                    } label: {
                        Text("공지 작성")
                    }
                    NavigationLink {
                        Text("유저 목록")
                    } label: {
                        Text("유저 목록")
                    }
                    NavigationLink {
                        Text("게임 목록")
                    } label: {
                        Text("게임 목록")
                    }
                    NavigationLink {
                        VersionSettingView(leastInput: "", latestInput: "")
                    } label: {
                        Text("버전 정보 변경")
                    }
                }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .tint(Color("opoPink"))
        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
