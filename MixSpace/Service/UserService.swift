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
    
    private func editCurrentUser(name: String, nickName: String, introText: String, imageURL: URL) {

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
        var users = [User]()
        FirebaseManager.shared.fireStore.collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { document in
                    guard let user = try? document.data(as: User.self) else { return }
                    users.append(user)
                }
                completion(users)
            }
    }
}
