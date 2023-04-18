//
//  ProfileService.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/15.
//

import Foundation

class ProfileService: ObservableObject {
    
    @Published var followCheck = false

    func followingUser(user: User, postUser: User, completion: @escaping() -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userId = postUser.uid
        
        let userData = ["email": postUser.email,
                        "uid": postUser.uid,
                        "name": postUser.name,
                        "nickName": postUser.nickName,
                        "introText": postUser.introText,
                        "profileImageURL": postUser.profileImageURL,
                        "postNum": postUser.postNum,
                        "follower": postUser.follower,
                        "following": postUser.following] as [String : Any]
        
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
    
    func followerUser(user: User, postUser: User, completion: @escaping() -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userId = postUser.uid
        
        let userData = ["email": user.email,
                        "uid": user.uid,
                        "name": user.name,
                        "nickName": user.nickName,
                        "introText": user.introText,
                        "profileImageURL": user.profileImageURL,
                        "postNum": user.postNum,
                        "follower": user.follower,
                        "following": user.following] as [String : Any]
        
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

    func fetchFollowing(completion: @escaping([User]) -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.fireStore
            .collection("following")
            .document(uid)
            .collection("following")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                completion(users)
            }
    }
    
    func fetchFollower(completion: @escaping([User]) -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.fireStore
            .collection("follower")
            .document(uid)
            .collection("follower")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                completion(users)
            }
    }
}
