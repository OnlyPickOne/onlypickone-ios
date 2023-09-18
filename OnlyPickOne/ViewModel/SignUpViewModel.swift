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
    @Published var isSucessAuthEmail: Bool = false
    
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
        if NSPredicate(format:"SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[A-Z]).{8,20}").evaluate(with: password) {
            isValidPassword = true
            return
        }
        isValidPassword = false
    }
    
    init(subscription: Set<AnyCancellable> = Set<AnyCancellable>()) {
    }
}
