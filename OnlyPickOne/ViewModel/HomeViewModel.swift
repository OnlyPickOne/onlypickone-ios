//
//  HomeViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/18.
//

import Foundation
import Combine
import Moya
import CombineMoya

class HomeViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    @Published var minimumVersion: String = ""
    @Published var latestVersion: String = ""
    @Published var isNeedToAuth: Bool = true
    @Published var isNeedToUpdate: Bool = false
    @Published var toLeadToUpdate: Bool = false
    
    public func checkToken() -> Bool {
        if UserDefaults.standard.string(forKey: "accessToken") != nil && UserDefaults.standard.string(forKey: "refreshToken") != nil {
            return true
        }
        return false
    }
    
    public func info() {
        provider.requestPublisher(.getVersion)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("error: \(error)")
                case .finished:
                    print("request finished")
                    self.checkCurrentVersion()
                }
            } receiveValue: { response in
                let result = try? response.map(Response<Info>.self)
                self.minimumVersion = result?.data?.minimum ?? ""
                self.latestVersion = result?.data?.latest ?? ""
            }.store(in: &subscription)
    }
    
    private func versionCompare(current: String, minimum: String, latest: String) -> Update {
        let currentVersionNumber = current.components(separatedBy: ".").map { Int($0) ?? 0 }
        let minimumVersionNumber = minimum.components(separatedBy: ".").map { Int($0) ?? 0 }
        let latestVersionNumber = latest.components(separatedBy: ".").map { Int($0) ?? 0 }
        
        for i in 0 ..< currentVersionNumber.count {
            if currentVersionNumber[i] > latestVersionNumber[i] {
                return .upToDate
            }
            if currentVersionNumber[i] < minimumVersionNumber[i] {
                return .need
            }
            if currentVersionNumber[i] < latestVersionNumber[i] {
                return .outOfDate
            }
        }
        
        return .upToDate
    }
    
    public func checkCurrentVersion() {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        guard let appVersion = appVersion, let appBuildNumber = appBuildNumber else { return }
        let comleteAppVersion = appVersion + "." + appBuildNumber
        switch versionCompare(current: comleteAppVersion, minimum: minimumVersion, latest: latestVersion) {
        case .need:
            self.isNeedToUpdate = true
        case .outOfDate:
            self.toLeadToUpdate = true
        default:
            self.isNeedToUpdate = false
            self.toLeadToUpdate = false
        }
        print(self.isNeedToUpdate, self.toLeadToUpdate)
    }
    
    init(subscription: Set<AnyCancellable> = Set<AnyCancellable>(), isAuthorized: Bool = false) {
        self.subscription = subscription
        self.isNeedToAuth = isAuthorized
//        self.info()
    }
}

fileprivate enum Update {
    case need
    case outOfDate
    case upToDate
}
