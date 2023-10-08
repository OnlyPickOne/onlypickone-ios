//
//  NoticeSettingView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/21.
//

import SwiftUI

struct NoticeSettingView: View {
    @State var titleInput: String
    @State var contentInput: String
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("공지 제목")
                TextField("", text: $titleInput)
            }
            .padding(5)
            VStack(alignment: .leading) {
                Text("공지 내용")
                TextEditor(text: $contentInput)
                    .frame(minHeight: 100)
            }
            .padding(5)
            Button {
                print("submit")
            } label: {
                Text("제출")
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct NoticeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeSettingView(titleInput: "", contentInput: "")
    }
}
