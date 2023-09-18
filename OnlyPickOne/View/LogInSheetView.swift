//
//  LogInSheetView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/18.
//

import SwiftUI

struct LogInSheetView: View {
    var body: some View {
        ZStack {
            Color("opoBackground")
            VStack {
                Spacer()
                Image("opoImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                Spacer()
                Button("sadf") {
                    Text("sadf")
                }
                Spacer()
            }
        }
        
    }
}

struct LogInSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LogInSheetView()
    }
}
