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
    
    @Published var nickName = ""
    @Published var text = ""
    @Published var selectedImage: UIImage?
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        FirebaseManager.shared.fireStore.collection("users").document(uid)
            .getDocument { snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                self.nickName = data["nickName"] as! String
        }
    }
    
    func persistImageToStorage() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.selectedImage?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                print("Failed to push image to Storage: \(err)")
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    print("Failed to retrieve downloadURL: \(err)")
                    return
                }
                guard let url = url else { return }
                self.uploadPost(imageURL: url)
            }
        }
    }
    
    func uploadPost(imageURL: URL) {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let postData = ["uid": uid,
                        "nickName": nickName,
                        "text": text,
                        "imageURL": imageURL.absoluteString,
                        "timeStamp": Timestamp(date: Date()),
                        "like": 0,
                        "comment": 0] as [String : Any]
        
        FirebaseManager.shared.fireStore.collection("posts")
            .document().setData(postData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
            }
    }
}
