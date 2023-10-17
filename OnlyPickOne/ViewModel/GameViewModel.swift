//
//  GameViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/23.
//

import Foundation
import Combine
import Moya

class GameViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    public var game: Game
    public var itemCount: Int
    private var list: [ItemWithUrl]
    private var result: [ItemWithUrl] = []
    
    @Published var topItem: ItemWithUrl?
    @Published var bottomItem: ItemWithUrl?
    @Published var winner: ItemWithUrl?
    
    init(game: Game, itemCount: Int) {
        self.game = game
        self.list = game.items ?? []
        self.itemCount = itemCount
        fetchGameData(gameId: game.id ?? 0, count: itemCount)
    }
    
    private func match() {
        if list.count == 0 {
            list = result
            result = []
        }
        
        if list.count == 1 {
            winner = list[0]
            return
        }
        
        topItem = list.popLast()
        bottomItem = list.popLast()
    }
    
    public func choose(top: Bool) {
        if top {
            guard let topItem = topItem else { return }
            result.append(topItem)
        } else {
            guard let bottomItem = bottomItem else { return }
            result.append(bottomItem)
        }
        
        match()
    }
    
    public func gameStart(gameId: Int, count: Int) {
        
        
        self.fetchGameData(gameId: gameId, count: count)
    }
    
    public func fetchGameData(gameId: Int, count: Int) {
        print(gameId, count)
        provider.requestPublisher(.start(gameId, count))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<[ItemWithUrl]>.self)
                if let itemList = result?.data {
                    self.list = itemList
                }
                self.match()
            }.store(in: &subscription)
    }
}
