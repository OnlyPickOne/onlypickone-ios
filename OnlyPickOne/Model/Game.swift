//
//  Game.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/23.
//

import Foundation

struct Game {
    let id: Int?
    let title: String?
    let description: String?
    let createdTime: Int?
//    let author: String?
    let items: [Item]?

}

struct NewGame: Codable {
    let gameId: Int?
    let title: String?
    let description: String?
    let viewCount: Int?
    let playCount: Int?
    let itemCount: Int?
    let reportCount: Int?
    let createdAt: String?
    let imageUrls: [String]?
}
