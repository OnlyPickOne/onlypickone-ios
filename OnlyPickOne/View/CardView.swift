//
//  CardView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/24.
//

import SwiftUI
import PhotosUI

struct CardView: View {
    @State var input: [String]
//    @State var images: [String]
    @State var imageList: [UIImage]
    @State var showImagePicker: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                Button("add") {
                    showImagePicker = true
                }
                HStack(spacing: 0) {
                    ForEach(0..<min(imageList.count, 128), id: \.self) { num in
                        ZStack(alignment: .bottom) {
                            Image(uiImage: imageList[num])
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width - 40, height: 300)
                                .clipped()
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(white: 0.4))
                                )
                                .shadow(radius: 10)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                            if num != imageList.count - 1 {
                                HStack {
                                    TextField("캡션을 입력하세요", text: $input[num])
                                        .textFieldStyle(.roundedBorder)
                                        .frame(height: 36)
                                    ZStack {
                                        Color(UIColor.systemBackground)
                                            .frame(width: 80, height: 36)
                                            .cornerRadius(8)
                                        Text("\(num + 1) / \(imageList.count - 1)")
                                    }
                                }
                                .padding(20)
                            }
                        }
                        .padding(20)
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
//                let configuration: PHPickerConfiguration = {
//                    var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
//                    config.selectionLimit = 128
//                    config.filter = .images
//                    return config
//                }()
//                PhotoPicker(configuration: configuration, isPresented: $showImagePicker, images: $imageList)
                PhotoPicker(images: $imageList, inputs: $input, showImagePicker: $showImagePicker, selectionLimit: 128)
            }
        }
        .onAppear {
            UIScrollView.appearance().isPagingEnabled = true
        }
        .onDisappear {
            UIScrollView.appearance().isPagingEnabled = false
        }
    }
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 125
        
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 125
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        
        return scale
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(input: [""], imageList: [])
    }
}

//struct Movie : Identifiable {
//    var id : Int
//    var title : String
//    var imageName : String
//}

//var latestmovie = [Movie(id: 0, title: "The Avengers", imageName: "street"),
//                   Movie(id: 1, title: "cat1", imageName: "cat1"),
//                   Movie(id: 2, title: "cat2", imageName: "cat2"),
//                   Movie(id: 3, title: "football", imageName: "football")]
