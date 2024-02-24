//
//  NoticeListView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/04.
//

import SwiftUI

struct NoticeListView: View {
    @ObservedObject private var viewModel: NoticeListViewModel
    var body: some View {
        ZStack {
            List {
                ForEach((0..<(viewModel.noticeList.count)), id: \.self) { index in
                    NavigationLink {
                        NoticeView(noticeId: viewModel.noticeList[index].noticeId ?? 0)
                    } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(viewModel.noticeList[index].title ?? "")")
                                .font(.headline)
                            Text("\(viewModel.noticeList[index].createdAt?.toLastTimeString() ?? "")")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        .padding(5)
                    }
                    .onAppear {
                        if viewModel.noticeList.count == 0 {
                            viewModel.refreshData()
                            viewModel.fetchData()
                        }
                        else if viewModel.lastNoticeId == viewModel.noticeList[index].noticeId && viewModel.isLastPage == false {
                            viewModel.fetchData()
                        }
                    }
                }
            }
            .refreshable {
                viewModel.refreshData()
                viewModel.fetchData()
            }
            .navigationTitle("공지사항")
            .tint(Color("opoPink"))
        }
        .onAppear() {
//            viewModel.refreshData()
//            viewModel.fetchData()
        }
    }
    
    init(viewModel: NoticeListViewModel) {
        self.viewModel = viewModel
    }
}

struct NoticeListView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeListView(viewModel: NoticeListViewModel())
    }
}
