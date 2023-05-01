//
//  NewMessageViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/01.
//

import Foundation

class NewMessageViewModel: ObservableObject {
    
    let service = ProfileService()
    @Published var users = [ChatUser]()
    
    @Published var errorMessage = ""
    
    init() {
        fetchFollowUser()
    }
    
    private func fetchFollowUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.fireStore
            .collection("following")
            .document(uid)
            .collection("following")
            .getDocuments { documentSnapshot, err in
                if let err = err {
                    print("친구 불러오는거 실패했어잉,,\(err)")
                    return
                }
                documentSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
        
                    let uid = data["uid"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let profileImageURL = data["profileImageURL"] as? String ?? ""
                    self.users.append(.init(uid: uid, name: name, profileImageURL: profileImageURL))
                })
                
                self.errorMessage = "친구목록 불러오기 완료"
            }
    }
}
