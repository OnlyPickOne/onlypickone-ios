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
    @State var alertToReset: Bool = false
    @FocusState private var focusField: Field?
    
    @ObservedObject var viewModel: AddSheetViewModel

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
                            NavigationLink(destination: {
                                VStack(spacing: 0) {
                                    CardView(viewModel: viewModel)
                                        .navigationTitle("캡션 달기")
                                        .tint(Color("opoPink"))
                                    Spacer()
                                }
                                .toolbar {
                                    Button {
                                        alertToReset.toggle()
                                    } label: {
                                        Text("취소")
                                    }
                                }
                                .alert("캡션을 모두 채워주세요", isPresented: $viewModel.isShowingAlertBlankCaption) {
                                    Button {
                                        viewModel.isShowingAlertBlankCaption = false
                                    } label: {
                                        Text("확인")
                                    }
                                }
                                .alertButtonTint(color: Color("opoBlue"))
                            },
                                           label: {
                                Text("다음")
                                    .frame(maxWidth: .infinity)
                            }
                            )
                            .frame(height: 50)
                            .padding(15)
                            .navigationTitle("설명")
                            .buttonStyle(.borderedProminent)
                            .tint(Color("opoPink"))
                            .disabled((viewModel.titleInput.count > 40 || viewModel.titleInput.count <= 0) || (viewModel.detailInput.count > 300 || viewModel.detailInput.count <= 0))
                        }
                        .toolbar {
                            Button {
                                alertToReset.toggle()
                            } label: {
                                Text("취소")
                            }
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(Color("opoPink"))
                    .disabled(viewModel.titleInput.count > 40 || viewModel.titleInput.count <= 0)
                }
                Text("제목은 최대 40자까지 작성할 수 있습니다.")
                    .font(.caption)
            }
            .padding(20)
            .navigationTitle("제목")
            .navigationBarTitleDisplayMode(.inline)
            .buttonStyle(.borderedProminent)
            .tint(Color("opoPink"))
            .toolbar {
                Button {
                    alertToReset.toggle()
                } label: {
                    Text("취소")
                }
            }
            .alert("작성하신 모든 내용이 삭제됩니다.", isPresented: $alertToReset) {
                Button("삭제", role: .destructive) {
                    viewModel.resetValue()
                    alertToReset.toggle()
                    viewModel.isShowingAddSheet = false
                }
                Button("취소", role: .cancel) {
                    alertToReset.toggle()
                }
            }
            .onAppear {
                UIApplication.shared.hideKeyboard()
            }
        }
    }
    
    enum Field: Hashable {
        case title, detail
    }
}
