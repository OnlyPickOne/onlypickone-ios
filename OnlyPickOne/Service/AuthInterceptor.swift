//
//  AuthInterceptor.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/05.
//

import Foundation
import Moya
import Alamofire
import Combine

final class AuthInterceptor: RequestInterceptor {

    static let shared = AuthInterceptor()

    private init() {}

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }

        // 토큰 갱신 API 호출
        var subscription = Set<AnyCancellable>()
        let provider = MoyaProvider<APIService>()
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken"), let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return }
        
        provider.requestPublisher(.refreshToken(LoginToken(grantType: nil, accessToken: accessToken, refreshToken: refreshToken, accessTokenExpiresIn: nil)))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("sucess")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<LoginToken>.self)
                switch result?.isSuccess ?? false {
                case true:
                    print("Retry-토큰 재발급 성공")
                    completion(.retry)
                case false:
                    // 갱신 실패 -> 로그인 화면으로 전환
                    print("갱신 실패")
                    completion(.doNotRetryWithError(error))
                }
                print(result?.message ?? "")
            }.store(in: &subscription)
        
    }
}
