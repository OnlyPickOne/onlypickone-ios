//
//  SettingViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/15.
//

import Foundation
import Combine
import Moya
import CombineMoya

class SettingViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    @Published var minimumVersion: String = ""
    @Published var latestVersion: String = ""
    
    func info() {
        provider.requestPublisher(.info)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<Info>.self)
                self.minimumVersion = result?.data.minimum ?? ""
                self.latestVersion = result?.data.latest ?? ""
            }.store(in: &subscription)
    }
}
