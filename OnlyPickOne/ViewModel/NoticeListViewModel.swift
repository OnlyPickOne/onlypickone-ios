//
//  NoticeListViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/02/14.
//

import Foundation
import Combine
import Moya
import CombineMoya

class NoticeListViewModel: ObservableObject {
    @Published var noticeList: [Notice] = []
    
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    
    private let dataPerPage = 20
    private var nextIndex = 0
    private var lastCreatedAt = ""
    
    var lastNoticeId = 0
    var isLastPage: Bool = false
    
    func refreshData() {
        noticeList = []
        lastCreatedAt = ""
        lastNoticeId = 0
        isLastPage = false
    }
    
    func fetchData(_ query: String = "") {
        guard isLastPage == false else { return }
        
        provider.requestPublisher(.noticeList(noticeId: lastNoticeId, createdAt: lastCreatedAt))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { [weak self] response in
                let result = try? response.map(Response<NoticeList>.self)
                
                guard let data = result?.data, let content = data.content else { return }
                self?.lastNoticeId = content.last?.noticeId ?? 0
                self?.lastCreatedAt = content.last?.createdAt ?? ""
                self?.isLastPage = data.last ?? false
                self?.noticeList.append(contentsOf: content)
            }.store(in: &subscription)
    }
    
    init(subscription: Set<AnyCancellable> = Set<AnyCancellable>(), nextIndex: Int = 0, lastCreatedAt: String = "", lastNoticeId: Int = 0, isLastPage: Bool = false) {
        self.subscription = subscription
        self.nextIndex = nextIndex
        self.lastCreatedAt = lastCreatedAt
        self.lastNoticeId = lastNoticeId
        self.isLastPage = isLastPage
        self.fetchData()
    }
}

