//
//  GameViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/23.
//

import Foundation

class GameViewModel: ObservableObject {
    private var list: [Item]
    private var result: [Item] = []
    
    @Published var topItem: Item?
    @Published var bottomItem: Item?
    @Published var winner: Item?
    
    init(list: [Item]) {
        self.list = list
        match()
    }
    
    private func match() {
        print(list)
        print(result)
        print(topItem, bottomItem)
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
}
