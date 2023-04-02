//
//  profileViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    let service = UserService()
    
    init() {
        
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        service.fetchCurrentUser(uid: uid) { user in
            self.user = user
        }
    }
}

