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
        provider.requestPublisher(.logIn(Account(email: email, password: password)))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.isFailureLogIn = true
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<LoginToken>.self)
                
                self.isSucessLogIn = result?.isSuccess ?? false
                
                // Token Save
                if let accessToken = result?.data?.accessToken, let refreshToken = result?.data?.refreshToken {
                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                    UserDefaults.standard.set(true, forKey: "session")
                }
                
                
                completion(result?.isSuccess ?? false)
            }.store(in: &subscription)
    }
}
