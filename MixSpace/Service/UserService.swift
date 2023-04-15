//
//  UserService.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/30.
//

import Foundation

struct UserService {
    
    func persistImageToStorage(name: String, nickName: String, introText: String, selectedImage: Data) {

        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        ref.putData(selectedImage, metadata: nil) { metadata, err in
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
                self.editCurrentUser(name: name, nickName: nickName, introText: introText, imageURL: url)
            }
        }
    }
    
    func editCurrentUser(name: String, nickName: String, introText: String, imageURL: URL) {

        guard let email = FirebaseManager.shared.auth.currentUser?.email else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        let userData = ["email": email,
                        "uid": uid,
                        "name": name,
                        "nickName": nickName,
                        "introText": introText,
                        "profileImageURL": imageURL.absoluteString,
                        "postNum": 0,
                        "follower": 0,
                        "following": 0] as [String : Any]

        FirebaseManager.shared.fireStore.collection("users") //users라는 컬렉션을 만든다
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
            }
    }
    
    func editCurrentUserNoProfile(name: String, nickName: String, introText: String) {

        guard let email = FirebaseManager.shared.auth.currentUser?.email else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        let userData = ["email": email,
                        "uid": uid,
                        "name": name,
                        "nickName": nickName,
                        "introText": introText,
                        "profileImageURL": "",
                        "postNum": 0,
                        "follower": 0,
                        "following": 0] as [String : Any]

        FirebaseManager.shared.fireStore.collection("users") //users라는 컬렉션을 만든다
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
            }
    }
    
    
    //MARK: USER
    func fetchCurrentUser(uid: String, completion: @escaping(User) -> Void) {

        FirebaseManager.shared.fireStore.collection("users")
            .document(uid)
            .getDocument { snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                
                guard let user = try? snapshot?.data(as: User.self) else { return }

                completion(user)
        }
    }
    
    //MARK: SEARCH (USERS)
    func fetchUsers(completion: @escaping([User]) -> Void) {
        FirebaseManager.shared.fireStore.collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })

                completion(users)
            }
    }
}

//MARK: Follow 
extension UserService {
    
//    func followingUser(user: User, _ userId: String, completion: @escaping() -> Void) {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//
//        print("uid: \(uid)") //나
//        print("userid: \(userId)") //상대
//        let userfriendsRef = FirebaseManager.shared.fireStore
//            .collection("users")
//            .document(uid)
//            .collection("user-friend")
//
//        FirebaseManager.shared.fireStore.collection("users").document(userId)
//            .updateData(["following": user.following + 1]) { _ in
//                userfriendsRef.document(userId).setData([:]) { _ in
//                    completion()
//                }
//            }
//    }
//
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
//
//    func checkIfUserLikedPost(_ post: Post, completion: @escaping(Bool) -> Void) {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//        guard let postId = post.id else { return }
//
//        FirebaseManager.shared.fireStore
//            .collection("users")
//            .document(uid)
//            .collection("user-likes")
//            .document(postId).getDocument { snapshot, _ in
//                guard let snapshot = snapshot else { return }
//                completion(snapshot.exists)
//            }
//    }
//
//    func fetchLikedPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
//        var posts = [Post]()
//
//        FirebaseManager.shared.fireStore
//            .collection("users")
//            .document(uid)
//            .collection("user-likes")
//            .getDocuments { snapshot, _ in
//                guard let documents = snapshot?.documents else { return }
//
//                documents.forEach { doc in
//                    let postId = doc.documentID
//
//                    FirebaseManager.shared.fireStore
//                        .collection("posts")
//                        .document(postId)
//                        .getDocument { snapshot, _ in
//                            guard let post = try? snapshot?.data(as: Post.self) else { return }
//                            posts.append(post)
//
//                            completion(posts)
//                        }
//                }
//            }
//    }
}
