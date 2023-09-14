//
//  TestJoke.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/11.
//

import Foundation

struct Joke: Decodable {
    var data: TestData
    var support: Support

    struct TestData: Decodable {
        var id: Int
        var email: String
        var first_name: String
        var last_name: String
        var avatar: String
    }
    
    struct Support: Decodable {
        var url: String
        var text: String
    }
}
