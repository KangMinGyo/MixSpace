//
//  ProfileEditViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/27.
//

import UIKit
import SwiftUI

class ProfileEditViewModel: ObservableObject {
    
    let service = UserService()
    
    @Published var name = ""
    @Published var nickName = ""
    @Published var introText = ""
    @Published var image = ""
    @Published var profileImageURL: URL?
    
    @Published var profileImage: Image?
    @Published var selectedImage: UIImage?
    @Published var croppedImage: UIImage?
    
    @Published var cropperShown = false
    @Published var imagePickerPresented = false
    
    init() {

        fetchCurrentUser()
    }
    
    func editCurrentUser() {
        //프로필 사진도 변경했을 떄
        if let imageData = self.croppedImage?.jpegData(compressionQuality: 0.5) {
            service.persistImageToStorage(name: name, nickName: nickName, introText: introText, selectedImage: imageData)
        } else {
            //프로필 사진은 변경 안했는데 이미 프로필 사진 있을 때
            if profileImageURL != nil {
                service.editCurrentUser(name: name, nickName: nickName, introText: introText, imageURL: profileImageURL!)
                //프로필 사진은 변경 안했는데 프로필 사진도 없을 때
            } else {
                service.editCurrentUserNoProfile(name: name, nickName: nickName, introText: introText)
            }
        }
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        service.fetchCurrentUser(uid: uid) { user in
            self.name = user.name
            self.nickName = user.nickName
            self.introText = user.introText
            self.image = user.profileImageURL
            self.profileImageURL = URL(string: user.profileImageURL)
        }
    }
    
    func loadImage() {
        guard let selectedImage = croppedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        fetchCurrentUser()
    }
    
    func shown() {
        cropperShown = true
    }
}
