//
//  MainMessageViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/29.
//

import Foundation

class MainMessageViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    @Published var shouldShowNewMessageScreen = false
    
    let service = UserService()
    
    init() {
        fetchCurrentUser()
    }
    
//    func fetchCurrentUser() {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//        service.fetchCurrentUser(uid: uid) { user in
//            self.user = user
//        }
//    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "파베에 uid가 없어잉"
            return
        }
        
        FirebaseManager.shared.fireStore.collection("users").document(uid)
            .getDocument { snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                
                let uid = data["uid"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let profileImageURL = data["profileImageURL"] as? String ?? ""
                self.chatUser = ChatUser(uid: uid, name: name, profileImageURL: profileImageURL)

        }
    }
}
