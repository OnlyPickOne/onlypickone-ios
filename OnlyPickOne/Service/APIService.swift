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
    case finish(_ gameId: Int, _ itemId: Int)
    case gameList
    case gameListByPaging(_ sortBy: GameSort, _ size: Int, _ gameId: Int = 0, _ createdAt: String = "", _ playCount: Int = 0, _ likeCount: Int = 0)
    case submit
    case statistics
    case create(_ title: String, _ description: String, _ multipartFiles: [Item])
    case remove(_ uid: Int)
    case report(_ gid: Int)
    case like(_ gid: Int)
    case deleteLike(_ gid: Int)
    case join
    case login
    case leave(_ id: Int)
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
        case .gameList, .create(_,_,_), .gameListByPaging(_, _, _, _, _, _):
            return "/games"
//        case .gameListByPaging(let sort, let size, let gid, let createdAt, let playCount, let likeCount):
//            if gid == 0 {
//                switch sort {
//                case .byDate:
//                    print("/games?size=\(size)&sort=createdAt,desc")
//                    return "/games?size=\(size)&sort=createdAt,desc"
//                case .byPlayCount:
//                    return "/games?size=\(size)&sort=playCount,desc"
//                case .byLikeCount:
//                    return "/games?size=\(size)&sort=likeCount,desc"
//                }
//            } else {
//                switch sort {
//                case .byDate:
//                    print("/games?size=\(size)&sort=createdAt,desc&gameId=\(gid)&createdAt=\(createdAt)")
//                    return "/games?size=\(size)&sort=createdAt,desc&gameId=\(gid)&createdAt=\(createdAt)"
//                case .byPlayCount:
//                    return "/games?size=\(size)&sort=playCount,desc&gameId=\(gid)&playCount=\(playCount)"
//                case .byLikeCount:
//                    return "/games?size=\(size)&sort=likeCount,desc&gameId=\(gid)&likeCount=\(likeCount)"
//                }
//            }
        case . remove(let id):
            return "/games/\(id)"
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
        case .start(let id, _), .finish(let id, _):
            return "/games/\(id)/items"
        case .like(let id), .deleteLike(let id):
            return "/games/\(id)/likes"
        case .report(let id):
            return "/games/\(id)/reports"
        case .leave(let id):
            return "/members/\(id)"
        case .test:
            return "/users/2"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .mailAuthReq(_), .mailVerify(_), .signUp(_), .logIn(_), .setVersion(_), .refreshToken(_), .create(_,_,_), .finish(_,_), .like(_), .report(_):
            return .post
        case .remove(_), .leave(_), .deleteLike(_):
            return .delete
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .start(_, let count):
            return .requestParameters(parameters: ["count": count], encoding: URLEncoding.queryString)
        case .finish(_, let id):
            return .requestJSONEncodable(WinItem(winItemId: id))
        case .gameListByPaging(let sort, let size, let gid, let createdAt, let playCount, let likeCount):
            if gid == 0 {
                switch sort {
                case .byDate:
                    print("/games?size=\(size)&sort=createdAt,desc")
                    return .requestParameters(parameters: ["size" : size, "sort" : "createdAt,desc"], encoding: URLEncoding.queryString)
                case .byPlayCount:
                    return .requestParameters(parameters: ["size" : size, "sort" : "playCount,desc"], encoding: URLEncoding.queryString)
                case .byLikeCount:
                    return .requestParameters(parameters: ["size" : size, "sort" : "likeCount,desc"], encoding: URLEncoding.queryString)
                }
            } else {
                switch sort {
                case .byDate:
                    print("/games?size=\(size)&sort=createdAt,desc&gameId=\(gid)&createdAt=\(createdAt)")
                    return .requestParameters(parameters: ["size" : size, "sort" : "createdAt,desc", "gameId" : "\(gid)", "createdAt" : createdAt], encoding: URLEncoding.queryString)
//                    return "/games?size=\(size)&sort=createdAt,desc&gameId=\(gid)&createdAt=\(createdAt)"
                case .byPlayCount:
                    return .requestParameters(parameters: ["size" : size, "sort" : "playCount,desc", "gameId" : "\(gid)", "playCount" : "\(playCount)"], encoding: URLEncoding.queryString)
//                    return "/games?size=\(size)&sort=playCount,desc&gameId=\(gid)&playCount=\(playCount)"
                case .byLikeCount:
                    return .requestParameters(parameters: ["size" : size, "sort" : "likeCount,desc", "gameId" : "\(gid)", "likeCount" : "\(likeCount)"], encoding: URLEncoding.queryString)
//                    return "/games?size=\(size)&sort=likeCount,desc&gameId=\(gid)&likeCount=\(likeCount)"
                }
            }
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
                if let caption = mFile.caption, let image = mFile.image, let imageData = image.jpegData(compressionQuality: 0.05) {
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
        case .setVersion(_), .create(_, _, _), .gameList, .gameListByPaging(_, _, _, _, _, _), .remove(_), .leave(_), .like(_), .deleteLike(_), .report(_):
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
