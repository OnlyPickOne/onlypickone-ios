//
//  APIService.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/11.
//

import Foundation
import Moya

enum APIService {
    case game
    case gameList
    case submit
    case statistics
    case create
    case remove
    case report
    case join
    case login
    case leave
    case info
    case mailAuthReq(_ mail: Email)
    case notice
    case test
}

extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .game, .gameList, .info, .mailAuthReq(_):
            return URL(string: "http://52.78.136.228:8080/api/v1")!
        case .test:
            return URL(string: "https://reqres.in/api")!
        default:
            return URL(string: "http://52.78.136.228")!
        }
    }
    
    var path: String {
        switch self {
        case .info:
            return "/versions"
        case .mailAuthReq(_):
            return "/mails"
        case .test:
            return "/users/2"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .test, .info:
            return .get
        case .mailAuthReq(_):
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
//        case .test:
//            let params: [String: Any] = [
//                "firstName": "Taehee",
//                "lastName": "Han"
//            ]
//            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .mailAuthReq(let mail):
//            return .requestParameters(parameters: ["email" : mail], encoding: URLEncoding.queryString)
            return .requestJSONEncodable(mail)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
