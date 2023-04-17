//
//  ProfileService.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/15.
//

import Foundation

class ProfileService: ObservableObject {
    
    @Published var followCheck = false

    func followingUser(user: User, _ userId: String, completion: @escaping() -> Void) {
        guard let email = FirebaseManager.shared.auth.currentUser?.email else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let userData = ["email": email,
                        "uid": uid]
        
        FirebaseManager.shared.fireStore
            .collection("following")
            .document(uid)
            .collection("following")
            .document(userId)
            .setData(userData)
        
        FirebaseManager.shared.fireStore.collection("users")
            .document(uid)
            .updateData(["following": user.following + 1]) { _ in
                completion()
            }
    }
    
    func followerUser(_ userId: String, completion: @escaping() -> Void) {
        guard let email = FirebaseManager.shared.auth.currentUser?.email else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let userData = ["email": email,
                        "uid": uid]
        
        FirebaseManager.shared.fireStore
            .collection("follower")
            .document(userId)
            .collection("follower")
            .document(uid)
            .setData(userData)
    }
    
}
