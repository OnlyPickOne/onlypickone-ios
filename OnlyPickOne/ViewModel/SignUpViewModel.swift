//
//  SignUpViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/18.
//

import Foundation
import Combine
import Moya
import CombineMoya

class SignUpViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    @Published var isValidEmail: Bool = false
    @Published var isValidPassword: Bool = false
    @Published var isShowingAuthField: Bool = false
    @Published var isSucessAuthEmail: Bool = false
    @Published var isShowingVerifyError: Bool = false
    @Published var isShowingUsingEmailError: Bool = false
    
    public func checkValidEmail(email: String?) {
        guard let email = email else { return }
        if NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: email) {
            isValidEmail = true
            return
        }
        isValidEmail = false
    }
    
    public func checkValidPassword(password: String?) {
        guard let password = password else { return }
        if NSPredicate(format:"SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,20}").evaluate(with: password) {
            if NSPredicate(format:"SELF MATCHES %@", "[A-Za-z0-9!@#$%^&*+=-]*").evaluate(with: password) {
                isValidPassword = true
                return
            }
        }
        isValidPassword = false
    }
    
    public func mailAuthReqeust(email: String?) {
        guard let email = email else { return }
        provider.requestPublisher(.mailAuthReq(Email(email: email, code: nil)))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<String>.self)
                print(result?.message ?? "")
            }.store(in: &subscription)
    }
    
    public func mailVerify(email: String?, code: String?) {
        guard let email = email, let code = code else { return }
        provider.requestPublisher(.mailVerify(Email(email: email, code: code)))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<String>.self)
                self.isSucessAuthEmail = result?.isSuccess ?? false
                if result?.isSuccess ?? false == false && result?.status ?? 0 == 400 {
                    self.isShowingUsingEmailError = true
                } else {
                    self.isShowingVerifyError = !(result?.isSuccess ?? false)   
                }
                print(result?.isSuccess)
            }.store(in: &subscription)
    }
    
    public func signUp(email: String?, password: String?, completion: @escaping (Bool)->()) {
        guard let email = email, let password = password else { return }
        provider.requestPublisher(.signUp(Account(email: email, password: password)))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<String>.self)
                print(result)
                completion(result?.isSuccess ?? false)
            }.store(in: &subscription)
    }
    
    init(subscription: Set<AnyCancellable> = Set<AnyCancellable>()) {
    }
}
