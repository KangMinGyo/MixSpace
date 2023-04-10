//
//  WritingViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/29.
//

import Firebase
import UIKit
import SwiftUI

class WritingViewModel: ObservableObject {
    
    let service = PostService()
    
    @Published var nickName = ""
    @Published var text = ""
    @Published var profileImage: Image?
    @Published var selectedImage: UIImage?
    @Published var croppedImage: UIImage?
    
    @Published var cropperShown = false
    @Published var imagePickerPresented = false
    
    func uploadPost() {
        guard let imageData = self.croppedImage?.jpegData(compressionQuality: 0.5) else { return }
        
        service.persistImageToStorage(nickName: nickName, text: text, selectedImage: imageData)
    }
    
    func loadImage() {
        guard let selectedImage = croppedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        print("Image : \(String(describing: croppedImage))")
    }
    
    func shown() {
        cropperShown = true
    }
}
