//
//  AddSheetViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/12.
//

import Foundation
import Moya
import Combine
import UIKit.UIImage

class AddSheetViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private let provider = MoyaProvider<APIService>()
    
    @Published var titleInput: String = ""
    @Published var detailInput: String = ""
    @Published var input: [String] = ["nothing"]
    @Published var imageList: [UIImage] = [UIImage(named: "picture.add")!]
    @Published var isShowingAddSheet: Bool = false
    @Published var isShowingAlertBlankCaption: Bool = false
    @Published var isMember: Bool = false
    
    public func checkMember() {
        isMember = UserDefaults.standard.string(forKey: "accessToken") != nil
    }
    
    public func addImage(image: UIImage, caption: String) {
        self.imageList.insert(image, at: self.imageList.count - 1)
        self.input.insert(caption, at: self.input.count - 1)
    }
    
    public func submitGame() {
        self.isShowingAddSheet = false
        
        refeshToken { [self] in
            var multipartFiles: [Item] = []
            for i in 0..<self.imageList.count - 1 {
                let item = Item(id: nil, caption: self.input[i], image: self.imageList[i])
                multipartFiles.append(item)
            }
            
            provider.requestPublisher(.create(titleInput, detailInput, multipartFiles))
                .sink { completion in
                    switch completion {
                    case let .failure(error):
                        print("error: \(error)")
                    case .finished:
                        print("request finished")
                        self.resetValue()
                    }
                } receiveValue: { response in
                    let result = try? response.map(Response<String>.self)
                    print(result?.message ?? "")
                }.store(in: &subscription)
        }
    }
    
    public func resetValue() {
        self.input = ["nothing"]
        self.imageList = [UIImage(named: "picture.add")!]
        self.titleInput = ""
        self.detailInput = ""
    }
    
    private func refeshToken(completion: @escaping () -> ()) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken"), let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return }
        
        provider.request(.refreshToken(LoginToken(grantType: nil, accessToken: accessToken, refreshToken: refreshToken, accessTokenExpiresIn: nil))) { (result) in
            switch result {
            case let .success(response):
                let result = try? response.map(Response<LoginToken>.self)
                UserDefaults.standard.set(result?.data?.accessToken ?? "", forKey: "accessToken")
                UserDefaults.standard.set(result?.data?.refreshToken ?? "", forKey: "refreshToken")
                completion()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
