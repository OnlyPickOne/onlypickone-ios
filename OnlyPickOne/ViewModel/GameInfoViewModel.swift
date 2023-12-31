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
            print("like cancel")
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
            print("like")
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
        print("report")
        provider.requestPublisher(.report(game.id ?? -1))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.isShowingReportFail = true
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { [weak self] response in
                print(response)
                let result = try? response.map(Response<String>.self)
                if result?.isSuccess == true {
                    print("sucess")
                    completion(true)
                }
            }.store(in: &subscription)
    }
    
    init(game: NewGame?) {
        self.game = game ?? NewGame(id: nil, title: nil, description: nil, viewCount: nil, playCount: nil, likeCount: nil, itemCount: nil, reportCount: nil, createdAt: nil, imageUrls: nil, isCreated: nil, isLiked: nil)
        self.isLiked = game?.isLiked ?? false
    }
}
