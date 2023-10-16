//
//  GameInfoViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/12.
//

import Foundation

class GameInfoViewModel: ObservableObject {
    @Published var game: NewGame
    
    init(game: NewGame?) {
        self.game = game ?? NewGame(gameId: nil, title: nil, description: nil, viewCount: nil, playCount: nil, itemCount: nil, reportCount: nil, createdAt: nil, imageUrls: nil)
    }
}
