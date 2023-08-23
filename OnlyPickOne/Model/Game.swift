//
//  Game.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/23.
//

import Foundation

struct Game: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let createdTime: String?
    let author: String?
    let items: [Item]?

//    enum CodingKeys: String, CodingKey {
//        case id
//        case caption
//        case image
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        caption = try values.decodeIfPresent(String.self, forKey: .caption)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//    }

}
