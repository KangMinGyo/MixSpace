//
//  SideMenuViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/18.
//

import Foundation
import Firebase

class SideMenuViewModel: ObservableObject {
    
    let service = UserService()
    
    @Published var name = ""
    @Published var nickName = ""
    
    init() {
        fetchCurrentUser()
    }
    
    func logout() {
        DispatchQueue.global(qos: .background).async {
            try? Auth.auth().signOut()
        }
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        service.fetchCurrentUser(uid: uid) { user in
            self.name = user.name
            self.nickName = user.nickName
        }
    }
}
