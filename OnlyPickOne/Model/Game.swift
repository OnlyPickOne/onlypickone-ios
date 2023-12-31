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
    let createdTime: String?
//    let author: String?
    let items: [ItemWithUrl]?

}

struct NewGame: Codable, Identifiable {
    let id: Int?
    let title: String?
    let description: String?
    let viewCount: Int?
    let playCount: Int?
    let likeCount: Int?
    let itemCount: Int?
    let reportCount: Int?
    let createdAt: String?
    let imageUrls: [String]?
    let isCreated: Bool?
    let isLiked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "gameId"
        case title
        case description
        case viewCount
        case playCount
        case likeCount
        case itemCount
        case reportCount
        case createdAt
        case imageUrls
        case isCreated
        case isLiked
    }
}
