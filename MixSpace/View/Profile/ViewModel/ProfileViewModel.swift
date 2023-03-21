//
//  profileViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    
    init() {

        fetchCurrentUser()
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
                
                self.user = .init(data: data)
        }
    }

}

