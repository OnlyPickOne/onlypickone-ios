//
//  UserListViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2024/02/05.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = [User(userId: 0, email: "test1@naver.com", createdDate: "2024-02-01T00:00", lastRequestDate: "2024-02-01T00:00", isBanned: false,
                                         isLeft: false),
                                    User(userId: 1, email: "test2@naver.com", createdDate: "2024-02-02T00:00", lastRequestDate: "2024-02-02T00:00", isBanned: false, isLeft: true),
                                    User(userId: 2, email: "test3@naver.com", createdDate: "2024-02-03T00:00", lastRequestDate: "2024-02-03T00:00", isBanned: true, isLeft: false),
                                    User(userId: 3, email: "test4@naver.com", createdDate: "2024-02-04T00:00", lastRequestDate: "2024-02-04T00:00", isBanned: false, isLeft: false)
                                    ]
    func fetchUserData() {
        
    }
    
    func blockUser() {
        
    }
    
}
