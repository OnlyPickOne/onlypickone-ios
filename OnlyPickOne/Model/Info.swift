//
//  Info.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/15.
//

import Foundation

struct Info: Codable {
    let versionId: Int?
    let minimum: String?
    let latest: String?

    enum CodingKeys: String, CodingKey {
        case versionId
        case minimum
        case latest
    }
}
