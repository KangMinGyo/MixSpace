//
//  WritingViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/29.
//

import Foundation
import Firebase
import UIKit

class WritingViewModel: ObservableObject {
    
    let service = PostService()
    
    @Published var nickName = ""
    @Published var text = ""
    @Published var selectedImage: UIImage?
    
    func uploadPost() {
        guard let imageData = self.selectedImage?.jpegData(compressionQuality: 0.5) else { return }
        
        service.persistImageToStorage(nickName: nickName, text: text, selectedImage: imageData)
    }

}
