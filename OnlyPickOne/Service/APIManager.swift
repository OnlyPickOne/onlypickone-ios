//
//  APIManager.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/11.
//

import Foundation
import Moya

struct APIManager {
    private let provider = MoyaProvider<APIService>()
    
    func test(data: Data, completion: @escaping (String) -> (), failure: @escaping (String) -> ()) {
        provider.request(.test) { (result) in
            switch result {
            case let .success(response):
                let result = try? response.map(Joke.self)
//                completion(result?.value.joke ?? "")
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
