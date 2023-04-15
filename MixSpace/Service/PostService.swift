//
//  PostService.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/30.
//

import UIKit
import Firebase

struct PostService {
    
    func persistImageToStorage(nickName: String, text: String, selectedImage: Data) {
        
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
                self.uploadPost(text: text, imageURL: url)
            }
        }
    }
    
    private func uploadPost(text: String, imageURL: URL) {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let postData = ["uid": uid,
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
    
    func fetchPost(completion: @escaping([Post]) -> Void) {
        FirebaseManager.shared.fireStore
            .collection("posts")
            .order(by: "timeStamp", descending: true)
            .getDocuments { snapshot, err in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap({ try? $0.data(as: Post.self) })
                completion(posts)
            }
    }
    
    func fetchPost(forUid uid: String, completion: @escaping([Post]) -> Void) {
        FirebaseManager.shared.fireStore
            .collection("posts")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, err in
                guard let documents = snapshot?.documents else { return }
                
                let posts = documents.compactMap({ try? $0.data(as: Post.self) })
                completion(posts.sorted(by: { $0.timeStamp > $1.timeStamp }))
            }
    }
}

//MARK: Likes
extension PostService {
    
    func likePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        let userLikesRef = FirebaseManager.shared.fireStore
            .collection("users")
            .document(uid)
            .collection("user-likes")
        
        FirebaseManager.shared.fireStore.collection("posts").document(postId)
            .updateData(["like": post.like + 1]) { _ in
                userLikesRef.document(postId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    func unlikePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        guard post.like > 0 else { return }
        
        let userLikesRef = FirebaseManager.shared.fireStore
            .collection("users")
            .document(uid)
            .collection("user-likes")
        
        FirebaseManager.shared.fireStore.collection("posts").document(postId)
            .updateData(["like": post.like - 1]) { _ in
                userLikesRef.document(postId).delete { _ in
                    completion()
                }
            }
    }
    
    func checkIfUserLikedPost(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        FirebaseManager.shared.fireStore
            .collection("users")
            .document(uid)
            .collection("user-likes")
            .document(postId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        
        FirebaseManager.shared.fireStore
            .collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let postId = doc.documentID
                    
                    FirebaseManager.shared.fireStore
                        .collection("posts")
                        .document(postId)
                        .getDocument { snapshot, _ in
                            guard let post = try? snapshot?.data(as: Post.self) else { return }
                            posts.append(post)
                            
                            completion(posts)
                        }
                }
            }
    }
}
