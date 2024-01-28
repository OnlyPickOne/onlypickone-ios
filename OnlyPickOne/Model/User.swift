//
//  User.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/02/05.
//

import Foundation

struct User: Codable {
    let userId: Int?
    let email: String?
    let createdDate: String?
    let lastRequestDate: String?
    let isBanned: Bool?
    let isLeft: Bool?
}
