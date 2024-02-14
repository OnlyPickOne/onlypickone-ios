//
//  SettingView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/23.
//

import SwiftUI
import AcknowList

struct SettingView: View {
    @ObservedObject var viewModel = SettingViewModel()
    @ObservedObject var adminDecoder = JWTDecoder()
    
    @Binding var isNeedToAuth: Bool
    @State private var isShowingAskView: Bool = false
//    @State private var isAdmin: Bool = true
    
//    var plistName: String
    var body: some View {
        NavigationView {
            List {
                Section("고객센터") {
                    NavigationLink {
                        NoticeListView(viewModel: NoticeListViewModel())
                    } label: {
                        Text("공지사항")
                    }
                    Button {
                        isShowingAskView.toggle()
                    } label: {
                        Text("문의하기")
                    }
                    .foregroundColor(Color(uiColor: .label))
                }
                
                Section("이용 약관") {
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
//                    NavigationLink {
//                        MyGameListView()
//                    } label: {
//                        Text("내 게임")
//                    }
                    Button {
                        viewModel.logout()
                        isNeedToAuth = true
                    } label: {
                        Text("로그아웃")
                    }
                    .foregroundColor(Color(uiColor: .label))
                    NavigationLink {
                        LeaveView(viewModel: viewModel) { success in
                            if success {
                                isNeedToAuth = true
                            }
                        }
                    } label: {
                        Text("회원 탈퇴")
                    }
                }
                
                Section(header: Text("앱 정보"), footer: Text("Copyright 2023. OnlyPickOne All Rights Reserved.").font(.caption)) {
                    NavigationLink {
                        VStack(spacing: 20) {
                            Text("최소지원버전 : \(viewModel.minimumVersion)\n현재최신버전 : \(viewModel.latestVersion)")
                                .onAppear() {
                                    viewModel.info()
                                }
                            NavigationLink {
                                VStack(spacing: 10) {
                                    VStack {
                                        Text("OnlyPickOne Repo.")
                                            .font(.headline)
                                        Text("OnlyPickOne Official Github Repository")
                                            .font(.subheadline)
                                        Text("https://github.com/OnlyPickOne")
                                    }
                                    .padding(10)
                                    VStack {
                                        Text("Han Taehee")
                                            .font(.headline)
                                        Text("Mobile iOS Development")
                                            .font(.subheadline)
                                        Text("https://github.com/110w110")
                                    }
                                    VStack {
                                        Text("Lee Hoseok")
                                            .font(.headline)
                                        Text("Server, Infra, DB Development")
                                            .font(.subheadline)
                                        Text("https://github.com/hoshogi")
                                    }
                                    VStack {
                                        Text("Kim Jaehun")
                                            .font(.headline)
                                        Text("Web Client Development")
                                            .font(.subheadline)
                                        Text("https://github.com/jaehununun")
                                    }
                                }
                            } label: {
                                Text("Developers")
                            }

                            Text("Copyright 2023. OnlyPickOne All Rights Reserved.")
                                .font(.caption)
                        }
                    } label: {
                        Text("앱 정보")
                    }
                    NavigationLink {
                        AcknowListViewControllerViewWrapper()
                                    .navigationBarTitle("Acknowledgements")
                                    .edgesIgnoringSafeArea(.all)
                    } label: {
                        Text("오픈소스 라이브러리")
                    }
                }
                
                if adminDecoder.isAdmin {
                    Section("관리자 메뉴 - 관리자만 보일 예정") {
                        NavigationLink {
                            NoticeSettingView(titleInput: "", contentInput: "")
                        } label: {
                            Text("공지 작성")
                        }
                        NavigationLink {
                            UserListView()
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
                
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .tint(Color("opoPink"))
        }
        .sheet(isPresented: $isShowingAskView) {
            AskView()
        }
    }
}

fileprivate struct LeaveView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SettingViewModel
    
    let completionBlock: (Bool) -> ()
    
    var body: some View {
        VStack {
            Text("""
             탈퇴에 앞서서 아래의 내용을 반드시 확인해주시기 바랍니다.
             
             탈퇴하셔도 지금까지 등록한 게임은 삭제되지 않습니다.
             탈퇴 전에 미리 확인하셔서 삭제가 필요한 게임은 미리 삭제해주시기 바랍니다.
             
             탈퇴를 진행하신 직후부터는 더 이상 로그인을 하실 수 없으며, 남아 있는 게임에서 발생할 수 있는 법적 문제 및 분쟁 여지를 해결할 수 있는 최소한의 정보만 남기고 모든 정보를 파기합니다. 탈퇴 이후 필요하신 업무가 있으시면 개발팀 연락처(dev.hantae@gmail.com)로 연락 바랍니다.
             
             앞으로 만족스러운 서비스를 제공할 수 있도록 더욱 노력하겠습니다.
             정말로 탈퇴하시겠습니까?
             """)
            .font(.body)
            .padding(15)
            
            Button {
                print("탈퇴 프로세스 진행")
                viewModel.leave { success in
                    if success {
                        presentationMode.wrappedValue.dismiss()
                        completionBlock(true)
                    }
                }
            } label: {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("동의하고 탈퇴하기")
                }
            }
//            .sheet(isPresented: $viewModel.isShowingAddSheet) {
//                AddSheetView(viewModel: viewModel)
//            }
            .tint(Color("opoPink"))
            .padding()
        }
        .navigationTitle("회원 탈퇴")
        .navigationBarTitleDisplayMode(.inline)
        .tint(Color("opoPink"))
    }
}

private struct AcknowListViewControllerViewWrapper: UIViewControllerRepresentable {
    public let listStyle: UITableView.Style = .insetGrouped

    func makeUIViewController(context: UIViewControllerRepresentableContext<AcknowListViewControllerViewWrapper>) -> AcknowListViewController {
        var viewController: AcknowListViewController = AcknowListViewController(fileNamed: "Package.resolved")
        return viewController
    }

    func updateUIViewController(_ uiViewController: AcknowListViewController, context: UIViewControllerRepresentableContext<AcknowListViewControllerViewWrapper>) {
    }

}
