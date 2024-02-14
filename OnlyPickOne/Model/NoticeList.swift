//
//  NoticeList.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/02/14.
//

import Foundation

struct NoticeList: Codable {
    let content: [Notice]?
    let pageable: Pageable?
    let last: Bool?
    let numberOfElements: Int?
    let size: Int?
    let first: Bool?
    let number: Int?
    let sort: Sort?
    let empty: Bool?
}
