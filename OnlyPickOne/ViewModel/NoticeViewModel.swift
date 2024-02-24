//
//  NoticeViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/02/25.
//

import Foundation
import Combine
import Moya
import CombineMoya

class NoticeViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    
    @Published var notice: Notice = Notice(noticeId: 0, title: "Test", content: "test", viewCount: 0, createdAt: "2099-01-01T00:00:00")
    
    var noticeId: Int
    
    func fetchNotice(id: Int) {
        provider.requestPublisher(.notice(noticeId: id))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                guard let result = try? response.map(Response<Notice>.self), let data = result.data else { return }
                self.notice = data
            }.store(in: &subscription)
    }
    
    init(noticeId: Int) {
        self.noticeId = noticeId
        self.fetchNotice(id: noticeId)
    }
}

