//
//  PhotoPicker.swift
//  OnlyPickOne
//
//  Created by 한태희 on 2023/09/19.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    
    @Binding var images: [UIImage]
    @Binding var inputs: [String]
    @Binding var showImagePicker: Bool
    @ObservedObject var viewModel: AddSheetViewModel
    
    var maxCount: Int = 128
    var selectionLimit: Int
    var filter: PHPickerFilter?
    var itemProviders: [NSItemProvider] = []
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = self.selectionLimit
        configuration.filter = self.filter
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return PhotoPicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
        
        var parent: PhotoPicker
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            if !results.isEmpty {
                parent.itemProviders = []
            }
            
            parent.itemProviders = results.map(\.itemProvider)
            loadImage()
        }
        
        private func loadImage() {
            for itemProvider in parent.itemProviders {
                if self.parent.images.count > self.parent.maxCount { return }
                
                itemProvider.loadImage { image, error in
                    DispatchQueue.main.async{
                        if let image = image {
                            DispatchQueue.main.async{
                                self.parent.viewModel.addImage(image: image, caption: "")
                            }
                        } else {
                            print("Could not load image", error?.localizedDescription ?? "")
                        }
                    }
                }
            }
        }
        
    }
}
