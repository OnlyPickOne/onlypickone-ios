//
//  LogInSheetView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/18.
//

import SwiftUI

struct LogInSheetView: View {
    @Binding var isShowingLogInSheet: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("opoBackground")
                    .ignoresSafeArea(.all)
                VStack(spacing: 16) {
                    Spacer()
                    Image("opoImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    Spacer()
                    NavigationLink {
                        Text("asdf")
                            .onAppear(){
                                isShowingLogInSheet = false
                            }
                    } label: {
                        Text("로그인")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .frame(height: 40)
                    .background(Color("opoBlue"))
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
                    
                    NavigationLink {
                        SignUpView(isShowingLogInSheet: $isShowingLogInSheet)
                    } label: {
                        Text("회원가입")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .frame(height: 40)
                    .background(Color("opoRed"))
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
                }
                .padding(48)
            }
            .tint(Color("opoPink"))
        }
        
    }
}
