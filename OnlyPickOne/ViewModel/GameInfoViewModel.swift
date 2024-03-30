//
//  GameInfoViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/12.
//

import Foundation
import Moya
import Combine

class GameInfoViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    private let decoder = JWTDecoder()
    
    @Published var game: NewGame
    @Published var isLiked: Bool = false
    @Published var isShowingReportSucess: Bool = false
    @Published var isShowingReportFail: Bool = false
    @Published var selectionOption = 0
    @Published var isMember: Bool = false
    
    let gameId: Int
    
    public func checkMember() {
        isMember = UserDefaults.standard.string(forKey: "accessToken") != nil
    }
    
    func fetchGameInfo() {
        provider.requestPublisher(.gameInfo(self.gameId))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { [weak self] response in
                let result = try? response.map(Response<NewGame>.self)
                if result?.isSuccess == true {
                    if let game = result?.data {
                        self?.game = game
//                        switch self?.game.itemCount ?? 0 {
//                        case 5...8:
//                            self?.selectionOption = 0
//                        case 9...16:
//                            self?.selectionOption = 1
//                        case 17...32:
//                            self?.selectionOption = 2
//                        case 33...150:
//                            self?.selectionOption = 3
//                        default:
//                            self?.selectionOption = 0
//                        }
                    }
                }
            }.store(in: &subscription)
    }
    
    public func deleteGame(completion: @escaping (Bool) -> ()) {
        provider.requestPublisher(.remove(game.id ?? -1))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<String>.self)
                if result?.isSuccess == true {
                    completion(true)
                }
            }.store(in: &subscription)
    }
    
    public func likeGame() {
        if self.isLiked {
            provider.requestPublisher(.deleteLike(game.id ?? -1))
                .sink { completion in
                    switch completion {
                    case let .failure(error):
                        print("error: \(error)")
                    case .finished:
                        print("request finished")
                    }
                } receiveValue: { response in
                    let result = try? response.map(Response<String>.self)
                    if result?.isSuccess == true {
                        print("sucess")
                        self.isLiked = false
                    }
                }.store(in: &subscription)
        } else {
            provider.requestPublisher(.like(game.id ?? -1))
                .sink { completion in
                    switch completion {
                    case let .failure(error):
                        print("error: \(error)")
                    case .finished:
                        print("request finished")
                    }
                } receiveValue: { [weak self] response in
                    let result = try? response.map(Response<String>.self)
                    if result?.isSuccess == true {
                        print("sucess")
                        self?.isLiked = true
                    }
                }.store(in: &subscription)
        }
    }
    
    public func reportGamte(completion: @escaping (Bool) -> ()) {
        provider.requestPublisher(.report(game.id ?? -1))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.isShowingReportFail = true
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<String>.self)
                if result?.isSuccess == true {
                    completion(true)
                }
            }.store(in: &subscription)
    }
    
    init(subscription: Set<AnyCancellable> = Set<AnyCancellable>(), game: NewGame = NewGame(id: 0, title: "", description: "", viewCount: 0, playCount: 0, likeCount: 0, itemCount: 0, reportCount: 0, createdAt: "", imageUrls: ["",""], isCreated: false, isLiked: false), isLiked: Bool = false, isShowingReportSucess: Bool = false, isShowingReportFail: Bool = false, gameId: Int) {
        self.subscription = subscription
        self.game = game
        self.isLiked = isLiked
        self.isShowingReportSucess = isShowingReportSucess
        self.isShowingReportFail = isShowingReportFail
        self.gameId = gameId
    }
}
