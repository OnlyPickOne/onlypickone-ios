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
    @State var images: [String] = ["cat1","cat2","football"]
    @State var itemInput: [String] = ["","",""]
    @FocusState private var focusField: Field?

    let colors:[Color] = [.purple, .pink, .orange]
    var body: some View {
        NavigationView {
            VStack {
                TextField("게임 제목을 작성해주세요", text: $titleInput)
                    .focused($focusField, equals: .title)
                    .textFieldStyle(.roundedBorder)
                    .padding(15)
                NavigationLink("다음", destination: {
                    VStack(spacing: 5) {
                        HStack {
                            TextEditor(text: $detailInput)
                                .focused($focusField, equals: .detail)
                                .background(Color.primary.colorInvert())
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(UIColor.label), lineWidth: 0.3)
                                        .opacity(0.3)
                                )
                                .padding(15)
                        }
                        NavigationLink("다음", destination: {
                            CardView(input: itemInput, images: images)
                                .navigationTitle("캡션 달기")
                        })
                        .navigationTitle("설명")
                    }
                })
                Spacer()
            }
            .navigationTitle("제목")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    enum Field: Hashable {
        case title, detail
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
