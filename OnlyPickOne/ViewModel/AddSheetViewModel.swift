//
//  AddSheetViewModel.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/10/12.
//

import Foundation
import UIKit.UIImage

class AddSheetViewModel: ObservableObject {
    @Published var input: [String] = [""]
    @Published var imageList: [UIImage] = [UIImage(named: "picture.add")!]
    
    public func addImage(image: UIImage, caption: String) {
        self.imageList.insert(image, at: self.imageList.count - 1)
        self.input.insert(caption, at: self.imageList.count - 1)
        print(self.imageList.count)
    }
}
