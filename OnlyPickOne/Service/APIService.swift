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
    case mailVerify(_ mail: Email)
    case signUp(_ account: Account)
    case logIn(_ account: Account)
    case notice
    case test
}

extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .test:
            return URL(string: "https://reqres.in/api")!
        default:
            return URL(string: "http://52.78.136.228:8080/api/v1")!
        }
    }
    
    var path: String {
        switch self {
        case .info:
            return "/versions"
        case .mailAuthReq(_):
            return "/mails"
        case .mailVerify(_):
            return "/mails/verify"
        case .signUp(_):
            return "/auth/signup"
        case .logIn(_):
            return "/auth/login"
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
        case .mailAuthReq(_), .mailVerify(_), .signUp(_), .logIn(_):
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .mailAuthReq(let mail), .mailVerify(let mail):
            return .requestJSONEncodable(mail)
        case .signUp(let account), .logIn(let account):
            return .requestJSONEncodable(account)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
