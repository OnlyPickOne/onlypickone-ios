//
//  SettingViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/15.
//

import Foundation
import Combine
import Moya
import CombineMoya

class SettingViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    
    @Published var minimumVersion: String = ""
    @Published var latestVersion: String = ""
    @Published var isMember: Bool = false
    
    public func checkMember() {
        isMember = UserDefaults.standard.string(forKey: "accessToken") != nil
    }
    
    public func info() {
        provider.requestPublisher(.getVersion)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<Info>.self)
                self.minimumVersion = result?.data?.minimum ?? ""
                self.latestVersion = result?.data?.latest ?? ""
            }.store(in: &subscription)
    }
    
    public func leave(completion: @escaping (Bool) -> ()) {
        provider.requestPublisher(.leave(JWTDecoder().userId))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<String>.self)
                if result?.isSuccess == true {
                    /// 서버 로직은 구현 후 추가할 예정
                    /// 현재는 토큰만 지우는 식으로 임시 구현
                    UserDefaults.standard.set(nil, forKey: "accessToken")
                    UserDefaults.standard.set(nil, forKey: "refreshToken")
                    completion(true)
                }
            }.store(in: &subscription)
    }
    
    public func logout() {
        UserDefaults.standard.set(nil, forKey: "accessToken")
        UserDefaults.standard.set(nil, forKey: "refreshToken")
        UserDefaults.standard.set(false, forKey: "session")
    }
}
