//
//  GameModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/23.
//

import Foundation
import UIKit.UIImage

struct Item {
    let id: Int?
    let caption: String?
    let image: UIImage?
}

struct ItemWithUrl: Codable {
    let itemId: Int?
    let imageUrl: String?
    let caption: String?
}
