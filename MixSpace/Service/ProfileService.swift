//
//  ProfileService.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/15.
//

import Foundation

class ProfileService: ObservableObject {
    
    @Published var followCheck = false

    func followingUser(user: User, userId: String, completion: @escaping() -> Void) {
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
    
    func followerUser(user: User, userId: String, completion: @escaping() -> Void) {
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
        
        FirebaseManager.shared.fireStore.collection("users")
            .document(userId)
            .updateData(["follower": user.follower + 1]) { _ in
                completion()
            }
    }
    
    func unfollowingUser(user: User, userId: String, completion: @escaping() -> Void) {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard user.following > 0 else { return }
        
        let userfollowRef = FirebaseManager.shared.fireStore
            .collection("following")
            .document(userId)
            .collection("following")
        
        FirebaseManager.shared.fireStore.collection("users")
            .document(uid)
            .updateData(["following": user.following - 1]) { _ in
                userfollowRef.document(userId).delete() { _ in
                    completion()
                }
            }
    }
    
    func unfollowerUser(user: User, userId: String, completion: @escaping() -> Void) {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard user.follower > 0 else { return }
        
        let userfollowRef = FirebaseManager.shared.fireStore
            .collection("follower")
            .document(userId)
            .collection("follower")
        
        FirebaseManager.shared.fireStore.collection("users")
            .document(uid)
            .updateData(["follower": user.follower - 1]) { _ in
                userfollowRef.document(uid).delete() { _ in
                    completion()
                }
            }
    }
    
//    func unlikePost(_ post: Post, completion: @escaping() -> Void) {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//        guard let postId = post.id else { return }
//        guard post.like > 0 else { return }
//
//        let userLikesRef = FirebaseManager.shared.fireStore
//            .collection("users")
//            .document(uid)
//            .collection("user-likes")
//
//        FirebaseManager.shared.fireStore.collection("posts").document(postId)
//            .updateData(["like": post.like - 1]) { _ in
//                userLikesRef.document(postId).delete { _ in
//                    completion()
//                }
//            }
//    }
    
    func checkFollowState(userId: String, completion: @escaping(Bool) -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.fireStore
            .collection("following")
            .document(uid)
            .collection("following")
            .document(userId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }

    
}
