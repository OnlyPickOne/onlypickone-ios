//
//  LogInViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/18.
//

import Foundation
import Combine
import Moya
import CombineMoya

class LogInViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    @Published var isSucessLogIn: Bool = false
    @Published var isFailureLogIn: Bool = false
    
    public func logIn(email: String?, password: String?, completion: @escaping (Bool)->()) {
        guard let email = email, let password = password else { return }
        print("\(email) \(password)")
        provider.requestPublisher(.logIn(Account(email: email, password: password)))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("sucess")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<LoginToken>.self)
                print(result)
                self.isFailureLogIn = !(result?.isSuccess ?? false)
                self.isSucessLogIn = result?.isSuccess ?? false
//                completion(result?.isSuccess ?? false)
            }.store(in: &subscription)
    }
}
