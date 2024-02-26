//
//  NoticeSettingView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/21.
//

import SwiftUI

struct NoticeSettingView: View {
    @ObservedObject var viewModel = NoticeSettingViewModel()
    @Binding var isShowingView: Bool
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    Text("공지 제목")
                    TextField("", text: $viewModel.titleInput)
                    Text(viewModel.titleInput.count.toString()+" / 100")
                        .font(.caption)
                        .foregroundColor(viewModel.titleInput.count >= 100 ? .red : nil)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(5)
                VStack(alignment: .leading) {
                    Text("공지 내용")
                    TextEditor(text: $viewModel.contentInput)
                        .frame(minHeight: 100)
                    Text(viewModel.contentInput.count.toString()+" / 2000")
                        .font(.caption)
                        .foregroundColor(viewModel.contentInput.count >= 2000 ? .red : nil)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(5)
                Button {
                    viewModel.submitNotice()
                    isShowingView = false
                } label: {
                    Text("제출")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!(1...100 ~= viewModel.titleInput.count) || !(1...2000 ~= viewModel.contentInput.count))
            }
            .navigationTitle("공지사항 작성")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct NoticeSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoticeSettingView()
//    }
//}
