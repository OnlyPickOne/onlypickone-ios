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
    public var round: Int = 1
    public var current: String = ""
    private var list: [ItemWithUrl]
    private var result: [ItemWithUrl] = []
    
    @Published var topItem: ItemWithUrl?
    @Published var bottomItem: ItemWithUrl?
    @Published var winner: ItemWithUrl?
    @Published var semifinals: [ItemWithUrl?] = []
    @Published var statisticsList: [ItemWithUrl?] = []
    
    init(game: Game, itemCount: Int) {
        self.game = game
        self.list = game.items ?? []
        self.itemCount = itemCount
        self.setCurrent()
        fetchGameData(gameId: game.id ?? 0, count: itemCount)
    }
    
    public func setCurrent() {
        var round = 2
        while round <= (self.itemCount - self.round) {
            round *= 2
        }
        self.current = round <= 2 ? "결승" : "\(round)강"
    }
    
    private func match() {
        if list.count == 0 {
            list = result
            result = []
        }
        
        if list.count == 4 {
            semifinals = list
        }
        
        if list.count == 1 {
            winner = list[0]
            for i in 0..<4 {
                if semifinals[i]?.imageUrl == winner?.imageUrl {
                    semifinals.remove(at: i)
                    break
                }
            }
            self.gameFinish()
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
        
        self.round += 1
        self.setCurrent()
        match()
    }
    
    public func gameStart(gameId: Int, count: Int) {
        
        
        self.fetchGameData(gameId: gameId, count: count)
    }
    
    private func gameFinish() {
        guard let gameId = self.game.id, let itemId = self.winner?.itemId else { return }
        provider.requestPublisher(.finish(gameId, itemId))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<[ItemWithUrl]>.self)
                if let list = result?.data {
                    self.statisticsList = list
                }
            }.store(in: &subscription)
    }
    
    public func fetchGameData(gameId: Int, count: Int) {
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
