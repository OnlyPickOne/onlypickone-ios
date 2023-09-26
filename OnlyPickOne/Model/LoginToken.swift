//
//  loginToken.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/26.
//

import Foundation

struct LoginToken: Codable {
    let grantType: String?
    let accessToken: String?
    let refreshToken: String?
    let accessTokenExpiresIn: Int?
}
