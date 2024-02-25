//
//  NoticeSettingViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/02/27.
//

import Foundation
import Combine
import Moya
import CombineMoya

class NoticeSettingViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    
    @Published var titleInput: String = ""
    @Published var contentInput: String = ""
    
    func submitNotice() {
        provider.requestPublisher(.submitNotice(titleInput, contentInput))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                guard let result = try? response.map(Response<String>.self) else { return }
            }.store(in: &subscription)
    }
}

