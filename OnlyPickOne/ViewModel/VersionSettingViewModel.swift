//
//  VersionSettingViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/26.
//

import Foundation
import Combine
import Moya
import CombineMoya

class VersionSettingViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    
    public func setVersion(minimum: String?, latest: String?) {
        guard let minimum = minimum, let latest = latest else { return }
        provider.requestPublisher(.setVersion(Info(versionId: nil, minimum: minimum, latest: latest)))
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                }
            } receiveValue: { response in
                let result = try? response.map(Response<String>.self)
            }.store(in: &subscription)
    }
    
    public func isValidVersionString(minimum: String?, latest: String?) -> Bool {
        guard let minimum = minimum, let latest = latest else { return false }
        if NSPredicate(format:"SELF MATCHES %@", "[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}").evaluate(with: minimum)
        && NSPredicate(format:"SELF MATCHES %@", "[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}").evaluate(with: latest) {
            return true
        }
        return false
    }
}
