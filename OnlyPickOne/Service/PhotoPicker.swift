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
//    let configuration: PHPickerConfiguration
//    let numOfSelectedPictures: Int
//    @Binding var isPresented: Bool
//    @Binding var images: [UIImage?]
//
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        let controller = PHPickerViewController(configuration: configuration)
//        controller.delegate = context.coordinator
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    // Use a Coordinator to act as your PHPickerViewControllerDelegate
//    class Coordinator: PHPickerViewControllerDelegate {
//        private let parent: PhotoPicker
//
//        init(_ parent: PhotoPicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
////            print(results)
////            print("ASDFFDSDFS")
////            parent.isPresented = false // Set isPresented to false because picking has finished.
//            picker.dismiss(animated: true, completion: nil)
//
//            guard let provider = results.first?.itemProvider else { return }
//
//            if provider.canLoadObject(ofClass: UIImage.self) {
//                provider.loadObject(ofClass: UIImage.self) { image, _ in
////                    self.parent.image = image as? UIImage
//                    images.append(image as? UIImage)
//                }
//            }
//        }
//    }
    
    typealias UIViewControllerType = PHPickerViewController
    
    @Binding var images: [UIImage]
    @Binding var inputs: [String]
    @Binding var showImagePicker: Bool
    
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
            //Dismiss picker
            picker.dismiss(animated: true)
            
            if !results.isEmpty {
                parent.itemProviders = []
//                parent.images = [UIImage(named: "street")!]
            }
            
            parent.itemProviders = results.map(\.itemProvider)
            loadImage()
        }
        
        private func loadImage() {
            for itemProvider in parent.itemProviders {
                if self.parent.images.count > self.parent.maxCount { return }
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            self.parent.images.insert(image, at: self.parent.images.count - 1)
                            self.parent.inputs.insert("", at: self.parent.images.count - 1)
                        } else {
                            print("Could not load image", error?.localizedDescription ?? "")
                        }
                    }
                }
            }
//            parent.showImagePicker = false
        }
        
    }
}
