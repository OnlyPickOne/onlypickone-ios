//
//  HomeViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/18.
//

import Foundation
import Combine
import Moya
import CombineMoya

class HomeViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    @Published var isNeedToAuth: Bool = true
    
    public func mailAuthReqeust(email: String?) {
        guard let email = email else { return }
        provider.requestPublisher(.mailAuthReq(Email(email: email)))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("sucess")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<String>.self)
                print(result?.message ?? "")
            }.store(in: &subscription)
    }
    
    init(subscription: Set<AnyCancellable> = Set<AnyCancellable>(), isAuthorized: Bool = false) {
        self.subscription = subscription
        self.isNeedToAuth = isAuthorized
//        self.mailAuthReqeust(email: "110w110@naver.com")
    }
}
