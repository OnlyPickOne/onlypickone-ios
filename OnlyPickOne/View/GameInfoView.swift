//
//  GameInfoView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/05.
//

import SwiftUI
import Kingfisher

struct GameInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var listViewModel: ListViewModel
    @ObservedObject var viewModel: GameInfoViewModel
    
    private let gameId: Int
    private var options = [4, 8, 16, 32, 64, 128, 256]
    @State var alertToReport: Bool = false
    @State private var deleteConfirmDialog: Bool = false
    @State private var deleteFailDialog: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text(viewModel.game.title ?? "unknown game")
                    .font(.title2)
                    .padding(.bottom, 10)
                
                Text(viewModel.game.description ?? "unknown game")
                    .font(.body)
                    .padding(.vertical, 10)
                    .padding(.bottom, 10)
                
                GeometryReader { geometry in
                    HStack(spacing: 10) {
                        KFImage(URL(string: viewModel.game.imageUrls?[0] ?? ""))
                            .placeholder { //플레이스 홀더 설정
                                Image(systemName: "list.dash")
                            }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                            .onSuccess {r in //성공
                                print("succes: \(r)")
                            }
                            .onFailure { e in //실패
                                print("failure: \(e)")
                            }
                            .startLoadingBeforeViewAppear()
                            .resizable()
                            .scaledToFill()
                            .frame(width: (geometry.size.width - 20) * (1/2), height: geometry.size.height)
                            .clipped()
                        KFImage(URL(string: viewModel.game.imageUrls?[1] ?? ""))
                            .placeholder { //플레이스 홀더 설정
                                Image(systemName: "list.dash")
                            }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                            .onSuccess {r in //성공
                                print("succes: \(r)")
                            }
                            .onFailure { e in //실패
                                print("failure: \(e)")
                            }
                            .startLoadingBeforeViewAppear()
                            .resizable()
                            .scaledToFill()
                            .frame(width: (geometry.size.width - 20) * (1/2), height: geometry.size.height)
                            .clipped()
                    }
                }
                .frame(height: 160)
                
                HStack {
                    HStack(spacing: 20) {
                        Image(systemName: "eye.fill")
                            .frame(width: 15, height: 15)
                        Text("\(viewModel.game.viewCount ?? 0)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Image(systemName: "gamecontroller.fill")
                            .frame(width: 15, height: 15)
                        Text("\(viewModel.game.playCount ?? 0)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Image(systemName: "hand.thumbsup.fill")
                            .frame(width: 15, height: 15)
                        Text("\(viewModel.game.likeCount ?? 0)")
                            .font(.subheadline)
                    }
                    .onTapGesture {
                        if (!(viewModel.game.isCreated ?? false)) {
                            viewModel.likeGame()
                            print("like")
                        }
                    }
                }
                .padding(.horizontal, 30)
                
                HStack {
                    Picker("토너먼트 선택", selection: $viewModel.selectionOption) {
                        ForEach(0..<options.count) {
                            if (options[$0] <= viewModel.game.itemCount ?? 0) {
                                Text("\(options[$0])강")
                            }
                        }
                    }
                    
                    NavigationLink {
                        GameView(round: options[viewModel.selectionOption], info: self.viewModel)
                            .navigationTitle(viewModel.game.title ?? "")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        ZStack {
                            Color("opoRed")
                                .cornerRadius(10)
                            Text("게임 시작")
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                        .frame(height: 40)
                    }
                    //                .padding(.horizontal, 15)
                    //                .padding(.bottom, 10)
                }
            }
            .padding(20)
            .alert("여러 사용자들에 의해 신고가 누적되면 게임은 임시로 차단 조치됩니다. 즉각 삭제 처리가 필요한 경우 고객센터를 통해 운영진에게 연락 바랍니다.", isPresented: $alertToReport) {
                Button("신고", role: .destructive) {
                    alertToReport.toggle()
                    viewModel.reportGamte() { success in
                        if success {
                            presentationMode.wrappedValue.dismiss()
                            listViewModel.fetchData()
                        }
                    }
                }
                Button("취소", role: .cancel) {
                    alertToReport.toggle()
                }
            }
            .alert("신고가 접수되었습니다. 긴급한 조치가 필요한 경우 개발팀 연락처로 제보 바랍니다.", isPresented: $viewModel.isShowingReportSucess) {
                Button("확인", role: .cancel) {
                    viewModel.isShowingReportSucess = false
                }
            }
            .alert("이미 신고된 게시글입니다.", isPresented: $viewModel.isShowingReportFail) {
                Button("확인", role: .cancel) {
                    viewModel.isShowingReportFail = false
                }
            }
            .alertButtonTint(color: Color("opoPurple"))
        }
        .refreshable {
            viewModel.fetchGameInfo()
        }
        .onAppear {
            viewModel.fetchGameInfo()
        }
        .toolbar {
            Menu {
                if (viewModel.game.isCreated ?? false) {
                    Button {
                        deleteConfirmDialog = true
                    } label: {
                            Text("게임 삭제")
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(5)
                    }
                    .foregroundColor(Color(uiColor: .label))
                    .alert("삭제하시겠습니까?", isPresented: $deleteConfirmDialog) {
                        Button("삭제", role: .destructive) {
                            deleteConfirmDialog = false
                            viewModel.deleteGame() { success in
                                if success {
                                    presentationMode.wrappedValue.dismiss()
                                    listViewModel.fetchData()
                                } else {
                                    deleteFailDialog = true
                                }
                            }
                        }
                        Button("취소", role: .cancel) {
                            deleteConfirmDialog = false
                        }
                    }
                    .alert("삭제 요청에 실패하였습니다.", isPresented: $deleteFailDialog) {
                        Button("확인") {
                            deleteFailDialog = false
                        }
                    }
                    .alertButtonTint(color: Color("opoPurple"))
                } else if (viewModel.isLiked) {
                    Button {
                        viewModel.likeGame()
                    } label: {
                            Text("좋아요 취소")
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(5)
                    }
                    .foregroundColor(Color(uiColor: .label))
                    
                    Button {
                        alertToReport.toggle()
                    } label: {
                            Text("신고")
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(5)
                    }
                    .foregroundColor(Color(uiColor: .label))
                } else {
                    Button {
                        viewModel.likeGame()
                    } label: {
                            Text("좋아요")
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(5)
                    }
                    .foregroundColor(Color(uiColor: .label))
                    
                    Button {
                        alertToReport.toggle()
                    } label: {
                            Text("신고")
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(5)
                    }
                    .foregroundColor(Color(uiColor: .label))
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
    
    init(gameId: Int = 0, game: NewGame?, list: ListViewModel) {
        self.viewModel = GameInfoViewModel(gameId: gameId)
        self.gameId = gameId
        self.listViewModel = list
    }
}

struct GameInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GameInfoView(game: NewGame(id: 0, title: "테스트용 제목", description: "설명입니다. 도레미파솔라시도 간장공장공장장은장공장장이고", viewCount: 23, playCount: 16, likeCount: 8, itemCount: 40, reportCount: 1, createdAt: "", imageUrls: ["",""], isCreated: false, isLiked: false), list: ListViewModel())
    }
}
