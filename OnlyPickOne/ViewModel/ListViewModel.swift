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
    @Published var gameList: [Game] = [Game(id: 0, title: "첫번째 테스트용 게임", description: "짧은 설명입니다", createdTime: 1230, items: []),
                                       Game(id: 0, title: "두번째 테스트용 게임", description: "안녕하세요. 망한/웃긴/귀여운 고양이들 사진중 원하는 사진을 고르시면 됩니다. 중복이 있으면 바로말해주세요. (자료출처: 구글 이미지, 유튜브 타임스낵과 다양한 동물의 짤, 네이버 카페, 인스타그램, 제작자) (업데이트: ○)", createdTime: 50020, items: [])]
    
    @Published var testString: String = ""
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    func test() {
        
        provider.requestPublisher(.test)
            .sink { completion in
                switch completion {
                case let .failure(error) :
                    print("LogIn Fail : " + error.localizedDescription)
                case .finished :
                    print("LogIn Finished")
                }
            } receiveValue: { recievedValue in
                let result = try? recievedValue.map(Joke.self)
                print(result?.data.email ?? "")
                self.testString = result?.data.email ?? ""
            }.store(in : &subscription)
    }
    
    init(testString: String, subscription: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.testString = testString
        self.subscription = subscription
        test()
    }
}
