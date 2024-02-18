//
//  VersionSettingView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/21.
//

import SwiftUI

struct VersionSettingView: View {
    @ObservedObject var viewModel = VersionSettingViewModel()
    
    @State var leastInput: String
    @State var latestInput: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("최소 지원 버전")
                TextField("", text: $leastInput)
            }
            .padding(5)
            VStack(alignment: .leading) {
                Text("현재 최신 버전")
                TextField("", text: $latestInput)
            }
            .padding(5)
            Button {
                viewModel.setVersion(minimum: leastInput, latest: latestInput)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("제출")
                    .frame(maxWidth: .infinity)
            }
            .disabled(!(viewModel.isValidVersionString(minimum: leastInput, latest: latestInput)))
        }
    }
}

struct VersionSettingView_Previews: PreviewProvider {
    static var previews: some View {
        VersionSettingView(leastInput: "", latestInput: "")
    }
}
