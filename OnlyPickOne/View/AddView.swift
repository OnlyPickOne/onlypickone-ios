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
    
    let colors:[Color] = [.purple, .pink, .orange]
    var body: some View {
        VStack(spacing: 5) {
            Text("제목")
            TextField("게임 제목을 작성해주세요", text: $titleInput)
                .textFieldStyle(.roundedBorder)
                .padding(15)
            
            Text("설명")
            HStack {
                TextEditor(text: $detailInput)
                    .background(Color.primary.colorInvert())
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.black, lineWidth: 1 / 3)
                            .opacity(0.3)
                    )
                    .padding(15)
            }
            .frame(height: 180)
            
            CardView(input: itemInput, images: images)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
