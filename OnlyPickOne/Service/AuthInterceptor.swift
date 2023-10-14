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
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        print("new header adopted \(urlRequest.headers)")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry request")
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }

        // 토큰 갱신 API 호출
        var subscription = Set<AnyCancellable>()
        let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken"), let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return }
        print(accessToken, refreshToken)
        provider.request(.refreshToken(LoginToken(grantType: nil, accessToken: accessToken, refreshToken: refreshToken, accessTokenExpiresIn: nil))) { (result) in
            switch result {
            case let .success(response):
                let result = try? response.map(Response<LoginToken>.self)
                UserDefaults.standard.set(result?.data?.accessToken ?? "", forKey: "accessToken")
                UserDefaults.standard.set(result?.data?.refreshToken ?? "", forKey: "refreshToken")
                completion(.retry)
            case let .failure(error):
                print(error.localizedDescription)
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
