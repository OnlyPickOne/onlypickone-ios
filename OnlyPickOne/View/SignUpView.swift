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
    @State var codeInput = ""
    @ObservedObject var viewModel = SignUpViewModel()
    
    var body: some View {
        ScrollView {
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
                            viewModel.isShowingAuthField = true
                            viewModel.mailAuthReqeust(email: emailInput)
                        } label: {
                            Text("인증요청")
                                .font(.subheadline)
                        }
                        .frame(width: 80, height: 40)
                        .background(viewModel.isValidEmail ? Color("opoBlue") : Color(cgColor: UIColor.systemGray5.cgColor))
                        .foregroundColor(viewModel.isValidEmail ? .white : Color(cgColor: UIColor.systemGray2.cgColor))
                        .font(.headline)
                        .cornerRadius(10)
                        .disabled(!(viewModel.isValidEmail))
                    }
                    if (!viewModel.isValidEmail) {
                        Text("유효한 이메일을 입력해주세요.")
                            .foregroundColor(Color("opoRed"))
                            .font(.caption)
                    }
                }.disabled(viewModel.isShowingAuthField)
                    .opacity(viewModel.isShowingAuthField ? 0.4 : 1)
                
                if viewModel.isShowingAuthField {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("인증번호")
                            .font(.headline)
                        HStack {
                            TextField("인증코드는 10분 간 유효합니다.", text: $codeInput)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.numberPad)
                            Button {
                                print("확인")
                                viewModel.mailVerify(email: emailInput, code: codeInput)
                            } label: {
                                Text("인증")
                                    .font(.subheadline)
                            }
                            .frame(width: 80, height: 40)
                            .background(codeInput.count == 6 ? Color("opoBlue") : Color(cgColor: UIColor.systemGray5.cgColor))
                            .foregroundColor(codeInput.count == 6 ? .white : Color(cgColor: UIColor.systemGray2.cgColor))
                            .font(.headline)
                            .cornerRadius(10)
                            .disabled(codeInput.count != 6)
                        }
                        if (viewModel.isSucessAuthEmail) {
                            Text("이메일 인증이 완료되었습니다.")
                                .foregroundColor(Color("opoSkyBlue"))
                                .font(.caption)
                        } else {
                            Text("올바른 인증코드를 입력해주세요.")
                                .foregroundColor(Color("opoRed"))
                                .font(.caption)
                        }
                    }
                    .disabled(viewModel.isSucessAuthEmail)
                    .opacity(viewModel.isSucessAuthEmail ? 0.4 : 1)
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
                .foregroundColor((viewModel.isSucessAuthEmail && viewModel.isValidPassword) ? .white : Color(cgColor: UIColor.systemGray2.cgColor))
                .font(.headline)
                .cornerRadius(10)
                .disabled(!(viewModel.isSucessAuthEmail && viewModel.isValidPassword))
            }
            .padding(36)
            .onAppear() {
                viewModel.isValidEmail = false
                viewModel.isValidPassword = false
                viewModel.isShowingAuthField = false
                viewModel.isSucessAuthEmail = false
            }
        }
    }
}
