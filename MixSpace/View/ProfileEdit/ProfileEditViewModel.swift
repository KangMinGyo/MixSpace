//
//  ProfileEditViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/27.
//

import Foundation

class ProfileEditViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var nickName = ""
    @Published var introText = ""
    
    init() {

        fetchCurrentUser()
    }
    
    func editCurrentUser() {
        guard let email = FirebaseManager.shared.auth.currentUser?.email else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": email, "uid": uid, "name": name, "nickName": nickName, "introText": introText, "postNum": 0, "follower": 0, "following": 0] as [String : Any]
        FirebaseManager.shared.fireStore.collection("users") //users라는 컬렉션을 만든다
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
            }
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        FirebaseManager.shared.fireStore.collection("users").document(uid)
            .getDocument { snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                
                self.name = data["name"] as! String
                self.nickName = data["nickName"] as! String
                self.introText = data["introText"] as! String
        }
    }
}
