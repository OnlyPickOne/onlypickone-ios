//
//  AddView.swift
//  SwiftUITest
//
//  Created by 한태희 on 2023/08/22.
//

import SwiftUI

struct AddView: View {
    @State var titleInput: String = ""
    @State var detailInput: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("제목")
                TextField("게임 제목을 작성해주세요", text: $titleInput)
                    .textFieldStyle(.roundedBorder)
                    .padding(15)
                
                Spacer()
                
                Text("설명")
                HStack {
                    TextEditor(text: $detailInput)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 120)
                        .cornerRadius(10)
                        .padding(15)
                }
                
                Spacer()
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach((0..<10), id: \.self) { index in
                            Text("asdfasd")
                                .frame(width: 180, height: 240)
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink {
                    ResultView()
                } label: {
                    Label("생성하기", systemImage: "plus")
                }

            }
//            .background(Color(UIColor.systemGray5))
            

        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
