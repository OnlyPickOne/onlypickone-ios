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
    private let provider = MoyaProvider<APIService>(session: Session(interceptor: AuthInterceptor.shared))
    
    @Published var minimumVersion: String = ""
    @Published var latestVersion: String = ""
    @Published var isNeedToAuth: Bool = true
    @Published var isNeedToUpdate: Bool = false
    @Published var toLeadToUpdate: Bool = false
    
    public func checkToken() -> Bool {
        if UserDefaults.standard.string(forKey: "accessToken") != nil && UserDefaults.standard.string(forKey: "refreshToken") != nil {
            self.isNeedToAuth = false
            return true
        }
        self.isNeedToAuth = true
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
                }
            } receiveValue: { response in
                let result = try? response.map(Response<Info>.self)
                self.minimumVersion = result?.data?.minimum ?? ""
                self.latestVersion = result?.data?.latest ?? ""
                self.checkCurrentVersion()
            }.store(in: &subscription)
    }
    
    private func versionCompare(current: String, minimum: String, latest: String) -> Update {
        let currentVersionNumber = current.components(separatedBy: ".").map { Int($0) ?? 0 }
        let minimumVersionNumber = minimum.components(separatedBy: ".").map { Int($0) ?? 0 }
        let latestVersionNumber = latest.components(separatedBy: ".").map { Int($0) ?? 0 }
        
        for i in 0 ..< latestVersionNumber.count {
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
    }
    
    init() {
        self.info()
        self.checkToken()
    }
}

fileprivate enum Update {
    case need
    case outOfDate
    case upToDate
}
