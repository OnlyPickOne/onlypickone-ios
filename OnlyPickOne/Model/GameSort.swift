//
//  Sort.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/11/26.
//

import Foundation

enum GameSort: CaseIterable, Identifiable, CustomStringConvertible {
    case byDate
    case byPlayCount
    case byLikeCount
    
    var id: Self { self }

    var description: String {

        switch self {
        case .byDate:
            return "최신순"
        case .byPlayCount:
            return "플레이순"
        case .byLikeCount:
            return "좋아요순"
        }
    }
}
