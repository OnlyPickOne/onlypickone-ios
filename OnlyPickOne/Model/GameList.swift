//
//  Content.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/11.
//

import Foundation

struct GameList: Codable {
    let content: [NewGame]?
    let pageable: Pageable?
    let last: Bool?
    let numberOfElements: Int?
    let size: Int?
    let first: Bool?
    let number: Int?
    let sort: Sort?
    let empty: Bool?
}

struct Sort: Codable {
    let unsorted: Bool?
    let sorted: Bool?
    let empty: Bool?
}

struct Pageable: Codable {
    let sort: Sort?
    let pageNumber: Int?
    let pageSize: Int?
    let offset: Int?
    let paged: Bool?
    let unpaged: Bool?
}
