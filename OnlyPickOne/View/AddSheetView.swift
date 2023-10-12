//
//  AddSheetView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/12.
//

import SwiftUI

struct AddSheetView: View {
    @State var images: [String] = ["cat1","cat2","football"]
    @State var itemInput: [String] = ["","",""]
    @Binding var isShowingAddSheet: Bool
    @FocusState private var focusField: Field?
    
    @ObservedObject var viewModel: AddSheetViewModel = AddSheetViewModel()

    let colors:[Color] = [.purple, .pink, .orange]
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    TextField("게임 제목을 작성해주세요", text: $viewModel.titleInput)
                        .focused($focusField, equals: .title)
                        .textFieldStyle(.roundedBorder)
                    NavigationLink("다음", destination: {
                        VStack(spacing: 20) {
                            HStack {
                                TextEditor(text: $viewModel.detailInput)
                                    .focused($focusField, equals: .detail)
                                    .background(Color.primary.colorInvert())
                                    .frame(height: 200)
                                    .cornerRadius(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(UIColor.label), lineWidth: 0.3)
                                            .opacity(0.3)
                                    )
                                    .padding(15)
                            }
                            Text("게임 설명은 최대 300자까지 작성할 수 있습니다.")
                                .font(.caption)
                            NavigationLink("다음", destination: {
                                VStack(spacing: 0) {
                                    CardView(viewModel: viewModel)
                                        .navigationTitle("캡션 달기")
                                        .tint(Color("opoPink"))
                                    Text("사진은 최소 4장에서 최대 128장까지 선택하실 수 있습니다.\n사진은 중복으로 추가될 수 있으며, 추가된 사진을 터치하면 제거됩니다.")
                                        .font(.caption)
                                    Spacer()
                                }
                                .toolbar {
                                    Button {
                                        viewModel.submitGame()
                                        isShowingAddSheet.toggle()
                                    } label: {
                                        Text("완료")
                                    }
                                    .disabled(viewModel.imageList.count < 5 || viewModel.imageList.count > 129)
                                }
                            })
                            .navigationTitle("설명")
                            .tint(Color("opoPink"))
                            .disabled(viewModel.detailInput.count > 300 || viewModel.detailInput.count <= 0)
                        }
                    })
                    .disabled(viewModel.titleInput.count > 40 || viewModel.titleInput.count <= 0)
                }
                Text("제목은 최대 40자까지 작성할 수 있습니다.")
                    .font(.caption)
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
