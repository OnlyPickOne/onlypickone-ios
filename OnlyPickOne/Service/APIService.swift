//
//  APIService.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/11.
//

import Foundation
import Moya
import UIKit.UIImage

enum APIService {
    case start(_ gameId: Int, _ count: Int)
    case gameList
    case submit
    case statistics
    case create(_ title: String, _ description: String, _ multipartFiles: [Item])
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
    case refreshToken(_ token: LoginToken)
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
        case .gameList, .create(_,_,_), .remove:
            return "/games"
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
        case .refreshToken(_):
            return "/auth/reissue"
        case .start(let id, _):
            return "/games/\(id)/items"
        case .test:
            return "/users/2"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .mailAuthReq(_), .mailVerify(_), .signUp(_), .logIn(_), .setVersion(_), .refreshToken(_), .create(_,_,_):
            return .post
        case .remove:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .start(let id, let count):
            return .requestParameters(parameters: ["count": count], encoding: URLEncoding.queryString)
        case .mailAuthReq(let mail), .mailVerify(let mail):
            return .requestJSONEncodable(mail)
        case .signUp(let account), .logIn(let account):
            return .requestJSONEncodable(account)
        case .setVersion(let info):
            return .requestJSONEncodable(info)
        case .refreshToken(let token):
            return .requestJSONEncodable(token)
        case .create(let title, let description, let multipartFiles):
            let titleData = title.data(using: String.Encoding.utf8) ?? Data()
            let descriptionData = description.data(using: String.Encoding.utf8) ?? Data()
            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(titleData), name: "title")]
            formData.append(Moya.MultipartFormData(provider: .data(descriptionData), name: "description"))
            for mFile in multipartFiles {
                if let caption = mFile.caption, let image = mFile.image, let imageData = image.jpegData(compressionQuality: 0.005) {
                    formData.append(Moya.MultipartFormData(provider: .data(imageData), name: "multipartFiles", fileName: "\(caption).jpeg", mimeType: "image/jpeg"))
                }
            }
            return .uploadMultipart(formData)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .setVersion(_), .create(_, _, _):
            let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
            return ["Content-type" : "application/json", "Authorization" : "Bearer \(accessToken)"]
        default:
            return ["Content-type" : "application/json"]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
