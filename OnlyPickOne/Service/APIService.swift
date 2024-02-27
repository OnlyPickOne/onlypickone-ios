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
    case gameListByPaging(_ sortBy: GameSort, _ size: Int, _ gameId: Int = 0, _ createdAt: String = "", _ playCount: Int = 0, _ likeCount: Int = 0, _ keyword: String = "")
    case gameInfo(_ gameId: Int)
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
    case notice(noticeId: Int)
    case noticeList(noticeId: Int?, createdAt: String?)
    case submitNotice(_ title: String, _ content: String)
    case modifyNotice(_ noticeId: Int, _ title: String, _ content: String)
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
        case .gameList, .create(_,_,_), .gameListByPaging(_, _, _, _, _, _, _):
            return "/games"
        case .remove(let id), .gameInfo(let id):
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
        case .noticeList(_, _), .submitNotice(_, _):
            return "/notices"
        case .notice(let id), .modifyNotice(let id, _, _):
            return "/notices/\(id)"
        case .test:
            return "/users/2"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .mailAuthReq(_), .mailVerify(_), .signUp(_), .logIn(_), .setVersion(_), .refreshToken(_), .create(_,_,_), .finish(_,_), .like(_), .report(_), .submitNotice(_, _):
            return .post
        case .remove(_), .leave(_), .deleteLike(_):
            return .delete
        case .modifyNotice(_, _, _):
            return .patch
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
                if let caption = mFile.caption, let image = mFile.image, let imageData = image.jpegData(compressionQuality: 0.4) {
                    formData.append(Moya.MultipartFormData(provider: .data(imageData), name: "multipartFiles", fileName: "\(caption).jpeg", mimeType: "image/jpeg"))
                }
            }
            return .uploadMultipart(formData)
        case .gameListByPaging(let sort, let size, let gid, let createdAt, let playCount, let likeCount, let keyword):
            var param: [String : Any] = ["size" : size]
            
            switch sort {
            case .byDate:
                param["sort"] = "createdAt,desc"
            case .byPlayCount:
                param["sort"] = "playCount,desc"
            case .byLikeCount:
                param["sort"] = "likeCount,desc"
            }
            
            if gid != 0 {
                param["gameId"] = "\(gid)"
                switch sort {
                case .byDate:
                    param["createdAt"] = createdAt
                case .byPlayCount:
                    param["playCount"] = "\(playCount)"
                case .byLikeCount:
                    param["likeCount"] = "\(likeCount)"
                }
            }
            
            if keyword != "" {
                param["query"] = keyword
            }
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .noticeList(noticeId: let nid, createdAt: let createdAt):
            var param: [String : Any] = ["size" : 20, "sort" : "createdAt,desc"]
            
            if let nid = nid, let createdAt = createdAt {
                param["noticeId"] = nid
                param["createdAt"] = createdAt
            }
            
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .submitNotice(let title, let content), .modifyNotice(_, let title, let content):
            let notice = Notice(noticeId: nil, title: title, content: content, viewCount: nil, createdAt: nil)
            return .requestJSONEncodable(notice)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .setVersion(_), .create(_, _, _), .gameList, .gameListByPaging(_, _, _, _, _, _, _), .remove(_), .leave(_), .like(_), .deleteLike(_), .report(_), .noticeList(noticeId: _, createdAt: _), .gameInfo(_), .notice(noticeId: _), .submitNotice(_, _), .modifyNotice(_, _, _):
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
