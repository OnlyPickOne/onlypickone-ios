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
    @State var passwordInput = ""
    
    @ObservedObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 48) {
            VStack(alignment: .leading, spacing: 10) {
                Text("이메일")
                    .font(.headline)
                HStack {
                    TextField("유효한 이메일을 입력해주세요", text: $emailInput)
                        .textInputAutocapitalization(.never)
                        .onChange(of: emailInput) {
                            viewModel.checkValidEmail(email: $0)
                        }
                    Button {
                        print("인증 요청")
                        viewModel.isSucessAuthEmail = true
                    } label: {
                        Text("인증요청")
                            .font(.subheadline)
                    }
                    .frame(width: 80, height: 40)
                    .background(viewModel.isValidEmail ? Color("opoBlue") : Color(cgColor: UIColor.systemGray5.cgColor))
                    .accentColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
                    .disabled(!(viewModel.isValidEmail))
                }
                if (viewModel.isSucessAuthEmail) {
                    Text("이메일 인증이 완료되었습니다.")
                        .foregroundColor(Color("opoSkyBlue"))
                        .font(.caption)
                } else {
                    Text("이메일 인증이 필요합니다.")
                        .foregroundColor(Color("opoRed"))
                        .font(.caption)
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("비밀번호")
                    .font(.headline)
                SecureField("비밀번호를 입력하세요", text: $passwordInput)
                    .font(.body)
                    .onChange(of: passwordInput) {
                        viewModel.checkValidPassword(password: $0)
                    }
                if (viewModel.isValidPassword) {
                    Text("사용 가능한 비밀번호입니다.")
                        .foregroundColor(Color("opoSkyBlue"))
                        .font(.caption)
                } else {
                    Text("영어 대소문자 및 숫자를 포함하여 8자 이상 20자 이하")
                        .foregroundColor(Color("opoRed"))
                        .font(.caption)
                }
            }
            Button {
                isShowingLogInSheet = false
            } label: {
                Text("가입하기")
                    .frame(maxWidth: .infinity)
            }
            .padding(0)
            .frame(height: 40)
            .background((viewModel.isSucessAuthEmail && viewModel.isValidPassword) ? Color("opoRed") : Color(cgColor: UIColor.systemGray5.cgColor))
            .accentColor(.white)
            .font(.headline)
            .cornerRadius(10)
            .disabled(!(viewModel.isSucessAuthEmail && viewModel.isValidPassword))
        }
        .padding(36)
        .onAppear() {
            viewModel.isValidEmail = false
            viewModel.isValidPassword = false
            viewModel.isSucessAuthEmail = false
        }
    }
}
