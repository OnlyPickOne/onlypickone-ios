//
//  CardView.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/08/24.
//

import SwiftUI
import PhotosUI

struct CardView: View {
    @State var showImagePicker: Bool = false
    @ObservedObject var viewModel: AddSheetViewModel
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0..<min(viewModel.imageList.count, 128), id: \.self) { num in
                        ZStack(alignment: .bottom) {
                            Image(uiImage: viewModel.imageList[num])
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
                                    if num == viewModel.imageList.count - 1 {
                                        showImagePicker = true
                                    } else {
                                        viewModel.imageList.remove(at: num)
                                    }
                                }
                            if num != viewModel.imageList.count - 1 {
                                HStack {
                                    TextField("캡션을 입력하세요", text: $viewModel.input[num])
                                        .textFieldStyle(.roundedBorder)
                                        .frame(height: 36)
                                    ZStack {
                                        Color(UIColor.systemBackground)
                                            .frame(width: 80, height: 36)
                                            .cornerRadius(8)
                                        Text("\(num + 1) / \(viewModel.imageList.count - 1)")
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
                PhotoPicker(images: $viewModel.imageList, inputs: $viewModel.input, showImagePicker: $showImagePicker, viewModel: viewModel, selectionLimit: 128)
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

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(input: [""], imageList: [])
//    }
//}
