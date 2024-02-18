//
//  SignUpView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/18.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isShowingLogInSheet: Bool
    @State var emailInput = ""
    @State var passwordInput = ""
    @State var repeatInput = ""
    @State var codeInput = ""
    @ObservedObject var viewModel = SignUpViewModel()
    
    var body: some View {
        ZStack() {
            ScrollView {
                VStack(alignment: .leading, spacing: 48) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("이메일")
                            .font(.headline)
                        HStack {
                            TextField("유효한 이메일을 입력해주세요", text: $emailInput)
                                .textInputAutocapitalization(.never)
                                .textFieldStyle(.roundedBorder)
                                .showClearButton($emailInput)
                                .onChange(of: emailInput) {
                                    viewModel.checkValidEmail(email: $0)
                                }
                            Button {
                                viewModel.startTimer()
                                viewModel.isShowingAuthField = true
                                viewModel.mailAuthReqeust(email: emailInput)
                            } label: {
                                Text(viewModel.isRetryButton ? "재전송" : "인증요청")
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
                    }
                    .disabled(viewModel.isSucessAuthEmail)
                    .opacity(viewModel.isSucessAuthEmail ? 0.4 : 1)
//                    .disabled(viewModel.isShowingAuthField)
//                    .opacity(viewModel.isShowingAuthField ? 0.4 : 1)
                    
                    if viewModel.isShowingAuthField {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("인증번호")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text("\(viewModel.timeLast.secondsPerMinutes())")
                                    .font(.subheadline)
                            }
                            HStack {
                                TextField("인증코드는 10분 간 유효합니다.", text: $codeInput)
                                    .textInputAutocapitalization(.never)
                                    .textFieldStyle(.roundedBorder)
                                    .showClearButton($codeInput)
                                    .keyboardType(.numberPad)
                                Button {
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
                            .textFieldStyle(.roundedBorder)
                            .showClearButton($passwordInput)
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
                        SecureField("한번 더 입력하세요", text: $repeatInput)
                            .font(.body)
                            .textFieldStyle(.roundedBorder)
                            .showClearButton($repeatInput)
                            .onChange(of: passwordInput) {
                                viewModel.checkValidPassword(password: $0)
                            }
                        if (passwordInput == repeatInput && repeatInput.count != 0) {
                            Text("비밀번호가 일치합니다.")
                                .foregroundColor(Color("opoSkyBlue"))
                                .font(.caption)
                        } else if (repeatInput.count != 0) {
                            Text("비밀번호가 일치하지 않습니다.")
                                .foregroundColor(Color("opoRed"))
                                .font(.caption)
                        }
                    }
                    Button {
                        viewModel.signUp(email: emailInput, password: passwordInput) { isSucess in
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("가입하기")
                            .frame(maxWidth: .infinity)
                    }
                    .padding(0)
                    .frame(height: 40)
                    .background((viewModel.isSucessAuthEmail && viewModel.isValidPassword && passwordInput == repeatInput) ? Color("opoRed") : Color(cgColor: UIColor.systemGray5.cgColor))
                    .foregroundColor((viewModel.isSucessAuthEmail && viewModel.isValidPassword && passwordInput == repeatInput) ? .white : Color(cgColor: UIColor.systemGray2.cgColor))
                    .font(.headline)
                    .cornerRadius(10)
                    .disabled(!(viewModel.isSucessAuthEmail && viewModel.isValidPassword && passwordInput == repeatInput))
                }
                .padding(36)
                .alert("인증에 실패하였습니다", isPresented: $viewModel.isShowingVerifyError, actions: {
                    Button {
                        viewModel.isShowingVerifyError = false
                    } label: {
                        Text("확인")
                    }
                })
                .alert("이미 가입된 이메일입니다", isPresented: $viewModel.isShowingUsingEmailError, actions: {
                    Button {
                        viewModel.isShowingUsingEmailError = false
                    } label: {
                        Text("확인")
                    }
                })
                .alertButtonTint(color: Color("opoPurple"))
                .onAppear() {
                    viewModel.isValidEmail = false
                    viewModel.isValidPassword = false
                    viewModel.isShowingAuthField = false
                    viewModel.isSucessAuthEmail = false
                }
            }
            .disabled(viewModel.isLoading)
            
            if viewModel.isLoading {
                Color(uiColor: .systemBackground)
                    .opacity(0.6)
                ProgressView()
            }
        }
    }
}
