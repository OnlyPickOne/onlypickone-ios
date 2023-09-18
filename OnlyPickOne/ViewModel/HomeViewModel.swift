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
    
    
    init(subscription: Set<AnyCancellable> = Set<AnyCancellable>(), isAuthorized: Bool = false) {
        self.subscription = subscription
        self.isNeedToAuth = isAuthorized
//        self.mailAuthReqeust(email: "110w110@naver.com")
    }
}
