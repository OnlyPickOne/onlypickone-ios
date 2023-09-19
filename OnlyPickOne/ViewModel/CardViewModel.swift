//
//  CardViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/19.
//

import Foundation
import Combine
import Moya
import CombineMoya

class CardViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    @Published var imageUrls: [String] = []
    
}
