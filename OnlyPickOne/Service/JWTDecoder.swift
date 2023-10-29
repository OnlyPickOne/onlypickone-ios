//
//  JWTDecoder.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/18.
//

import Foundation
import JWTDecode

class JWTDecoder: ObservableObject {
    @Published var isAdmin: Bool = false
    public var userId: Int = -1
    
    public func checkToken() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return }
        let jwt = try? decode(jwt: accessToken)
        if let auth = jwt?["auth"].string, auth == "ROLE_ADMIN" {
            self.isAdmin = true
        }
        if let uid = jwt?["sub"].string {
            self.userId = Int(uid) ?? -1
        }
    }
    
    init() {
        self.checkToken()
    }
}
