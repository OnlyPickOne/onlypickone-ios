//
//  SettingView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/23.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            Section("고객센터") {
                Text("공지사항")
                Text("문의하기")
                Text("앱 정보")
            }
            
            Section("개인 설정") {
                Text("내 게임")
                Text("로그아웃")
                Text("회원 탈퇴")
            }
            
            Section("관리자 메뉴 - 관리자만 보일 예정") {
                Text("공지 작성")
                Text("게임 목록")
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
