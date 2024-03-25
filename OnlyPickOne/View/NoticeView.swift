//
//  NoticeView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/01/31.
//

import SwiftUI

struct NoticeView: View {
    @ObservedObject var adminDecoder = JWTDecoder()
    @ObservedObject var viewModel: NoticeViewModel
    
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingSubmitNoticeView: Bool = false
    
    var noticeId: Int = 1
        
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.notice.title ?? "")
                    .font(.headline)
                Text(viewModel.notice.createdAt?.toLastTimeString() ?? "")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Text(viewModel.notice.content ?? "")
                .padding(.vertical, 20)
            }
            .padding(5)
        }
        .navigationTitle("공지사항")
        .toolbar {
            if adminDecoder.isAdmin == true {
                Button {
                    isShowingSubmitNoticeView = true
                } label: {
                    Text("수정")
                }
                
                Button {
                    print("deleteNotice")
                    viewModel.deleteNotice(id: noticeId)
                    dismiss()
                } label: {
                    Text("삭제")
                }
            }
        }
        .sheet(isPresented: $isShowingSubmitNoticeView) {
            NoticeSettingView(isShowingView: $isShowingSubmitNoticeView)
        }
    }
    
    init(noticeId: Int) {
        self.viewModel = NoticeViewModel(noticeId: noticeId)
        self.noticeId = noticeId
    }
}

//struct NoticeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
