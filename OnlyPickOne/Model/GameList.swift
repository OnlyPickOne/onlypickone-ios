//
//  Content.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/11.
//

import Foundation

struct GameList: Codable {
    let gameId: Int?
    let title: String?
    let description: String?
    let viewCount: Int?
    let playCount: Int?
    let itemCount: Int?
    let reportCount: Int?
    let imageUrls: [String]?
}
