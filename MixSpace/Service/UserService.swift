//
//  UserService.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/30.
//

import Foundation

struct UserService {
    
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
}
