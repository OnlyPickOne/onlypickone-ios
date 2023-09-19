//
//  AddSheetView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/12.
//

import SwiftUI

struct AddSheetView: View {
    @State var titleInput: String = ""
    @State var detailInput: String = ""
    @State var images: [String] = ["cat1","cat2","football"]
    @State var itemInput: [String] = ["","",""]
    @Binding var isShowingAddSheet: Bool
    @FocusState private var focusField: Field?

    let colors:[Color] = [.purple, .pink, .orange]
    var body: some View {
        NavigationView {
            HStack(spacing: 15) {
                TextField("게임 제목을 작성해주세요", text: $titleInput)
                    .focused($focusField, equals: .title)
                    .textFieldStyle(.roundedBorder)
                NavigationLink("다음", destination: {
                    VStack(spacing: 5) {
                        HStack {
                            TextEditor(text: $detailInput)
                                .focused($focusField, equals: .detail)
                                .background(Color.primary.colorInvert())
                                .frame(height: 120)
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(UIColor.label), lineWidth: 0.3)
                                        .opacity(0.3)
                                )
                                .padding(15)
                        }
                        NavigationLink("다음", destination: {
                            VStack(spacing: 0) {
                                CardView(input: itemInput, imageList: [UIImage(named: "street")!])
                                    .navigationTitle("캡션 달기")
                                    .tint(Color("opoPink"))
                            }
                            .toolbar {
                                Button {
                                    isShowingAddSheet.toggle()
                                } label: {
                                    Text("완료")
                                }
                            }
                        })
                        .navigationTitle("설명")
                        .tint(Color("opoPink"))
                    }
                })
            }
            .padding(20)
            .navigationTitle("제목")
            .navigationBarTitleDisplayMode(.inline)
            .tint(Color("opoPink"))
            .onAppear {
                UIApplication.shared.hideKeyboard()
            }
        }
    }
    
    enum Field: Hashable {
        case title, detail
    }
}
