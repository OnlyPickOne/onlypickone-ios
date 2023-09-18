//
//  SignUpView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/18.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isShowingLogInSheet: Bool
    @State var emailInput = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 56) {
            VStack(alignment: .leading, spacing: 10) {
                Text("이메일")
                    .font(.headline)
                TextField("유효한 이메일을 입력해주세요", text: $emailInput)
                Text("이메일 인증이 필요합니다.")
                    .font(.caption)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("비밀번호")
                    .font(.headline)
                TextField("비밀번호를 입력하세요", text: $emailInput)
                    .font(.body)
                Text("영어 대소문자 및 숫자를 포함하여 8자 이상 20자 이하")
                    .font(.caption)
            }
            Button {
                isShowingLogInSheet = false
            } label: {
                Text("가입하기")
                    .frame(maxWidth: .infinity)
            }
            .padding(0)
            .frame(height: 40)
            .background(Color("opoRed"))
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(10)
        }
        .padding(36)
    }
}
