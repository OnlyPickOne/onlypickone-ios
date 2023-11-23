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
    @Published var sortBy: GameSort = .byDate
    
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    let searchSubject = PassthroughSubject<String, Never>()
    
    private let dataPerPage = 2
    private var nextIndex = 0
    private var lastCreatedAt = ""
    private var lastPlayCount = 0
    private var lastLikeCount = 0
    private var currentSortBy: GameSort = .byDate
    
    var lastGameId = 0
    var isLastPage: Bool = false
    
    func startSearching() {
        let debouncedPublisher = searchSubject
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
        let subscriber = Subscribers.Sink<String, Never>(receiveCompletion: { _ in
        }, receiveValue: { _ in
            self.refreshData()
            self.fetchData()
        })
        debouncedPublisher.subscribe(subscriber)
    }
    
    func refreshData() {
        newGameList = GameList(content: nil, pageable: nil, totalPages: nil, totalElements: nil, last: nil, numberOfElements: nil, size: nil, first: nil, number: nil, sort: nil, empty: nil)
        gameList = []
        lastCreatedAt = ""
        lastPlayCount = 0
        lastLikeCount = 0
        currentSortBy = sortBy
        lastGameId = 0
        isLastPage = false
    }
    
    func fetchData(_ query: String = "") {
        if currentSortBy != sortBy {
            // sort 방식 변경 시 기존 리스트 리셋
            refreshData()
        }
        
        guard isLastPage == false else { return }
        
        provider.requestPublisher(.gameListByPaging(sortBy, dataPerPage, lastGameId, lastCreatedAt, lastPlayCount, lastLikeCount, searchKeyword))
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
}
