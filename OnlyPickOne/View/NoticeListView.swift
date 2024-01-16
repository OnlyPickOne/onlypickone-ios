//
//  NoticeListView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/04.
//

import SwiftUI

struct NoticeListView: View {
    var body: some View {
        ZStack {
            List {
                ForEach((0..<20), id: \.self) { index in
                    NavigationLink {
                        NoticeView()
                    } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("온리픽원 서비스 이용 안내")
                                .font(.headline)
                            Text("1시간 전")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        .padding(5)
                    }
                }
            }
            .navigationTitle("공지사항")
            .tint(Color("opoPink"))
        }
    }
}

struct NoticeListView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeListView()
    }
}
