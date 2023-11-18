//
//  ListViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/13.
//

import Foundation
import Combine
import Moya
import CombineMoya

class ListViewModel: ObservableObject {
    @Published var gameList: [NewGame] = []
    @Published var newGameList: GameList = GameList(content: nil, pageable: nil, totalPages: nil, totalElements: nil, last: nil, numberOfElements: nil, size: nil, first: nil, number: nil, sort: nil, empty: nil)
    @Published var searchKeyword: String = ""
    @Published var testString: String = ""
    @Published var refreshTabView: Bool = false
    @Published var sortBy: GameSort = .byDate
    
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    
    private let dataPerPage = 2
    private var nextIndex = 0
    private var lastCreatedAt = ""
    private var lastPlayCount = 0
    private var lastLikeCount = 0
    var lastGameId = 0
    
    var isLastPage: Bool = false
    
    func fetchData() {
        guard isLastPage == false else { return }
        
        provider.requestPublisher(.gameListByPaging(sortBy, dataPerPage, lastGameId, lastCreatedAt, lastPlayCount, lastLikeCount))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { [weak self] response in
                let result = try? response.map(Response<GameList>.self)
                
                guard let data = result?.data else { return }
                self?.isLastPage = data.last ?? false
                self?.nextIndex += data.content?.count ?? 0
                self?.lastCreatedAt = data.content?.last?.createdAt ?? ""
                self?.lastPlayCount = data.content?.last?.playCount ?? 0
                self?.lastLikeCount = data.content?.last?.likeCount ?? 0
                self?.lastGameId = data.content?.last?.id ?? 0
                self?.gameList.append(contentsOf: data.content ?? [])
                self?.newGameList = data
                
            }.store(in: &subscription)
    }
    
    func fetchGameList() {
        provider.requestPublisher(.gameList)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { [weak self] response in
                let result = try? response.map(Response<GameList>.self)
                guard let data = result?.data else { return }
                self?.gameList.append(contentsOf: data.content ?? [])
                self?.newGameList = data
            }.store(in: &subscription)

    }
}
