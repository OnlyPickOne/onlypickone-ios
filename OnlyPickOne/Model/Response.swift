//
//  Response.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/15.
//

import Foundation

struct Response<T: Codable>: Decodable {
    let status: Int?
    let isSuccess: Bool?
    let message: String?
    let data: T
}
