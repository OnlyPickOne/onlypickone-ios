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
    case getVersion
    case setVersion(_ info: Info)
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
            return URL(string: _privateDataStruct().baseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .getVersion, .setVersion(_):
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
        case .test, .getVersion:
            return .get
        case .mailAuthReq(_), .mailVerify(_), .signUp(_), .logIn(_), .setVersion(_):
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
        case .setVersion(let info):
            return .requestJSONEncodable(info)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .setVersion(_):
            let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
            return ["Content-type" : "application/json", "Authorization" : "Bearer \(accessToken)"]
        default:
            return ["Content-type" : "application/json"]
        }
    }
    
}
