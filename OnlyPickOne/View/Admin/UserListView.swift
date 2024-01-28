//
//  UserListView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/02/05.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = UserListViewModel()
    var body: some View {
        List {
            ForEach((0..<(viewModel.users.count)), id: \.self) { index in
                let user = viewModel.users[index]
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(user.isLeft ?? false ? "(탈퇴유저) " : "")\(user.email ?? "")")
                        Text("회원 ID \(user.userId?.toString() ?? "")")
                            .font(.caption)
                        Text("가입일 \(user.createdDate ?? "")")
                            .font(.caption)
                        Text("최종로그인 \(user.lastRequestDate ?? "")")
                            .font(.caption)
                        Text("플레이 0회 제작 0회 좋아요 0회 신고 0회")
                            .font(.caption)
                    }
                    .foregroundColor(user.isLeft ?? false ? .gray : nil)
                    
                    Spacer()
                    
                    if (user.isBanned ?? false) {
                        Image(systemName: "person.fill.xmark")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "person.fill.checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("유저 목록")
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
